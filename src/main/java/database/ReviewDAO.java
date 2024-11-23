package database;

import models.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // Method to create a new review
    public boolean createReview(Review review) throws SQLException {
        String sql = "INSERT INTO reviews (tour_id, user_id, comment, rating, review_date) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, review.getTourId());
            statement.setInt(2, review.getUserId());
            statement.setString(3, review.getComment());
            statement.setInt(4, review.getRating());
            statement.setDate(5, new java.sql.Date(review.getReviewDate().getTime()));

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve generated review_id
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    review.setReviewId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Method to get a review by ID
    public Review getReviewById(int reviewId) throws SQLException {
        String sql = "SELECT * FROM reviews WHERE review_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, reviewId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Review review = new Review();
                    review.setReviewId(resultSet.getInt("review_id"));
                    review.setTourId(resultSet.getInt("tour_id"));
                    review.setUserId(resultSet.getInt("user_id"));
                    review.setComment(resultSet.getString("comment"));
                    review.setRating(resultSet.getInt("rating"));
                    review.setReviewDate(resultSet.getDate("review_date"));
                    return review;
                }
            }
        }
        return null;
    }

    // Method to get all reviews
    public List<Review> getAllReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.review_id, r.comment, r.rating, r.review_date, " +
                "t.title AS tourTitle, u.name AS userName, u.email AS userEmail, u.image_path AS userImagePath " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.user_id " +
                "JOIN tours t ON r.tour_id = t.tour_id " +
                "ORDER BY r.review_date DESC";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Review review = new Review();
                review.setReviewId(resultSet.getInt("review_id"));
                review.setComment(resultSet.getString("comment"));
                review.setRating(resultSet.getInt("rating"));
                review.setReviewDate(resultSet.getDate("review_date"));
                review.setUserName(resultSet.getString("userName"));
                review.setUserEmail(resultSet.getString("userEmail"));
                review.setTourTitle(resultSet.getString("tourTitle"));
                review.setUserImagePath(resultSet.getString("userImagePath"));
                reviews.add(review);
            }
        }
        return reviews;
    }

    // Method to get reviews by tour ID
    public List<Review> getReviewsByTourId(int tourId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name AS userName " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.user_id " +
                "WHERE r.tour_id = ? " +
                "ORDER BY r.review_date DESC"; // Optional: Order by date

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, tourId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Review review = new Review();
                review.setReviewId(resultSet.getInt("review_id"));
                review.setUserId(resultSet.getInt("user_id"));
                review.setTourId(resultSet.getInt("tour_id"));
                review.setComment(resultSet.getString("comment"));
                review.setRating(resultSet.getInt("rating"));
                review.setReviewDate(resultSet.getDate("review_date"));
                review.setUserName(resultSet.getString("userName")); // Set userName
                reviews.add(review);
            }
        }

        return reviews;
    }

    // Method to get reviews by user ID
    public List<Review> getReviewsByUserId(int userId) throws SQLException {
        String sql = "SELECT r.*, t.title AS tour_title FROM reviews r JOIN tours t ON r.tour_id = t.tour_id WHERE r.user_id = ?";
        List<Review> reviews = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Review review = new Review();
                    review.setReviewId(resultSet.getInt("review_id"));
                    review.setTourId(resultSet.getInt("tour_id"));
                    review.setUserId(resultSet.getInt("user_id"));
                    review.setComment(resultSet.getString("comment"));
                    review.setRating(resultSet.getInt("rating"));
                    review.setTourTitle(resultSet.getString("tour_title"));
                    review.setReviewDate(resultSet.getDate("review_date"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    // Method to update a review
    public boolean updateReview(Review review) throws SQLException {
        String sql = "UPDATE reviews SET tour_id = ?, user_id = ?, comment = ?, rating = ?, review_date = ? WHERE review_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, review.getTourId());
            statement.setInt(2, review.getUserId());
            statement.setString(3, review.getComment());
            statement.setInt(4, review.getRating());
            statement.setDate(5, new java.sql.Date(review.getReviewDate().getTime()));
            statement.setInt(6, review.getReviewId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to delete a review
    public boolean deleteReview(int reviewId) throws SQLException {
        String sql = "DELETE FROM reviews WHERE review_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, reviewId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
