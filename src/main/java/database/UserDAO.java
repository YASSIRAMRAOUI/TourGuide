package database;

import models.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    // Method to check if an email is already registered
    public boolean isEmailRegistered(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0; // Returns true if count > 0
                }
            }
        }
        return false;
    }

    // Method to register a new user
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, password, phone_number, image_path, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getPhoneNumber());
            statement.setString(5, user.getImagePath());
            statement.setString(6, user.getRole());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Method to retrieve a user by email (used for login)
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    User user = new User();
                    user.setUserId(resultSet.getInt("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPassword(resultSet.getString("password"));
                    user.setPhoneNumber(resultSet.getString("phone_number"));
                    user.setImagePath(resultSet.getString("image_path"));
                    user.setRole(resultSet.getString("role"));
                    return user;
                }
            }
        }
        return null;
    }

    // Method to save a password reset token for a user
    public void savePasswordResetToken(int userId, String token) throws SQLException {
        String sql = "INSERT INTO password_reset_tokens (user_id, token, created_at) VALUES (?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setString(2, token);
            statement.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            statement.executeUpdate();
        }
    }

    // Method to verify a password reset token
    public boolean verifyPasswordResetToken(String token) throws SQLException {
        String sql = "SELECT created_at FROM password_reset_tokens WHERE token = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Timestamp createdAt = resultSet.getTimestamp("created_at");
                    LocalDateTime tokenTime = createdAt.toLocalDateTime();

                    // Check if the token is still valid (e.g., within 24 hours)
                    if (ChronoUnit.HOURS.between(tokenTime, LocalDateTime.now()) <= 24) {
                        return true;
                    } else {
                        // Token expired, so delete it
                        deletePasswordResetToken(token);
                    }
                }
            }
        }
        return false;
    }

    // Method to update the user's password using a reset token
    public void updatePassword(String token, String newPassword) throws SQLException {
        String getUserSql = "SELECT user_id FROM password_reset_tokens WHERE token = ?";
        String updatePasswordSql = "UPDATE users SET password = ? WHERE user_id = ?";
        String deleteTokenSql = "DELETE FROM password_reset_tokens WHERE token = ?";

        Connection connection = DatabaseConnection.getConnection();
        try {
            connection.setAutoCommit(false);

            int userId = -1;
            try (PreparedStatement getUserStmt = connection.prepareStatement(getUserSql)) {
                getUserStmt.setString(1, token);
                try (ResultSet resultSet = getUserStmt.executeQuery()) {
                    if (resultSet.next()) {
                        userId = resultSet.getInt("user_id");
                    }
                }
            }

            if (userId != -1) {
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

                try (PreparedStatement updatePasswordStmt = connection.prepareStatement(updatePasswordSql)) {
                    updatePasswordStmt.setString(1, hashedPassword);
                    updatePasswordStmt.setInt(2, userId);
                    updatePasswordStmt.executeUpdate();
                }

                try (PreparedStatement deleteTokenStmt = connection.prepareStatement(deleteTokenSql)) {
                    deleteTokenStmt.setString(1, token);
                    deleteTokenStmt.executeUpdate();
                }

                connection.commit();
            } else {
                throw new SQLException("Invalid password reset token.");
            }

        } catch (SQLException e) {
            connection.rollback(); // Rollback transaction if there's an error
            throw e;
        } finally {
            connection.setAutoCommit(true); // Reset auto-commit mode
            connection.close();
        }
    }

    // Helper method to delete expired or used tokens
    private void deletePasswordResetToken(String token) throws SQLException {
        String sql = "DELETE FROM password_reset_tokens WHERE token = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            statement.executeUpdate();
        }
    }

    // Method to update a user's profile
    public boolean updateUserProfile(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, password = ?, phone_number = ?, image_path = ? WHERE user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getPhoneNumber());
            statement.setString(5, user.getImagePath());
            statement.setInt(6, user.getUserId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to get all users
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setPhoneNumber(resultSet.getString("phone_number"));
                user.setImagePath(resultSet.getString("image_path"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
        }
        return users;
    }

    // Method to update a user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, phone_number = ?, image_path = ? WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPhoneNumber());
            statement.setString(4, user.getImagePath());
            statement.setInt(5, user.getUserId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to delete a user
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to get a user by ID
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    User user = new User();
                    user.setUserId(resultSet.getInt("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPassword(resultSet.getString("password"));
                    user.setPhoneNumber(resultSet.getString("phone_number"));
                    user.setImagePath(resultSet.getString("image_path"));
                    user.setRole(resultSet.getString("role"));
                    return user;
                }
            }
        }
        return null;
    }

    // Method to get users by role
    public List<User> getUsersByRole(String role) throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, role);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setPhoneNumber(resultSet.getString("phone_number"));
                user.setImagePath(resultSet.getString("image_path"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
        }
        return users;
    }

    public List<User> searchUsersByNameOrEmail(String query) throws SQLException {
        String sql = "SELECT * FROM users WHERE role = 'user' AND (name LIKE ? OR email LIKE ?)";
        List<User> users = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setRole(rs.getString("role"));
                    user.setImagePath(rs.getString("image_path"));
                    users.add(user);
                }
            }
        }
        return users;
    }

}
