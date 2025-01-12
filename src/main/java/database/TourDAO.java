package database;

import models.Tour;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {

    // Method to create a new tour
    public boolean createTour(Tour tour) throws SQLException {
        String sql = "INSERT INTO tours (title, description, location, date, price, guide_id, image_path, map_embed_code, category) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, tour.getTitle());
            statement.setString(2, tour.getDescription());
            statement.setString(3, tour.getLocation());
            statement.setDate(4, new java.sql.Date(tour.getDate().getTime()));
            statement.setDouble(5, tour.getPrice());
            statement.setInt(6, tour.getGuideId());
            statement.setString(7, tour.getImagePath());
            statement.setString(8, tour.getMapEmbedCode());
            statement.setString(9, tour.getCategory());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    tour.setTourId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Method to get a tour by its ID
    public Tour getTourById(int tourId) throws SQLException {
        String sql = "SELECT * FROM tours WHERE tour_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, tourId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Tour tour = new Tour();
                    tour.setTourId(resultSet.getInt("tour_id"));
                    tour.setTitle(resultSet.getString("title"));
                    tour.setDescription(resultSet.getString("description"));
                    tour.setLocation(resultSet.getString("location"));
                    tour.setDate(resultSet.getDate("date"));
                    tour.setPrice(resultSet.getDouble("price"));
                    tour.setGuideId(resultSet.getInt("guide_id"));
                    tour.setImagePath(resultSet.getString("image_path"));
                    tour.setMapEmbedCode(resultSet.getString("map_embed_code"));
                    tour.setCategory(resultSet.getString("category"));
                    return tour;
                }
            }
        }
        return null;
    }

    // Method to get all tours
    public List<Tour> getAllTours() throws SQLException {
        String sql = "SELECT * FROM tours";
        List<Tour> tours = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Tour tour = new Tour();
                tour.setTourId(resultSet.getInt("tour_id"));
                tour.setTitle(resultSet.getString("title"));
                tour.setDescription(resultSet.getString("description"));
                tour.setLocation(resultSet.getString("location"));
                tour.setDate(resultSet.getDate("date"));
                tour.setPrice(resultSet.getDouble("price"));
                tour.setGuideId(resultSet.getInt("guide_id"));
                tour.setImagePath(resultSet.getString("image_path"));
                tour.setMapEmbedCode(resultSet.getString("map_embed_code"));
                tour.setCategory(resultSet.getString("category"));
                tours.add(tour);
            }
        }
        return tours;
    }

    // Method to update a tour
    public boolean updateTour(Tour tour) throws SQLException {
        String sql = "UPDATE tours SET title = ?, description = ?, location = ?, date = ?, price = ?, guide_id = ?, image_path = ?, map_embed_code = ?, category = ? WHERE tour_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, tour.getTitle());
            statement.setString(2, tour.getDescription());
            statement.setString(3, tour.getLocation());
            statement.setDate(4, new java.sql.Date(tour.getDate().getTime()));
            statement.setDouble(5, tour.getPrice());
            statement.setInt(6, tour.getGuideId());
            statement.setString(7, tour.getImagePath());
            statement.setString(8, tour.getMapEmbedCode());
            statement.setString(9, tour.getCategory());
            statement.setInt(10, tour.getTourId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to delete a tour
    public boolean deleteTour(int tourId) throws SQLException {
        String sql = "DELETE FROM tours WHERE tour_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, tourId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to get tours by category
    public List<Tour> getToursByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM tours WHERE category = ?";
        List<Tour> tours = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, category);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Tour tour = new Tour();
                    tour.setTourId(resultSet.getInt("tour_id"));
                    tour.setTitle(resultSet.getString("title"));
                    tour.setDescription(resultSet.getString("description"));
                    tour.setLocation(resultSet.getString("location"));
                    tour.setDate(resultSet.getDate("date"));
                    tour.setPrice(resultSet.getDouble("price"));
                    tour.setGuideId(resultSet.getInt("guide_id"));
                    tour.setImagePath(resultSet.getString("image_path"));
                    tour.setMapEmbedCode(resultSet.getString("map_embed_code"));
                    tour.setCategory(resultSet.getString("category"));
                    tours.add(tour);
                }
            }
        }
        return tours;
    }
}
