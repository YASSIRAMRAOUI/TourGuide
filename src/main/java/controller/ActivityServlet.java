package controller;

import database.ActivityDAO;
import database.TourDAO;
import models.Activity;
import models.Tour;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/ActivityServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ActivityServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads/activity";

    // List of allowed image extensions
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp", "webp",
            "svg", "ico", "avif", "apng", "tiff");

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
            String action = request.getParameter("action");
            switch (action != null ? action : "") {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteActivity(request, response);
                    break;
                case "view":
                    showActivityDetails(request, response);
                    break;
                default:
                    listActivities(request, response);
                    break;
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

    // Show form to edit an existing activity
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        Activity existingActivity = activityDAO.getActivityById(activityId);

        // Fetch all tours
        List<Tour> allTours = tourDAO.getAllTours();

        request.setAttribute("activity", existingActivity);
        request.setAttribute("allTours", allTours); // Ensure this attribute is populated
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
            throws SQLException, IOException, ServletException {
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

        // Handle file upload
        Part filePart = request.getPart("image");
        String fileName = null;
        String imagePath = "assets/default.png"; // Default image

        if (filePart != null && filePart.getSize() > 0) {
            fileName = extractFileName(filePart);
            String fileExtension = getFileExtension(fileName);

            // Validate file extension
            if (fileExtension == null || !ALLOWED_EXTENSIONS.contains(fileExtension.toLowerCase())) {
                request.setAttribute("errorMessage",
                        "Unsupported file type. Allowed extensions: " + ALLOWED_EXTENSIONS);
                showNewForm(request, response);
                return;
            }

            // Create upload directory if it doesn't exist
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            // Save the file
            filePart.write(uploadPath + File.separator + fileName);
            imagePath = UPLOAD_DIRECTORY + "/" + fileName; // Relative path for the database
        }

        // Create activity object with imagePath
        Activity activity = new Activity(name, description, imagePath, associatedTours);

        activityDAO.createActivity(activity);
        response.sendRedirect("ActivityServlet?action=list");
    }

    // Update an activity
    private void updateActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
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

        Activity activity = activityDAO.getActivityById(activityId);

        // Handle file upload
        Part filePart = request.getPart("image");
        String imagePath = activity.getImagePath(); // Preserve existing image

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String fileExtension = getFileExtension(fileName);

            // Validate file extension
            if (fileExtension == null || !ALLOWED_EXTENSIONS.contains(fileExtension.toLowerCase())) {
                request.setAttribute("errorMessage",
                        "Unsupported file type. Allowed extensions: " + ALLOWED_EXTENSIONS);
                showEditForm(request, response);
                return;
            }

            // Create upload directory if it doesn't exist
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            // Save the file
            filePart.write(uploadPath + File.separator + fileName);
            imagePath = UPLOAD_DIRECTORY + "/" + fileName; // Relative path for the database
        }

        activity.setName(name);
        activity.setDescription(description);
        activity.setAssociatedTours(associatedTours);
        activity.setImagePath(imagePath);

        activityDAO.updateActivity(activity);
        response.sendRedirect("ActivityServlet?action=list");
    }

    // Show details of an activity
    private void showActivityDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        Activity activity = activityDAO.getActivityByIdWithTours(activityId);

        request.setAttribute("activity", activity);
        request.getRequestDispatcher("activity/activityDetails.jsp").forward(request, response);
    }

    // Delete an activity
    private void deleteActivity(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int activityId = Integer.parseInt(request.getParameter("id"));
        activityDAO.deleteActivity(activityId);
        response.sendRedirect("ActivityServlet");
    }

    // Utility method to extract file name in Servlet 3.0
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf('=') + 1).trim().replace("\"", "");
                return fileName;
            }
        }
        return null;
    }

    // Utility method to get file extension
    private String getFileExtension(String fileName) {
        if (fileName != null && fileName.lastIndexOf(".") != -1) {
            return fileName.substring(fileName.lastIndexOf(".") + 1);
        }
        return null;
    }
}
