package database;

import models.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    // Method to send a message
    public boolean sendMessage(Message message) throws SQLException {
        String sql = "INSERT INTO messages (sender_id, receiver_id, content, timestamp) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, message.getSenderId());
            statement.setInt(2, message.getReceiverId());
            statement.setString(3, message.getContent());
            statement.setTimestamp(4, new Timestamp(message.getTimestamp().getTime()));

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve generated message_id
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    message.setMessageId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Method to get a message by ID
    public Message getMessageById(int messageId) throws SQLException {
        String sql = "SELECT * FROM messages WHERE message_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, messageId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Message message = new Message();
                    message.setMessageId(resultSet.getInt("message_id"));
                    message.setSenderId(resultSet.getInt("sender_id"));
                    message.setReceiverId(resultSet.getInt("receiver_id"));
                    message.setContent(resultSet.getString("content"));
                    message.setTimestamp(resultSet.getTimestamp("timestamp"));
                    return message;
                }
            }
        }
        return null;
    }

    // Method to get messages between two users
    public List<Message> getMessagesBetweenUsers(int userId1, int userId2) throws SQLException {
        String sql = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp ASC";
        List<Message> messages = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId1);
            statement.setInt(2, userId2);
            statement.setInt(3, userId2);
            statement.setInt(4, userId1);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Message message = new Message();
                    message.setMessageId(resultSet.getInt("message_id"));
                    message.setSenderId(resultSet.getInt("sender_id"));
                    message.setReceiverId(resultSet.getInt("receiver_id"));
                    message.setContent(resultSet.getString("content"));
                    message.setTimestamp(resultSet.getTimestamp("timestamp"));
                    messages.add(message);
                }
            }
        }
        return messages;
    }

    // Method to delete a message
    public boolean deleteMessage(int messageId) throws SQLException {
        String sql = "DELETE FROM messages WHERE message_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, messageId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
