// controller/ProfileServlet.java
package controller;

import database.UserDAO;
import models.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;
import java.nio.file.Paths;

@WebServlet("/ProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;
    private String uploadPath;

    // Regular expression pattern for validating email format
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,}$");

    @Override
    public void init() {
        userDAO = new UserDAO();
        // Define the path to save uploaded images
        uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "users";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Creates directories including parents
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("viewProfile".equals(action)) {
            // Retrieve user ID from session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user_id") == null) {
                // Not logged in, redirect to login
                response.sendRedirect("user/login.jsp");
                return;
            }
            int userId = (int) session.getAttribute("user_id");

            try {
                // Retrieve existing user from database
                User existingUser = userDAO.getUserById(userId);
                if (existingUser == null) {
                    request.setAttribute("errorMessage", "User not found.");
                } else {
                    request.setAttribute("user", existingUser);
                }
                request.getRequestDispatcher("user/profile.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                request.getRequestDispatcher("user/profile.jsp").forward(request, response);
            }
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED,
                    "HTTP method GET is not supported by this URL");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve user ID from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            // Not logged in, redirect to login
            response.sendRedirect("user/login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("user_id");

        // Retrieve form data
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password"); // May be blank
        String phoneNumber = request.getParameter("phone_number").trim();

        // Initialize imagePath with existing image
        String imagePath = "assets/default.png"; // default value, will be overwritten if image is uploaded

        // Validate email format
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            request.setAttribute("errorMessage", "Invalid email format. Please enter a valid email.");
            request.getRequestDispatcher("user/profile.jsp").forward(request, response);
            return;
        }

        try {
            // Retrieve existing user from database
            User existingUser = userDAO.getUserById(userId);
            if (existingUser == null) {
                request.setAttribute("errorMessage", "User not found.");
                request.getRequestDispatcher("user/profile.jsp").forward(request, response);
                return;
            }

            // Handle image upload
            Part filePart = request.getPart("profile_image"); // Retrieves <input type="file" name="profile_image">
            if (filePart != null && filePart.getSize() > 0) {
                // Get the submitted file name using getFileName()
                String submittedFileName = getFileName(filePart);

                // Validate the file type
                String contentType = filePart.getContentType();
                if (!contentType.startsWith("image/")) {
                    request.setAttribute("errorMessage", "Only image files are allowed!");
                    request.getRequestDispatcher("user/profile.jsp").forward(request, response);
                    return;
                }

                // Sanitize the file name to prevent security issues
                String sanitizedFileName = submittedFileName.replaceAll("[^a-zA-Z0-9\\.\\-]", "_");

                // Generate a unique file name to prevent conflicts
                String newFileName = email + "_profile_" + System.currentTimeMillis() + "_" + sanitizedFileName;

                // Save the file on the server
                File file = new File(uploadPath, newFileName);
                filePart.write(file.getAbsolutePath());

                // Set the image path to store in the database (relative path)
                imagePath = "uploads/users/" + newFileName;
            } else {
                // No new image uploaded; keep existing image path
                imagePath = existingUser.getImagePath();
            }

            // Update user details
            existingUser.setName(name);
            existingUser.setEmail(email);
            if (password != null && !password.trim().isEmpty()) {
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                existingUser.setPassword(hashedPassword);
            }
            existingUser.setPhoneNumber(phoneNumber);
            existingUser.setImagePath(imagePath);

            // Update user in the database
            boolean updated = userDAO.updateUserProfile(existingUser);
            if (updated) {
                request.setAttribute("successMessage", "Profile updated successfully.");
                // Update session attributes if necessary
                session.setAttribute("user_id", existingUser.getUserId());
                session.setAttribute("role", existingUser.getRole());
                request.setAttribute("user", existingUser);
                request.getRequestDispatcher("user/profile.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Error updating profile. Please try again.");
                request.getRequestDispatcher("user/profile.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("user/profile.jsp").forward(request, response);
        }
    }

    // Helper method to extract file name from Part
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            String[] tokens = contentDisp.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                    return Paths.get(fileName).getFileName().toString();
                }
            }
        }
        return "";
    }
}
