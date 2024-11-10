package database;

import models.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

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
        String sql = "INSERT INTO users (name, email, password, phone_number, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword()); // Store hashed password
            statement.setString(4, user.getPhoneNumber());
            statement.setString(5, user.getRole());

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
            connection.setAutoCommit(false); // Begin transaction

            // Get the user associated with the token
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
                // Hash the new password before saving it
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

                // Update the user's password with the hashed password
                try (PreparedStatement updatePasswordStmt = connection.prepareStatement(updatePasswordSql)) {
                    updatePasswordStmt.setString(1, hashedPassword);
                    updatePasswordStmt.setInt(2, userId);
                    updatePasswordStmt.executeUpdate();
                }

                // Delete the token after updating the password
                try (PreparedStatement deleteTokenStmt = connection.prepareStatement(deleteTokenSql)) {
                    deleteTokenStmt.setString(1, token);
                    deleteTokenStmt.executeUpdate();
                }

                connection.commit(); // Commit transaction
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

}
