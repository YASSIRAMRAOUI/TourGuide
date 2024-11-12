package controller;

import database.ReservationDAO;
import database.TourDAO;
import models.Reservation;
import models.Tour;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private TourDAO tourDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
        tourDAO = new TourDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("new".equals(action)) {
                showNewReservationForm(request, response);
            } else if ("list".equals(action)) {
                listReservations(request, response);
            } else {
                response.sendRedirect("TourServlet?action=list");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for creating reservations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if ("insert".equals(request.getParameter("action"))) {
                insertReservation(request, response);
            } else {
                response.sendRedirect("TourServlet?action=list");
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    // Display form for creating a new reservation
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

    // Insert a new reservation into the database
    private void insertReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {

        // Get the current user (tourist) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"user".equalsIgnoreCase(role)) {
            response.sendRedirect("LoginServlet");
            return;
        }

        int tourId = Integer.parseInt(request.getParameter("tourId"));
        String reservationDateStr = request.getParameter("reservationDate");
        String numberOfPeopleStr = request.getParameter("numberOfPeople");

        // Validate inputs
        if (reservationDateStr.isEmpty() || numberOfPeopleStr.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date reservationDate = formatter.parse(reservationDateStr);
        int numberOfPeople = Integer.parseInt(numberOfPeopleStr);

        Reservation reservation = new Reservation(tourId, userId, reservationDate, numberOfPeople, "Pending");

        boolean success = reservationDAO.createReservation(reservation);

        if (success) {
            response.sendRedirect("ReservationServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "An error occurred while creating the reservation.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
        }
    }

    // List reservations for the current user
    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        // Get the current user from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        request.setAttribute("reservations", reservationDAO.getReservationsByUserId(userId));
        request.getRequestDispatcher("reservation/reservationList.jsp").forward(request, response);
    }

}
