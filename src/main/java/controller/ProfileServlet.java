package controller;

import database.UserDAO;
import models.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import javax.imageio.*;
import javax.imageio.stream.ImageOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;
import java.nio.file.Paths;
import java.util.Iterator;

@WebServlet("/ProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;
    private String uploadPath;

    // Constants for image processing
    private static final int MAX_IMAGE_WIDTH = 200;
    private static final int MAX_IMAGE_HEIGHT = 200;
    private static final float IMAGE_COMPRESSION_QUALITY = 0.8f; // Compression quality (0.0f - 1.0f)

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
                // Delete old image file if it's not the default image
                String oldImagePath = existingUser.getImagePath();
                if (oldImagePath != null && !oldImagePath.equals("assets/default.png")) {
                    File oldFile = new File(getServletContext().getRealPath("") + File.separator + oldImagePath);
                    if (oldFile.exists()) {
                        if (!oldFile.delete()) {
                            System.err.println("Failed to delete old profile image: " + oldImagePath);
                        }
                    }
                }

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

                // Determine image format
                String formatName = "jpg"; // Default format
                if (contentType.equals("image/png")) {
                    formatName = "png";
                } else if (contentType.equals("image/jpeg") || contentType.equals("image/jpg")) {
                    formatName = "jpg";
                } else if (contentType.equals("image/gif")) {
                    formatName = "gif";
                }

                // Adjust file extension
                String fileExtension = formatName;
                String newFileName = email + "_profile_" + System.currentTimeMillis() + "_" + sanitizedFileName;
                if (!newFileName.endsWith("." + fileExtension)) {
                    newFileName += "." + fileExtension;
                }

                // **Resize the image before saving**
                BufferedImage originalImage = ImageIO.read(filePart.getInputStream());

                // Calculate new dimensions while maintaining aspect ratio
                int originalWidth = originalImage.getWidth();
                int originalHeight = originalImage.getHeight();
                int newWidth = originalWidth;
                int newHeight = originalHeight;

                if (originalWidth > MAX_IMAGE_WIDTH || originalHeight > MAX_IMAGE_HEIGHT) {
                    double widthRatio = (double) MAX_IMAGE_WIDTH / originalWidth;
                    double heightRatio = (double) MAX_IMAGE_HEIGHT / originalHeight;
                    double ratio = Math.min(widthRatio, heightRatio);

                    newWidth = (int) (originalWidth * ratio);
                    newHeight = (int) (originalHeight * ratio);
                }

                // Create a new image with the new dimensions
                BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = resizedImage.createGraphics();
                g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
                g.dispose();

                // Save the resized image with compression
                File outputFile = new File(uploadPath, newFileName);
                try (ImageOutputStream ios = ImageIO.createImageOutputStream(outputFile)) {
                    Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName(formatName);
                    if (!writers.hasNext()) {
                        throw new IOException("No ImageWriter found for format " + formatName);
                    }
                    ImageWriter writer = writers.next();
                    writer.setOutput(ios);

                    ImageWriteParam param = writer.getDefaultWriteParam();
                    if (param.canWriteCompressed()) {
                        param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
                        param.setCompressionQuality(IMAGE_COMPRESSION_QUALITY); // Adjust the quality (0.0f - 1.0f)
                    }

                    writer.write(null, new IIOImage(resizedImage, null, null), param);
                    writer.dispose();
                }

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
                session.setAttribute("user_imagePath", existingUser.getImagePath());
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
