package controller;

import database.ActivityDAO;
import models.Activity;
import models.Tour;
import database.TourDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ActivityServlet")
public class ActivityServlet extends HttpServlet {

    private ActivityDAO activityDAO;
    private TourDAO tourDAO;

    @Override
    public void init() {
        activityDAO = new ActivityDAO();
        tourDAO = new TourDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            if (role == null || !"admin".equalsIgnoreCase(role)) {
                response.sendRedirect("auth/login.jsp");
                return;
            }

            String action = request.getParameter("action");
            if ("new".equals(action)) {
                showNewForm(request, response);
            } else if ("edit".equals(action)) {
                showEditForm(request, response);
            } else if ("delete".equals(action)) {
                deleteActivity(request, response);
            } else {
                listActivities(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for creating and updating activities
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("insert".equals(action)) {
                insertActivity(request, response);
            } else if ("update".equals(action)) {
                updateActivity(request, response);
            } else {
                response.sendRedirect("ActivityServlet");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // List all activities
    private void listActivities(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Activity> activities = activityDAO.getAllActivities();
        request.setAttribute("activities", activities);
        request.getRequestDispatcher("activity/activityList.jsp").forward(request, response);
    }

    // Show form to edit a new activity
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        Activity existingActivity = activityDAO.getActivityById(activityId);

        // Fetch all tours
        List<Tour> allTours = tourDAO.getAllTours();

        request.setAttribute("activity", existingActivity);
        request.setAttribute("allTours", allTours); // Make sure this attribute is populated
        request.getRequestDispatcher("activity/activityForm.jsp").forward(request, response);
    }

    // Show form to create an activity
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Fetch all tours
        List<Tour> allTours = tourDAO.getAllTours();

        request.setAttribute("allTours", allTours); // Ensure this attribute is populated
        request.getRequestDispatcher("activity/activityForm.jsp").forward(request, response);
    }

    // Insert a new activity
    private void insertActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] tourIds = request.getParameterValues("tourIds");

        List<Tour> associatedTours = new ArrayList<>();
        if (tourIds != null) {
            for (String tourIdStr : tourIds) {
                int tourId = Integer.parseInt(tourIdStr);
                associatedTours.add(tourDAO.getTourById(tourId));
            }
        }

        Activity activity = new Activity(name, description, associatedTours);
        activityDAO.createActivity(activity);
        response.sendRedirect("ActivityServlet?action=list");
    }

    // Update an activity
    private void updateActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int activityId = Integer.parseInt(request.getParameter("activityId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] tourIds = request.getParameterValues("tourIds");

        List<Tour> associatedTours = new ArrayList<>();
        if (tourIds != null) {
            for (String tourIdStr : tourIds) {
                int tourId = Integer.parseInt(tourIdStr);
                associatedTours.add(tourDAO.getTourById(tourId));
            }
        }

        Activity activity = new Activity();
        activity.setActivityId(activityId);
        activity.setName(name);
        activity.setDescription(description);
        activity.setAssociatedTours(associatedTours);

        activityDAO.updateActivity(activity);
        response.sendRedirect("ActivityServlet?action=list");
    }

    // Delete an activity
    private void deleteActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        activityDAO.deleteActivity(activityId);
        response.sendRedirect("ActivityServlet");
    }
}
