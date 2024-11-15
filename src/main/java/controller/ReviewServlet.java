package controller;

import database.ReviewDAO;
import database.TourDAO;
import models.Review;
import models.Tour;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;
    private TourDAO tourDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
        tourDAO = new TourDAO();
    }

    // Handle GET requests for displaying review form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("user");
        if (role == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            Tour tour = tourDAO.getTourById(tourId);

            if (tour != null) {
                request.setAttribute("tour", tour);
                request.getRequestDispatcher("review/reviewForm.jsp").forward(request, response);
            } else {
                response.sendRedirect("TourServlet?action=list");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for submitting reviews
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            insertReview(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Insert a new review into the database
    private void insertReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        // Get the current user (tourist) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"user".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        int tourId = Integer.parseInt(request.getParameter("tourId"));
        String comment = request.getParameter("comment").trim();
        String ratingStr = request.getParameter("rating");

        // Validate inputs
        if (comment.isEmpty() || ratingStr.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("review/reviewForm.jsp").forward(request, response);
            return;
        }

        int rating = Integer.parseInt(ratingStr);

        Review review = new Review(tourId, userId, comment, rating, new Date());

        boolean success = reviewDAO.createReview(review);

        if (success) {
            response.sendRedirect("TourServlet?id=" + tourId);
        } else {
            request.setAttribute("errorMessage", "An error occurred while submitting the review.");
            request.getRequestDispatcher("review/reviewForm.jsp").forward(request, response);
        }
    }
}
