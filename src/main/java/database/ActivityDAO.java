package database;

import models.Activity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {

    // Create Activity
    public boolean createActivity(Activity activity) throws SQLException {
        String sql = "INSERT INTO activities (name, description, tour_id) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, activity.getName());
            statement.setString(2, activity.getDescription());
            statement.setInt(3, activity.getTourId());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    activity.setActivityId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Retrieve All Activities
    public List<Activity> getAllActivities() throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT * FROM activities";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Activity activity = new Activity();
                activity.setActivityId(resultSet.getInt("activity_id"));
                activity.setName(resultSet.getString("name"));
                activity.setDescription(resultSet.getString("description"));
                activity.setTourId(resultSet.getInt("tour_id"));
                activities.add(activity);
            }
        }
        return activities;
    }

    // Update Activity
    public boolean updateActivity(Activity activity) throws SQLException {
        String sql = "UPDATE activities SET name = ?, description = ?, tour_id = ? WHERE activity_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, activity.getName());
            statement.setString(2, activity.getDescription());
            statement.setInt(3, activity.getTourId());
            statement.setInt(4, activity.getActivityId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete Activity
    public boolean deleteActivity(int activityId) throws SQLException {
        String sql = "DELETE FROM activities WHERE activity_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, activityId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Retrieve Activity By Id
    public Activity getActivityById(int activityId) throws SQLException {
        String sql = "SELECT * FROM activities WHERE activity_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, activityId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Activity activity = new Activity();
                    activity.setActivityId(resultSet.getInt("activity_id"));
                    activity.setName(resultSet.getString("name"));
                    activity.setDescription(resultSet.getString("description"));
                    activity.setTourId(resultSet.getInt("tour_id"));
                    return activity;
                }
            }
        }
        return null;
    }
}
