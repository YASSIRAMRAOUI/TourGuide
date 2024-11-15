package database;

import models.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    // Retrieve All Comments
    public List<Comment> getAllComments() throws SQLException {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM comments";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Comment comment = new Comment();
                comment.setCommentId(resultSet.getInt("comment_id"));
                comment.setUserId(resultSet.getInt("user_id"));
                comment.setTourId(resultSet.getInt("tour_id"));
                comment.setContent(resultSet.getString("content"));
                comment.setCommentDate(resultSet.getDate("comment_date"));
                comments.add(comment);
            }
        }
        return comments;
    }

    // Delete Comment
    public boolean deleteComment(int commentId) throws SQLException {
        String sql = "DELETE FROM comments WHERE comment_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, commentId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Retrieve Recent Comments
    public List<Comment> getRecentComments(int limit) throws SQLException {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.name AS userName FROM comments c JOIN users u ON c.user_id = u.user_id ORDER BY c.comment_date DESC LIMIT ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, limit);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Comment comment = new Comment();
                comment.setCommentId(resultSet.getInt("comment_id"));
                comment.setUserId(resultSet.getInt("user_id"));
                comment.setTourId(resultSet.getInt("tour_id"));
                comment.setContent(resultSet.getString("content"));
                comment.setCommentDate(resultSet.getTimestamp("comment_date"));
                comment.setUserName(resultSet.getString("userName"));
                comments.add(comment);
            }
        }
        return comments;
    }
}
