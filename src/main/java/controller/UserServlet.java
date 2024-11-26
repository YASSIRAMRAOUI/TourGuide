package controller;

import database.UserDAO;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.io.File;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            if (role == null || !"admin".equalsIgnoreCase(role)) {
                response.sendRedirect("auth/login.jsp");
                return;
            }

            String action = request.getParameter("action");
            if ("edit".equals(action)) {
                showEditForm(request, response);
            } else if ("delete".equals(action)) {
                deleteUser(request, response);
            } else {
                listUsers(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Handle POST requests for updating users
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("update".equals(action)) {
                updateUser(request, response);
            } else {
                response.sendRedirect("UserServlet");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // List all users
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String searchQuery = request.getParameter("search");
        List<User> users;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            users = userDAO.searchUsersByNameOrEmail(searchQuery.trim());
        } else {
            users = userDAO.getUsersByRole("user");
        }

        request.setAttribute("users", users);
        request.setAttribute("searchQuery", searchQuery); // Keep search query for display
        request.getRequestDispatcher("user/userList.jsp").forward(request, response);
    }

    // Show edit form for a user
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User existingUser = userDAO.getUserById(userId);
        request.setAttribute("user", existingUser);
        request.getRequestDispatcher("user/userForm.jsp").forward(request, response);
    }

    // Update a user
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String phoneNumber = request.getParameter("phone_number").trim();
        String role = request.getParameter("role");

        // Handle file upload
        Part filePart = request.getPart("image");
        String imagePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Save new image
            String fileName = extractFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads/users";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + fileName);
            imagePath = "uploads/users/" + fileName;
        } else {
            // Keep existing image if no new file is uploaded
            User existingUser = userDAO.getUserById(userId);
            imagePath = existingUser.getImagePath();
        }

        // Update user object
        User user = new User();
        user.setUserId(userId);
        user.setName(name);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setRole(role);
        user.setImagePath(imagePath);

        boolean success = userDAO.updateUser(user);

        if (success) {
            response.sendRedirect("UserServlet");
        } else {
            request.setAttribute("errorMessage", "An error occurred while updating the user.");
            request.getRequestDispatcher("user/userForm.jsp").forward(request, response);
        }
    }

    // Delete a user
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(userId);
        response.sendRedirect("UserServlet");
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }

}
