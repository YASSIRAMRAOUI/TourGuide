package database;

import models.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // Method to create a new reservation
    public boolean createReservation(Reservation reservation) throws SQLException {
        String sql = "INSERT INTO reservations (tour_id, user_id, reservation_date, number_of_people, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, reservation.getTourId());
            statement.setInt(2, reservation.getUserId());
            statement.setDate(3, new java.sql.Date(reservation.getReservationDate().getTime()));
            statement.setInt(4, reservation.getNumberOfPeople());
            statement.setString(5, reservation.getStatus());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve generated reservation_id
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    reservation.setReservationId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    // Method to get a reservation by ID
    public Reservation getReservationById(int reservationId) throws SQLException {
        String sql = "SELECT * FROM reservations WHERE reservation_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, reservationId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Reservation reservation = new Reservation();
                    reservation.setReservationId(resultSet.getInt("reservation_id"));
                    reservation.setTourId(resultSet.getInt("tour_id"));
                    reservation.setUserId(resultSet.getInt("user_id"));
                    reservation.setReservationDate(resultSet.getDate("reservation_date"));
                    reservation.setNumberOfPeople(resultSet.getInt("number_of_people"));
                    reservation.setStatus(resultSet.getString("status"));
                    return reservation;
                }
            }
        }
        return null;
    }

    // Method to get reservations by user ID
    public List<Reservation> getReservationsByUserId(int userId) throws SQLException {
        String sql = "SELECT r.*, t.title AS tourTitle, t.image_path AS imagePath " +
                "FROM reservations r " +
                "JOIN tours t ON r.tour_id = t.tour_id " +
                "WHERE r.user_id = ?";
        List<Reservation> reservations = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Reservation reservation = new Reservation();
                    reservation.setReservationId(resultSet.getInt("reservation_id"));
                    reservation.setTourId(resultSet.getInt("tour_id"));
                    reservation.setUserId(resultSet.getInt("user_id"));
                    reservation.setReservationDate(resultSet.getDate("reservation_date"));
                    reservation.setNumberOfPeople(resultSet.getInt("number_of_people"));
                    reservation.setStatus(resultSet.getString("status"));
                    reservation.setTourTitle(resultSet.getString("tourTitle"));
                    reservation.setImagePath(resultSet.getString("imagePath"));
                    reservations.add(reservation);
                }
            }
        }
        return reservations;
    }

    // Method to get reservations by tour ID
    public List<Reservation> getReservationsByTourId(int tourId) throws SQLException {
        String sql = "SELECT * FROM reservations WHERE tour_id = ?";
        List<Reservation> reservations = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, tourId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Reservation reservation = new Reservation();
                    reservation.setReservationId(resultSet.getInt("reservation_id"));
                    reservation.setTourId(resultSet.getInt("tour_id"));
                    reservation.setUserId(resultSet.getInt("user_id"));
                    reservation.setReservationDate(resultSet.getDate("reservation_date"));
                    reservation.setNumberOfPeople(resultSet.getInt("number_of_people"));
                    reservation.setStatus(resultSet.getString("status"));
                    reservations.add(reservation);
                }
            }
        }
        return reservations;
    }

    // Method to update a reservation
    public boolean updateReservation(Reservation reservation) throws SQLException {
        String sql = "UPDATE reservations SET tour_id = ?, user_id = ?, reservation_date = ?, number_of_people = ?, status = ? WHERE reservation_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, reservation.getTourId());
            statement.setInt(2, reservation.getUserId());

            if (reservation.getReservationDate() != null) {
                statement.setDate(3, new java.sql.Date(reservation.getReservationDate().getTime()));
            } else {
                statement.setNull(3, java.sql.Types.DATE);
            }

            statement.setInt(4, reservation.getNumberOfPeople());
            statement.setString(5, reservation.getStatus());
            statement.setInt(6, reservation.getReservationId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to delete a reservation
    public boolean deleteReservation(int reservationId) throws SQLException {
        String sql = "DELETE FROM reservations WHERE reservation_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, reservationId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to get all reservations
    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, u.name AS userName, u.email AS userEmail, t.title AS tourTitle, t.image_path AS imagePath "
                +
                "FROM reservations r " +
                "JOIN users u ON r.user_id = u.user_id " +
                "JOIN tours t ON r.tour_id = t.tour_id";
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationId(resultSet.getInt("reservation_id"));
                reservation.setTourId(resultSet.getInt("tour_id"));
                reservation.setUserId(resultSet.getInt("user_id"));
                reservation.setReservationDate(resultSet.getDate("reservation_date"));
                reservation.setNumberOfPeople(resultSet.getInt("number_of_people"));
                reservation.setStatus(resultSet.getString("status"));
                reservation.setUserName(resultSet.getString("userName"));
                reservation.setUserEmail(resultSet.getString("userEmail"));
                reservation.setTourTitle(resultSet.getString("tourTitle"));
                reservation.setImagePath(resultSet.getString("imagePath"));

                reservations.add(reservation);
            }
        }
        return reservations;
    }

    public List<Reservation> searchReservations(String query) throws SQLException {
        String sql = "SELECT r.*, u.name AS userName, u.email AS userEmail, t.title AS tourTitle, t.image_path AS imagePath "
                +
                "FROM reservations r " +
                "JOIN users u ON r.user_id = u.user_id " +
                "JOIN tours t ON r.tour_id = t.tour_id " +
                "WHERE u.name LIKE ? OR u.email LIKE ? OR t.title LIKE ? OR r.status LIKE ?";
        List<Reservation> reservations = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            String searchPattern = "%" + query + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);
            statement.setString(4, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Reservation reservation = new Reservation();
                    reservation.setReservationId(resultSet.getInt("reservation_id"));
                    reservation.setTourId(resultSet.getInt("tour_id"));
                    reservation.setUserId(resultSet.getInt("user_id"));
                    reservation.setReservationDate(resultSet.getDate("reservation_date"));
                    reservation.setNumberOfPeople(resultSet.getInt("number_of_people"));
                    reservation.setStatus(resultSet.getString("status"));
                    reservation.setUserName(resultSet.getString("userName"));
                    reservation.setUserEmail(resultSet.getString("userEmail"));
                    reservation.setTourTitle(resultSet.getString("tourTitle"));
                    reservation.setImagePath(resultSet.getString("imagePath"));

                    reservations.add(reservation);
                }
            }
        }
        return reservations;
    }

    public boolean hasUserReviewedReservation(int userId, int tourId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reviews WHERE user_id = ? AND tour_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
    
            statement.setInt(1, userId);
            statement.setInt(2, tourId);
    
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
