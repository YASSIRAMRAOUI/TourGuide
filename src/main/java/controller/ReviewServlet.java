package controller;

import database.ReviewDAO;
import database.ReservationDAO;
import models.Reservation;
import models.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
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
                case "list":
                    if (userId != null) {
                        listUserReviews(request, response, userId);
                    } else {
                        response.sendRedirect("auth/login.jsp");
                    }
                    break;
                case "listAll":
                    if ("admin".equalsIgnoreCase(role)) {
                        listAllReviews(request, response);
                    } else {
                        response.sendRedirect("auth/login.jsp");
                    }
                    break;
                case "delete":
                    deleteReview(request, response, userId, role);
                    break;
                case "insert":
                    String tourIdParam = request.getParameter("tourId");
                    String tourTitle = request.getParameter("tourTitle");

                    request.setAttribute("tourId", tourIdParam);
                    request.setAttribute("tourTitle", tourTitle);

                    request.getRequestDispatcher("review/reviewForm.jsp").forward(request, response);
                    break;
                    case "listReservationsWithReviews":
                    if (userId != null) {
                        checkReviewStatus(request, userId);
                        request.getRequestDispatcher("review/reviewList.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("auth/login.jsp");
                    }
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("user_id");

            if ("insert".equals(action) && userId != null) {
                insertReview(request, response, userId);
            } else {
                response.sendRedirect("auth/login.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listUserReviews(HttpServletRequest request, HttpServletResponse response, int userId)
            throws SQLException, ServletException, IOException {
        List<Review> reviews = reviewDAO.getReviewsByUserId(userId);
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("review/reviewList.jsp").forward(request, response);
    }

    private void listAllReviews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Review> reviews = reviewDAO.getAllReviews();
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("review/reviewList.jsp").forward(request, response);
    }

    private void insertReview(HttpServletRequest request, HttpServletResponse response, int userId)
            throws SQLException, IOException {
        String tourIdParam = request.getParameter("tourId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        try {
            int tourId = Integer.parseInt(tourIdParam);
            int rating = Integer.parseInt(ratingParam);
            LocalDate reviewDate = LocalDate.now();

            // Check if the user has already reviewed this tour
            if (reviewDAO.hasUserReviewed(userId, tourId)) {
                response.sendRedirect("review/reviewForm.jsp?error=You have already reviewed this tour.");
                return;
            }

            Review review = new Review(tourId, userId, comment, rating, reviewDate);
            boolean isInserted = reviewDAO.createReview(review);

            if (isInserted) {
                response.sendRedirect("ReviewServlet?action=list");
            } else {
                response.sendRedirect("review/reviewForm.jsp?error=Failed to save review.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("review/reviewForm.jsp?error=Please select a valid rating");
        }
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response, Integer userId, String role)
            throws SQLException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));

        boolean isDeleted = false;
        if ("admin".equalsIgnoreCase(role)) {
            // Admin can delete any review
            isDeleted = reviewDAO.deleteReview(reviewId);
        } else if ("user".equalsIgnoreCase(role) && userId != null) {
            // User can only delete their own reviews
            isDeleted = reviewDAO.deleteUserReview(reviewId, userId);
        }

        if (isDeleted) {
            response.sendRedirect("ReviewServlet?action=" + ("admin".equalsIgnoreCase(role) ? "listAll" : "list"));
        } else {
            response.sendRedirect("review/reviewList.jsp?error=Failed to delete review.");
        }
    }

    private void checkReviewStatus(HttpServletRequest request, int userId) throws SQLException {
        ReservationDAO reservationDAO = new ReservationDAO();
        List<Reservation> reservations = reservationDAO.getReservationsByUserId(userId);
    
        for (Reservation reservation : reservations) {
            boolean hasReviewed = reviewDAO.hasUserReviewed(userId, reservation.getTourId());
            reservation.setHasReviewed(hasReviewed); // Ensure this is being set
        }
    
        request.setAttribute("reservations", reservations);
    }

}
