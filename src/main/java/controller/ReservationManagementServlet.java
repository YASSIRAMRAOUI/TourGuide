package controller;

import database.ReservationDAO;
import models.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ReservationManagementServlet")
public class ReservationManagementServlet extends HttpServlet {

    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            if (role == null || !"admin".equalsIgnoreCase(role)) {
                response.sendRedirect("auth/login.jsp");
                return;
            }

            String action = request.getParameter("action");
            if ("edit".equals(action)) {
                showEditForm(request, response);
            } else if ("delete".equals(action)) {
                deleteReservation(request, response);
            } else {
                listReservations(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for updating reservations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if ("update".equals(request.getParameter("action"))) {
                updateReservation(request, response);
            } else {
                response.sendRedirect("ReservationManagementServlet");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // List all reservations
    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Reservation> reservations = reservationDAO.getAllReservations();
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("reservation/reservationManagementList.jsp").forward(request, response);
    }

    // Show edit form for a reservation
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        request.setAttribute("reservation", reservation);
        request.getRequestDispatcher("reservation/reservationManagementForm.jsp").forward(request, response);
    }

    // Update a reservation
    private void updateReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        int tourId = Integer.parseInt(request.getParameter("tourId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String status = request.getParameter("status");

        Reservation reservation = new Reservation();
        reservation.setReservationId(reservationId);
        reservation.setTourId(tourId);
        reservation.setUserId(userId);
        reservation.setStatus(status);

        boolean success = reservationDAO.updateReservation(reservation);

        if (success) {
            response.sendRedirect("ReservationManagementServlet");
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the reservation.");
            request.getRequestDispatcher("reservation/reservationManagementForm.jsp").forward(request, response);
        }
    }

    // Delete a reservation
    private void deleteReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));
        reservationDAO.deleteReservation(reservationId);
        response.sendRedirect("ReservationManagementServlet");
    }
}
