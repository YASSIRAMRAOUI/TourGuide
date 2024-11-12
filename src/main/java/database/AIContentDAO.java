package database;

import models.AIContent;
import java.sql.*;

public class AIContentDAO {

    // Method to create new AIContent
    public boolean createAIContent(AIContent aiContent) throws SQLException {
        String sql = "INSERT INTO ai_content (tour_id, generated_description) VALUES (?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, aiContent.getTourId());
            statement.setString(2, aiContent.getGeneratedDescription());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve generated content_id
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    aiContent.setContentId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Method to get AIContent by ID
    public AIContent getAIContentById(int contentId) throws SQLException {
        String sql = "SELECT * FROM ai_content WHERE content_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, contentId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    AIContent aiContent = new AIContent();
                    aiContent.setContentId(resultSet.getInt("content_id"));
                    aiContent.setTourId(resultSet.getInt("tour_id"));
                    aiContent.setGeneratedDescription(resultSet.getString("generated_description"));
                    return aiContent;
                }
            }
        }
        return null;
    }

    // Method to get AIContent by tour ID
    public AIContent getAIContentByTourId(int tourId) throws SQLException {
        String sql = "SELECT * FROM ai_content WHERE tour_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, tourId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    AIContent aiContent = new AIContent();
                    aiContent.setContentId(resultSet.getInt("content_id"));
                    aiContent.setTourId(resultSet.getInt("tour_id"));
                    aiContent.setGeneratedDescription(resultSet.getString("generated_description"));
                    return aiContent;
                }
            }
        }
        return null;
    }

    // Method to update AIContent
    public boolean updateAIContent(AIContent aiContent) throws SQLException {
        String sql = "UPDATE ai_content SET tour_id = ?, generated_description = ? WHERE content_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, aiContent.getTourId());
            statement.setString(2, aiContent.getGeneratedDescription());
            statement.setInt(3, aiContent.getContentId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to delete AIContent
    public boolean deleteAIContent(int contentId) throws SQLException {
        String sql = "DELETE FROM ai_content WHERE content_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, contentId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
