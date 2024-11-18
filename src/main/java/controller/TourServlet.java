package controller;

import database.TourDAO;
import database.ActivityDAO;
import database.ReviewDAO;
import models.Activity;
import models.Review;
import models.Tour;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/TourServlet")
public class TourServlet extends HttpServlet {

    private TourDAO tourDAO;
    private ReviewDAO reviewDAO;
    private ActivityDAO activityDAO;

    @Override
    public void init() {
        tourDAO = new TourDAO();
        reviewDAO = new ReviewDAO();
        activityDAO = new ActivityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("new".equals(action)) {
                showNewForm(request, response);
            } else if ("edit".equals(action)) {
                showEditForm(request, response);
            } else if ("delete".equals(action)) {
                deleteTour(request, response);
            } else if ("list".equals(action)) {
                listTours(request, response);
            } else {
                viewTourDetails(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for creating and updating tours
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("insert".equals(action)) {
                insertTour(request, response);
            } else if ("update".equals(action)) {
                updateTour(request, response);
            } else {
                response.sendRedirect("TourServlet?action=list");
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    // Display form for creating a new tour
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("tour/tourForm.jsp").forward(request, response);
    }

    // Display form for editing an existing tour
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int tourId = Integer.parseInt(request.getParameter("id"));
        Tour existingTour = tourDAO.getTourById(tourId);

        request.setAttribute("tour", existingTour);
        request.getRequestDispatcher("tour/tourForm.jsp").forward(request, response);
    }

    // Insert a new tour into the database
    private void insertTour(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {

        // Get the current user (guide) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        String title = request.getParameter("title").trim();
        String description = request.getParameter("description").trim();
        String location = request.getParameter("location").trim();
        String dateStr = request.getParameter("date");
        String priceStr = request.getParameter("price");

        // Validate inputs
        if (title.isEmpty() || description.isEmpty() || location.isEmpty() || dateStr.isEmpty() || priceStr.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("tour/tourForm.jsp").forward(request, response);
            return;
        }

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = formatter.parse(dateStr);
        double price = Double.parseDouble(priceStr);

        Tour tour = new Tour(title, description, location, date, price, userId);

        boolean success = tourDAO.createTour(tour);

        if (success) {
            response.sendRedirect("TourServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "An error occurred while creating the tour.");
            request.getRequestDispatcher("tour/tourForm.jsp").forward(request, response);
        }
    }

    // Update an existing tour
    private void updateTour(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {

        int tourId = Integer.parseInt(request.getParameter("id"));

        // Get the current user (guide) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        Tour existingTour = tourDAO.getTourById(tourId);

        // Ensure that the guide is the owner of the tour
        if (existingTour == null || existingTour.getGuideId() != userId) {
            response.sendRedirect("TourServlet?action=list");
            return;
        }

        String title = request.getParameter("title").trim();
        String description = request.getParameter("description").trim();
        String location = request.getParameter("location").trim();
        String dateStr = request.getParameter("date");
        String priceStr = request.getParameter("price");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = formatter.parse(dateStr);
        double price = Double.parseDouble(priceStr);

        existingTour.setTitle(title);
        existingTour.setDescription(description);
        existingTour.setLocation(location);
        existingTour.setDate(date);
        existingTour.setPrice(price);

        boolean success = tourDAO.updateTour(existingTour);

        if (success) {
            response.sendRedirect("TourServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the tour.");
            request.getRequestDispatcher("tour/tourForm.jsp").forward(request, response);
        }
    }

    // Delete a tour
    private void deleteTour(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int tourId = Integer.parseInt(request.getParameter("id"));

        // Get the current user (guide) from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        Tour existingTour = tourDAO.getTourById(tourId);

        // Ensure that the guide is the owner of the tour
        if (existingTour != null && existingTour.getGuideId() == userId) {
            tourDAO.deleteTour(tourId);
        }

        response.sendRedirect("TourServlet?action=list");
    }

    // List all tours
    private void listTours(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        request.setAttribute("tours", tourDAO.getAllTours());
        request.getRequestDispatcher("tour/tourList.jsp").forward(request, response);
    }

    // View details of a specific tour
    private void viewTourDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int tourId = Integer.parseInt(request.getParameter("id"));
        Tour tour = tourDAO.getTourById(tourId);

        if (tour != null) {
            List<Review> reviews = reviewDAO.getReviewsByTourId(tourId);
            List<Activity> activities = activityDAO.getActivitiesByTourId(tourId);

            request.setAttribute("tour", tour);
            request.setAttribute("reviews", reviews);
            request.setAttribute("activities", activities); // Add associated activities
            request.getRequestDispatcher("tour/tourDetails.jsp").forward(request, response);
        } else {
            response.sendRedirect("TourServlet?action=list");
        }
    }
}
