package database;

import models.Activity;
import models.Tour;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {

    // Create Activity
    public boolean createActivity(Activity activity) throws SQLException {
        String activitySql = "INSERT INTO activities (name, description, image_path) VALUES (?, ?, ?)";
        String relationSql = "INSERT INTO activity_tour (activity_id, tour_id) VALUES (?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement activityStmt = connection.prepareStatement(activitySql,
                        Statement.RETURN_GENERATED_KEYS);
                PreparedStatement relationStmt = connection.prepareStatement(relationSql)) {

            // Insert activity
            activityStmt.setString(1, activity.getName());
            activityStmt.setString(2, activity.getDescription());
            activityStmt.setString(3, activity.getImagePath());
            int rows = activityStmt.executeUpdate();

            if (rows > 0) {
                ResultSet generatedKeys = activityStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int activityId = generatedKeys.getInt(1);
                    activity.setActivityId(activityId);

                    // Check if there are any associated tours
                    if (activity.getAssociatedTours() != null && !activity.getAssociatedTours().isEmpty()) {
                        // Insert activity-tour associations
                        for (Tour tour : activity.getAssociatedTours()) {
                            relationStmt.setInt(1, activityId);
                            relationStmt.setInt(2, tour.getTourId());
                            relationStmt.addBatch();
                        }
                        relationStmt.executeBatch();
                    }
                }
                return true;
            }
        }
        return false;
    }

    // Retrieve All Activities
    public List<Activity> getAllActivities() throws SQLException {
        String sql = "SELECT a.activity_id, a.name, a.description, a.image_path, " +
                "t.tour_id, t.title AS tourTitle, t.image_path AS tourImagePath " +
                "FROM activities a " +
                "LEFT JOIN activity_tour at ON a.activity_id = at.activity_id " +
                "LEFT JOIN tours t ON at.tour_id = t.tour_id";

        List<Activity> activities = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                int activityId = resultSet.getInt("activity_id");

                // Check if activity already exists in the list
                Activity activity = activities.stream()
                        .filter(a -> a.getActivityId() == activityId)
                        .findFirst()
                        .orElseGet(() -> {
                            Activity newActivity = new Activity();
                            newActivity.setActivityId(activityId);
                            try {
                                newActivity.setName(resultSet.getString("name"));
                                newActivity.setDescription(resultSet.getString("description"));
                                newActivity.setImagePath(resultSet.getString("image_path"));
                                newActivity.setAssociatedTours(new ArrayList<>());
                                activities.add(newActivity);
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            return newActivity;
                        });

                // Add associated tours, if any
                int tourId = resultSet.getInt("tour_id");
                if (tourId > 0) {
                    Tour tour = new Tour();
                    tour.setTourId(tourId);
                    tour.setTitle(resultSet.getString("tourTitle"));
                    tour.setImagePath(resultSet.getString("tourImagePath")); // Include imagePath
                    activity.getAssociatedTours().add(tour);
                }
            }
        }
        return activities;
    }

    // Update Activity
    public boolean updateActivity(Activity activity) throws SQLException {
        String activitySql = "UPDATE activities SET name = ?, description = ?, image_path = ? WHERE activity_id = ?";
        String deleteRelationSql = "DELETE FROM activity_tour WHERE activity_id = ?";
        String insertRelationSql = "INSERT INTO activity_tour (activity_id, tour_id) VALUES (?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement activityStmt = connection.prepareStatement(activitySql);
                PreparedStatement deleteRelationStmt = connection.prepareStatement(deleteRelationSql);
                PreparedStatement insertRelationStmt = connection.prepareStatement(insertRelationSql)) {

            // Update activity details
            activityStmt.setString(1, activity.getName());
            activityStmt.setString(2, activity.getDescription());
            activityStmt.setString(3, activity.getImagePath());
            activityStmt.setInt(4, activity.getActivityId());
            activityStmt.executeUpdate();

            // Update relations
            deleteRelationStmt.setInt(1, activity.getActivityId());
            deleteRelationStmt.executeUpdate();

            for (Tour tour : activity.getAssociatedTours()) {
                insertRelationStmt.setInt(1, activity.getActivityId());
                insertRelationStmt.setInt(2, tour.getTourId());
                insertRelationStmt.addBatch();
            }
            insertRelationStmt.executeBatch();
            return true;
        }
    }

    // Delete Activity
    public boolean deleteActivity(int activityId) throws SQLException {
        String deleteRelationsSql = "DELETE FROM activity_tour WHERE activity_id = ?";
        String deleteActivitySql = "DELETE FROM activities WHERE activity_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
            PreparedStatement deleteRelationsStmt = connection.prepareStatement(deleteRelationsSql);
            PreparedStatement deleteActivityStmt = connection.prepareStatement(deleteActivitySql)) {

            // Delete associated rows in activity_tour
            deleteRelationsStmt.setInt(1, activityId);
            deleteRelationsStmt.executeUpdate();

            // Delete the activity itself
            deleteActivityStmt.setInt(1, activityId);
            int rowsAffected = deleteActivityStmt.executeUpdate();
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
                    activity.setImagePath(resultSet.getString("image_path"));
                    return activity;
                }
            }
        }
        return null;
    }

    // Retrieve Activities By Tour Id
    public List<Activity> getActivitiesByTourId(int tourId) throws SQLException {
        String sql = "SELECT a.activity_id, a.name, a.description, a.image_path " +
                "FROM activities a " +
                "JOIN activity_tour at ON a.activity_id = at.activity_id " +
                "WHERE at.tour_id = ?";
        List<Activity> activities = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, tourId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Activity activity = new Activity();
                    activity.setActivityId(resultSet.getInt("activity_id"));
                    activity.setName(resultSet.getString("name"));
                    activity.setDescription(resultSet.getString("description"));
                    activity.setImagePath(resultSet.getString("image_path"));
                    activities.add(activity);
                }
            }
        }
        return activities;
    }

    // Retrieve Activities By Tour Id
    public Activity getActivityByIdWithTours(int activityId) throws SQLException {
        String sql = "SELECT a.activity_id, a.name, a.description, a.image_path, " +
                "t.tour_id, t.title AS tourTitle, t.image_path AS tourImagePath " +
                "FROM activities a " +
                "LEFT JOIN activity_tour at ON a.activity_id = at.activity_id " +
                "LEFT JOIN tours t ON at.tour_id = t.tour_id " +
                "WHERE a.activity_id = ?";

        Activity activity = null;
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, activityId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    if (activity == null) {
                        activity = new Activity();
                        activity.setActivityId(resultSet.getInt("activity_id"));
                        activity.setName(resultSet.getString("name"));
                        activity.setDescription(resultSet.getString("description"));
                        activity.setImagePath(resultSet.getString("image_path"));
                        activity.setAssociatedTours(new ArrayList<>());
                    }

                    int tourId = resultSet.getInt("tour_id");
                    if (tourId > 0) {
                        Tour tour = new Tour();
                        tour.setTourId(tourId);
                        tour.setTitle(resultSet.getString("tourTitle"));
                        tour.setImagePath(resultSet.getString("tourImagePath")); // Include imagePath
                        activity.getAssociatedTours().add(tour);
                    }
                }
            }
        }
        return activity;
    }
}
