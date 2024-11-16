package controller;

import database.ReservationDAO;
import database.UserDAO;
import database.TourDAO;
import models.Reservation;
import models.User;
import models.Tour;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private UserDAO userDAO;
    private TourDAO tourDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
        userDAO = new UserDAO();
        tourDAO = new TourDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");

            switch (action) {
                case "edit":
                    if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                        showEditForm(request, response);
                    }
                    break;
                case "delete":
                    if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                        deleteReservation(request, response);
                    }
                    break;
                case "listAll":
                    if ("admin".equalsIgnoreCase(role)) {
                        listAllReservations(request, response);
                    }
                    break;

                case "new":
                    if ("user".equalsIgnoreCase(role)) {
                        showNewReservationForm(request, response);
                    }
                    break;
                case "list":
                    if ("user".equalsIgnoreCase(role)) {
                        listUserReservations(request, response);
                    }
                    break;

                default:
                    response.sendRedirect("HomeServlet"); // Redirect to home or appropriate page
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for creating and updating reservations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            String role = (String) request.getSession().getAttribute("role");

            if ("update".equals(action)) {
                if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                    updateReservation(request, response);
                }
            } else if ("insert".equals(action)) {
                if ("user".equalsIgnoreCase(role)) {
                    insertReservation(request, response);
                }
            } else {
                response.sendRedirect("HomeServlet");
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    // ----------- Admin Operations -----------

    // List all reservations (Admin)
    private void listAllReservations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Reservation> reservations = reservationDAO.getAllReservations();
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("reservation/reservationList.jsp").forward(request, response);
    }

    // Show edit form for a reservation (Admin)
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        List<User> users = userDAO.getAllUsers();
        List<Tour> tours = tourDAO.getAllTours();
        request.setAttribute("reservation", reservation);
        request.setAttribute("users", users);
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
    }

    // Update a reservation
    private void updateReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException, ParseException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("user_id");

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        Reservation existingReservation = reservationDAO.getReservationById(reservationId);

        // Allow users to update only their reservations
        if ("user".equalsIgnoreCase(role)
                && (existingReservation == null || existingReservation.getUserId() != userId)) {
            response.sendRedirect("ReservationServlet?action=list");
            return;
        }

        String tourIdStr = request.getParameter("tourId");
        String reservationDateStr = request.getParameter("reservationDate");
        String numberOfPeopleStr = request.getParameter("numberOfPeople");
        String status = request.getParameter("status");

        // Validate inputs
        if (tourIdStr == null || reservationDateStr == null || numberOfPeopleStr == null ||
                tourIdStr.trim().isEmpty() || reservationDateStr.trim().isEmpty()
                || numberOfPeopleStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            forwardToEditForm(request, response, reservationId);
            return;
        }

        // Parse inputs
        int tourId = Integer.parseInt(tourIdStr);
        Date reservationDate = new SimpleDateFormat("yyyy-MM-dd").parse(reservationDateStr);
        int numberOfPeople = Integer.parseInt(numberOfPeopleStr);

        // Update Reservation object
        Reservation updatedReservation = new Reservation();
        updatedReservation.setReservationId(reservationId);
        updatedReservation.setTourId(tourId);
        updatedReservation.setReservationDate(reservationDate);
        updatedReservation.setNumberOfPeople(numberOfPeople);

        if ("admin".equalsIgnoreCase(role)) {
            updatedReservation.setUserId(Integer.parseInt(request.getParameter("userId")));
            updatedReservation.setStatus(status);
        } else {
            updatedReservation.setUserId(userId); // Ensure users cannot update the user ID
            updatedReservation.setStatus(existingReservation.getStatus()); // Preserve the status for users
        }

        // Update the reservation in the database
        boolean success = reservationDAO.updateReservation(updatedReservation);

        if (success) {
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("ReservationServlet?action=listAll");
            } else {
                response.sendRedirect("ReservationServlet?action=list");
            }
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the reservation.");
            forwardToEditForm(request, response, reservationId);
        }
    }

    // Delete a reservation
    private void deleteReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("user_id");

        int reservationId = Integer.parseInt(request.getParameter("id"));
        Reservation reservation = reservationDAO.getReservationById(reservationId);

        if (reservation == null) {
            response.sendRedirect("ReservationServlet?action=list");
            return;
        }

        // Allow admin to delete any reservation or user to delete only their own
        // reservation
        if ("admin".equalsIgnoreCase(role) || (userId != null && userId.equals(reservation.getUserId()))) {
            reservationDAO.deleteReservation(reservationId);
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("ReservationServlet?action=listAll");
            } else {
                response.sendRedirect("ReservationServlet?action=list");
            }
        } else {
            response.sendRedirect("ReservationServlet?action=list"); // Redirect if user is not authorized
        }
    }

    // Helper method to forward to edit form with reservation data
    private void forwardToEditForm(HttpServletRequest request, HttpServletResponse response, int reservationId)
            throws SQLException, ServletException, IOException {
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        List<User> users = userDAO.getAllUsers();
        List<Tour> tours = tourDAO.getAllTours();
        request.setAttribute("reservation", reservation);
        request.setAttribute("users", users);
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
    }

    // ----------- User Operations -----------

    // List reservations for the current user
    private void listUserReservations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        // Get the current user from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        List<Reservation> reservations = reservationDAO.getReservationsByUserId(userId);
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("reservation/reservationList.jsp").forward(request, response);
    }

    // Show form to create a new reservation (User)
    private void showNewReservationForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int tourId = Integer.parseInt(request.getParameter("tourId"));
        Tour tour = tourDAO.getTourById(tourId);

        if (tour != null) {
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
        } else {
            response.sendRedirect("TourServlet?action=list");
        }
    }

    // Insert a new reservation (User)
    private void insertReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {

        // Get the current user (tourist) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"user".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        // Retrieve parameters safely
        String tourIdStr = request.getParameter("tourId");
        String reservationDateStr = request.getParameter("reservationDate");
        String numberOfPeopleStr = request.getParameter("numberOfPeople");

        // Validate inputs
        if (tourIdStr == null || tourIdStr.trim().isEmpty() ||
                reservationDateStr == null || reservationDateStr.trim().isEmpty() ||
                numberOfPeopleStr == null || numberOfPeopleStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        // Parse inputs with additional error handling
        int tourId;
        int numberOfPeople;
        Date reservationDate;

        try {
            tourId = Integer.parseInt(tourIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Tour ID.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        try {
            numberOfPeople = Integer.parseInt(numberOfPeopleStr);
            if (numberOfPeople <= 0) {
                throw new NumberFormatException("Number of people must be greater than zero.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Number of People. Please enter a positive integer.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        try {
            reservationDate = new SimpleDateFormat("yyyy-MM-dd").parse(reservationDateStr);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid Reservation Date.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        // Create and populate Reservation object
        Reservation reservation = new Reservation();
        reservation.setTourId(tourId);
        reservation.setUserId(userId);
        reservation.setReservationDate(reservationDate);
        reservation.setNumberOfPeople(numberOfPeople);
        reservation.setStatus("Pending"); // Default status

        // Insert reservation into the database
        boolean success = reservationDAO.createReservation(reservation);

        if (success) {
            response.sendRedirect("ReservationServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "An error occurred while creating the reservation.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
        }
    }

}
