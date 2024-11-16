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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;
    private TourDAO tourDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
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
            Integer userId = (Integer) session.getAttribute("user_id");

            switch (action) {
                case "new":
                    if ("user".equalsIgnoreCase(role)) {
                        showNewForm(request, response);
                    }
                    break;
                case "listAll":
                    if ("admin".equalsIgnoreCase(role)) {
                        listAllReviews(request, response);
                    }
                    break;
                case "list":
                    if ("user".equalsIgnoreCase(role)) {
                        listUserReviews(request, response, userId);
                    }
                    break;
                case "edit":
                    if ("user".equalsIgnoreCase(role)) {
                        showEditForm(request, response);
                    }
                    break;
                case "delete":
                    if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                        deleteReview(request, response);
                    }
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for inserting and updating reviews
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");

            if ("insert".equals(action) && "user".equalsIgnoreCase(role)) {
                insertReview(request, response);
            } else if ("update".equals(action) && "user".equalsIgnoreCase(role)) {
                updateReview(request, response);
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    // ----------- User Operations -----------

    // Check if the user is logged in
    private boolean isUserLoggedIn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return false;
        }
        return true;
    }

    // Show form to create a new review (User)
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String tourIdStr = request.getParameter("tourId");
        if (tourIdStr == null || tourIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/tours?action=list");
            return;
        }

        int tourId;
        try {
            tourId = Integer.parseInt(tourIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/tours?action=list");
            return;
        }

        Tour tour = tourDAO.getTourById(tourId);
        if (tour != null) {
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("review/reviewForm.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/tours?action=list");
        }
    }

    // Insert a new review (User)
    private void insertReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException, ParseException {
        if (!isUserLoggedIn(request, response)) {
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String userName = (String) session.getAttribute("username");

        String tourIdStr = request.getParameter("tourId");
        String comment = request.getParameter("comment");
        String ratingStr = request.getParameter("rating");
        String reviewDateStr = request.getParameter("reviewDate");

        // Validate inputs
        if (tourIdStr == null || comment == null || ratingStr == null || comment.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            showNewForm(request, response);
            return;
        }

        int tourId;
        int rating;
        Date reviewDate;
        String userEmail = (String) session.getAttribute("email");
        String tourTitle = request.getParameter("tourTitle");

        try {
            tourId = Integer.parseInt(tourIdStr);
            rating = Integer.parseInt(ratingStr);
            if (rating < 1 || rating > 5) {
                throw new NumberFormatException("Rating must be between 1 and 5.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Tour ID or Rating.");
            showNewForm(request, response);
            return;
        }

        try {
            if (reviewDateStr == null || reviewDateStr.trim().isEmpty()) {
                reviewDate = new Date(); // Default to the current date if reviewDate is missing
            } else {
                reviewDate = new SimpleDateFormat("yyyy-MM-dd").parse(reviewDateStr);
            }
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid Date Format.");
            showNewForm(request, response);
            return;
        }

        Review review = new Review(tourId, userId, comment, rating, reviewDate, userName, userEmail, tourTitle);
        boolean success = reviewDAO.createReview(review);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list&tourId=" + tourId);
        } else {
            request.setAttribute("errorMessage", "An error occurred while submitting your review.");
            showNewForm(request, response);
        }
    }

    // List reviews for the current user
    private void listUserReviews(HttpServletRequest request, HttpServletResponse response, int userId)
            throws SQLException, ServletException, IOException {
        List<Review> reviews = reviewDAO.getReviewsByUserId(userId);
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("review/reviewList.jsp").forward(request, response);
    }

    // ----------- Admin Operations -----------

    // List all reviews (Admin)
    private void listAllReviews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Review> reviews = reviewDAO.getAllReviews();
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("review/reviewList.jsp").forward(request, response);
    }

    // Show edit form for a review (user)
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String reviewIdStr = request.getParameter("id");
        if (reviewIdStr == null || reviewIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list");
            return;
        }

        int reviewId;
        try {
            reviewId = Integer.parseInt(reviewIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list");
            return;
        }

        Review review = reviewDAO.getReviewById(reviewId);
        if (review == null) {
            response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list");
            return;
        }

        request.setAttribute("review", review);
        request.getRequestDispatcher("review/reviewForm.jsp").forward(request, response);
    }

    // Update a review (user)
    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException, ParseException {
        String reviewIdStr = request.getParameter("reviewId");
        String comment = request.getParameter("comment");
        String ratingStr = request.getParameter("rating");

        if (reviewIdStr == null || comment == null || ratingStr == null
                || reviewIdStr.trim().isEmpty() || comment.trim().isEmpty()
                || ratingStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            showEditForm(request, response);
            return;
        }

        int reviewId;
        int rating;

        try {
            reviewId = Integer.parseInt(reviewIdStr);
            rating = Integer.parseInt(ratingStr);
            if (rating < 1 || rating > 5) {
                throw new NumberFormatException("Rating must be between 1 and 5.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Review ID or Rating.");
            showEditForm(request, response);
            return;
        }

        Review existingReview = reviewDAO.getReviewById(reviewId);
        if (existingReview == null) {
            response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list");
            return;
        }

        existingReview.setComment(comment);
        existingReview.setRating(rating);

        boolean success = reviewDAO.updateReview(existingReview);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/ReviewServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the review.");
            showEditForm(request, response);
        }
    }

    // Delete a review
    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String reviewIdStr = request.getParameter("id");
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (reviewIdStr == null || reviewIdStr.trim().isEmpty()) {
            redirectToList(role, response);
            return;
        }

        int reviewId;
        try {
            reviewId = Integer.parseInt(reviewIdStr);
        } catch (NumberFormatException e) {
            redirectToList(role, response);
            return;
        }

        // Delete the review
        boolean success = reviewDAO.deleteReview(reviewId);
        if (success) {
            // Redirect based on role
            redirectToList(role, response);
        } else {
            // Handle the error case if deletion fails
            request.setAttribute("errorMessage", "Failed to delete the review.");
            redirectToList(role, response);
        }
    }

    // Helper method to redirect users based on their role
    private void redirectToList(String role, HttpServletResponse response) throws IOException {
        if ("admin".equalsIgnoreCase(role)) {
            response.sendRedirect("ReviewServlet?action=listAll");
        } else if ("user".equalsIgnoreCase(role)) {
            response.sendRedirect("ReviewServlet?action=list");
        } else {
            response.sendRedirect("auth/login.jsp"); // Redirect to login if role is missing or invalid
        }
    }

}
