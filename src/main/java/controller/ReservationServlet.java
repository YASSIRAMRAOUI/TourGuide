package controller;

import database.ReservationDAO;
import database.UserDAO;
import database.TourDAO;
import models.Reservation;
import models.User;
import models.Tour;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import javax.mail.Session;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private UserDAO userDAO;
    private TourDAO tourDAO;

    // Email credentials
    private static final String SENDER_EMAIL = "yassiramraoui2003@gmail.com";
    private static final String SENDER_PASSWORD = "gprl pukn xdcb zyiy";

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
        userDAO = new UserDAO();
        tourDAO = new TourDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");

            switch (action) {
                case "edit":
                    if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                        showEditForm(request, response);
                    }
                    break;
                case "delete":
                    if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                        deleteReservation(request, response);
                    }
                    break;
                case "listAll":
                    if ("admin".equalsIgnoreCase(role)) {
                        listAllReservations(request, response);
                    }
                    break;

                case "new":
                    if ("user".equalsIgnoreCase(role)) {
                        showNewReservationForm(request, response);
                    }
                    break;
                case "list":
                    if ("admin".equalsIgnoreCase(role)) {
                        listAllReservations(request, response);
                    } else if ("user".equalsIgnoreCase(role)) {
                        listUserReservations(request, response);
                    } else {
                        response.sendRedirect("auth/login.jsp"); // Handle non-authenticated users
                    }
                    break;

                default:
                    response.sendRedirect("HomeServlet"); // Redirect to home or appropriate page
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for creating and updating reservations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            String role = (String) request.getSession().getAttribute("role");

            switch (action) {
                case "update":
                    if ("admin".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                        updateReservation(request, response);
                    }
                    break;
                case "insert":
                    if ("user".equalsIgnoreCase(role) || "admin".equalsIgnoreCase(role)) {
                        insertReservation(request, response);
                    } else {
                        response.sendRedirect("auth/login.jsp");
                    }
                    break;
                default:
                    response.sendRedirect("auth/login.jsp");
                    break;
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    // ----------- Admin Operations -----------

    // List all reservations (Admin)
    private void listAllReservations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String searchQuery = request.getParameter("search");
        List<Reservation> reservations;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            reservations = reservationDAO.searchReservations(searchQuery.trim());
        } else {
            reservations = reservationDAO.getAllReservations();
        }

        request.setAttribute("reservations", reservations);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("reservation/reservationList.jsp").forward(request, response);
    }

    // Show edit form for a reservation (Admin)
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        List<User> users = userDAO.getAllUsers();
        List<Tour> tours = tourDAO.getAllTours();
        request.setAttribute("reservation", reservation);
        request.setAttribute("users", users);
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
    }

    // Update a reservation
    private void updateReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException, ParseException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("user_id");

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        Reservation existingReservation = reservationDAO.getReservationById(reservationId);

        // Allow users to update only their reservations
        if ("user".equalsIgnoreCase(role)
                && (existingReservation == null || existingReservation.getUserId() != userId)) {
            response.sendRedirect("ReservationServlet?action=list");
            return;
        }

        String tourIdStr = request.getParameter("tourId");
        String reservationDateStr = request.getParameter("reservationDate");
        String numberOfPeopleStr = request.getParameter("numberOfPeople");
        String status = request.getParameter("status");

        // Validate inputs
        if (tourIdStr == null || reservationDateStr == null || numberOfPeopleStr == null ||
                tourIdStr.trim().isEmpty() || reservationDateStr.trim().isEmpty()
                || numberOfPeopleStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            forwardToEditForm(request, response, reservationId);
            return;
        }

        // Parse inputs
        int tourId = Integer.parseInt(tourIdStr);
        Date reservationDate = new SimpleDateFormat("yyyy-MM-dd").parse(reservationDateStr);
        int numberOfPeople = Integer.parseInt(numberOfPeopleStr);

        // Update Reservation object
        Reservation updatedReservation = new Reservation();
        updatedReservation.setReservationId(reservationId);
        updatedReservation.setTourId(tourId);
        updatedReservation.setReservationDate(reservationDate);
        updatedReservation.setNumberOfPeople(numberOfPeople);

        if ("admin".equalsIgnoreCase(role)) {
            updatedReservation.setUserId(Integer.parseInt(request.getParameter("userId")));
            updatedReservation.setStatus(status);
        } else {
            updatedReservation.setUserId(userId); // Ensure users cannot update the user ID
            updatedReservation.setStatus(existingReservation.getStatus()); // Preserve the status for users
        }

        // Update the reservation in the database
        boolean success = reservationDAO.updateReservation(updatedReservation);

        if (success) {
            // Check if the status is being updated to "Confirmed"
            if ("Confirmed".equalsIgnoreCase(status)) {
                sendConfirmationEmail(updatedReservation);
            }
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("ReservationServlet?action=listAll");
            } else {
                response.sendRedirect("ReservationServlet?action=list");
            }
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the reservation.");
            forwardToEditForm(request, response, reservationId);
        }
    }

    // Delete a reservation
    private void deleteReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("user_id");

        int reservationId = Integer.parseInt(request.getParameter("id"));
        Reservation reservation = reservationDAO.getReservationById(reservationId);

        if (reservation == null) {
            response.sendRedirect("ReservationServlet?action=list");
            return;
        }

        // Allow admin to delete any reservation or user to delete only their own
        // reservation
        if ("admin".equalsIgnoreCase(role) || (userId != null && userId.equals(reservation.getUserId()))) {
            reservationDAO.deleteReservation(reservationId);
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("ReservationServlet?action=listAll");
            } else {
                response.sendRedirect("ReservationServlet?action=list");
            }
        } else {
            response.sendRedirect("ReservationServlet?action=list"); // Redirect if user is not authorized
        }
    }

    // Helper method to forward to edit form with reservation data
    private void forwardToEditForm(HttpServletRequest request, HttpServletResponse response, int reservationId)
            throws SQLException, ServletException, IOException {
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        List<User> users = userDAO.getAllUsers();
        List<Tour> tours = tourDAO.getAllTours();
        request.setAttribute("reservation", reservation);
        request.setAttribute("users", users);
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
    }

    // ----------- User Operations -----------

    // List reservations for the current user
    private void listUserReservations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        // Get the current user from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        List<Reservation> reservations = reservationDAO.getReservationsByUserId(userId);

        // Check if each reservation has a review and set the status
        for (Reservation reservation : reservations) {
            boolean hasReviewed = reservationDAO.hasUserReviewedReservation(userId, reservation.getTourId());
            reservation.setHasReviewed(hasReviewed); // Add this method in your Reservation class
        }
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("reservation/reservationList.jsp").forward(request, response);
    }

    // Show form to create a new reservation (User)
    private void showNewReservationForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int tourId = Integer.parseInt(request.getParameter("tourId"));
        Tour tour = tourDAO.getTourById(tourId);

        if (tour != null) {
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
        } else {
            response.sendRedirect("TourServlet?action=list");
        }
    }

    // Insert a new reservation (User or Admin)
    private void insertReservation(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {

        // Get the current user (tourist) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"user".equalsIgnoreCase(role) && !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        // Retrieve parameters safely
        String tourIdStr = request.getParameter("tourId");
        String reservationDateStr = request.getParameter("reservationDate");
        String numberOfPeopleStr = request.getParameter("numberOfPeople");

        // Validate inputs
        if (tourIdStr == null || tourIdStr.trim().isEmpty() ||
                reservationDateStr == null || reservationDateStr.trim().isEmpty() ||
                numberOfPeopleStr == null || numberOfPeopleStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        // Parse inputs with additional error handling
        int tourId;
        int numberOfPeople;
        Date reservationDate;

        try {
            tourId = Integer.parseInt(tourIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Tour ID.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        try {
            numberOfPeople = Integer.parseInt(numberOfPeopleStr);
            if (numberOfPeople <= 0) {
                throw new NumberFormatException("Number of people must be greater than zero.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Number of People. Please enter a positive integer.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        try {
            reservationDate = new SimpleDateFormat("yyyy-MM-dd").parse(reservationDateStr);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid Reservation Date.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
            return;
        }

        // Create and populate Reservation object
        Reservation reservation = new Reservation();
        reservation.setTourId(tourId);
        reservation.setUserId(userId);
        reservation.setReservationDate(reservationDate);
        reservation.setNumberOfPeople(numberOfPeople);
        reservation.setStatus("Pending"); // Default status

        // Insert reservation into the database
        boolean success = reservationDAO.createReservation(reservation);

        if (success) {
            sendReservationEmail(reservation);
            
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("ReservationServlet?action=listAll");
            } else {
                response.sendRedirect("ReservationServlet?action=list");
            }
        } else {
            request.setAttribute("errorMessage", "An error occurred while creating the reservation.");
            request.getRequestDispatcher("reservation/reservationForm.jsp").forward(request, response);
        }
    }

    // Method to send email notification
    private void sendReservationEmail(Reservation reservation) {
        try {
            // Get the user associated with the reservation
            User user = userDAO.getUserById(reservation.getUserId());
            if (user == null) {
                return; // User not found, cannot send email
            }
    
            Tour tour = tourDAO.getTourById(reservation.getTourId());
    
            // Email properties
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
    
            // Create a session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });
    
            // Create a MimeMessage
            Message mailMessage = new MimeMessage(session);
            mailMessage.setFrom(new InternetAddress(SENDER_EMAIL));
            mailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            mailMessage.setRecipients(Message.RecipientType.CC, InternetAddress.parse(SENDER_EMAIL));
            mailMessage.setSubject("Reservation Details");
    
            // Load the HTML template
            String htmlTemplate = loadReservationEmailTemplate();
    
            // Replace placeholders with actual values
            String emailContent = htmlTemplate
                .replace("{{userName}}", user.getName())
                .replace("{{reservationId}}", String.valueOf(reservation.getReservationId()))
                .replace("{{tourName}}", tour != null ? tour.getTitle() : "N/A")
                .replace("{{reservationDate}}", new SimpleDateFormat("yyyy-MM-dd").format(reservation.getReservationDate()))
                .replace("{{numberOfPeople}}", String.valueOf(reservation.getNumberOfPeople()))
                .replace("{{status}}", reservation.getStatus());
    
            // Set the email content as HTML
            mailMessage.setContent(emailContent, "text/html");
    
            // Send email
            Transport.send(mailMessage);
        } catch (MessagingException | SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Method to load the reservation email template
    private String loadReservationEmailTemplate() {
        String templatePath = "reservationEmail.html"; // File is directly in the resources folder
    
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(templatePath);
             BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            if (inputStream == null) {
                throw new IOException("Template file not found: " + templatePath);
            }
    
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
            return content.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return ""; // Return an empty string or a default template
        }
    }
    // Method to send confirmation email
    private void sendConfirmationEmail(Reservation reservation) throws SQLException {
        // Get the user associated with the reservation
        User user = userDAO.getUserById(reservation.getUserId());
        if (user == null) {
            return; // User not found, cannot send email
        }

        Tour tour = tourDAO.getTourById(reservation.getTourId());

        // Email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            // Create a MimeMessage
            Message mailMessage = new MimeMessage(session);
            mailMessage.setFrom(new InternetAddress(SENDER_EMAIL));
            mailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail())); // Send to user's email
            mailMessage.setSubject("Reservation Confirmed");

            // Load the HTML template
            String htmlTemplate = loadEmailTemplate();

            // Replace placeholders with actual values
            String emailContent = htmlTemplate
                .replace("{{userName}}", user.getName())
                .replace("{{reservationId}}", String.valueOf(reservation.getReservationId()))
                .replace("{{tourName}}", tour != null ? tour.getTitle() : "N/A")
                .replace("{{reservationDate}}", new SimpleDateFormat("yyyy-MM-dd").format(reservation.getReservationDate()))
                .replace("{{numberOfPeople}}", String.valueOf(reservation.getNumberOfPeople()))
                .replace("{{status}}", reservation.getStatus())
                .replace("{{contactLink}}", "https://yourcompany.com/contact");

            // Set the email content as HTML
            mailMessage.setContent(emailContent, "text/html");

            // Send email
            Transport.send(mailMessage);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // Method to load the email template from a file or resource
    private String loadEmailTemplate() {
        String templatePath = "confirmationEmail.html"; // File is directly in the resources folder
    
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(templatePath);
             BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            if (inputStream == null) {
                throw new IOException("Template file not found: " + templatePath);
            }
    
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
            return content.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return ""; // Return an empty string or a default template
        }
    }
}
