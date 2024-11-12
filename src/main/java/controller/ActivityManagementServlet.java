package controller;

import database.ActivityDAO;
import models.Activity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ActivityManagementServlet")
public class ActivityManagementServlet extends HttpServlet {

    private ActivityDAO activityDAO;

    @Override
    public void init() {
        activityDAO = new ActivityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            if (role == null || !"admin".equalsIgnoreCase(role)) {
                response.sendRedirect("LoginServlet");
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
                response.sendRedirect("ActivityManagementServlet");
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

    // Show form to create a new activity
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("activity/activityForm.jsp").forward(request, response);
    }

    // Show edit form for an activity
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        Activity activity = activityDAO.getActivityById(activityId);
        request.setAttribute("activity", activity);
        request.getRequestDispatcher("activity/activityForm.jsp").forward(request, response);
    }

    // Insert a new activity
    private void insertActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("name").trim();
        String description = request.getParameter("description").trim();
        int tourId = Integer.parseInt(request.getParameter("tourId"));

        Activity activity = new Activity();
        activity.setName(name);
        activity.setDescription(description);
        activity.setTourId(tourId);

        boolean success = activityDAO.createActivity(activity);

        if (success) {
            response.sendRedirect("ActivityManagementServlet");
        } else {
            request.setAttribute("errorMessage", "An error occurred while creating the activity.");
            request.getRequestDispatcher("activity/activityForm.jsp").forward(request, response);
        }
    }

    // Update an activity
    private void updateActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int activityId = Integer.parseInt(request.getParameter("activityId"));
        String name = request.getParameter("name").trim();
        String description = request.getParameter("description").trim();
        int tourId = Integer.parseInt(request.getParameter("tourId"));

        Activity activity = new Activity();
        activity.setActivityId(activityId);
        activity.setName(name);
        activity.setDescription(description);
        activity.setTourId(tourId);

        boolean success = activityDAO.updateActivity(activity);

        if (success) {
            response.sendRedirect("ActivityManagementServlet");
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the activity.");
            request.getRequestDispatcher("activity/activityForm.jsp").forward(request, response);
        }
    }

    // Delete an activity
    private void deleteActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        activityDAO.deleteActivity(activityId);
        response.sendRedirect("ActivityManagementServlet");
    }
}
