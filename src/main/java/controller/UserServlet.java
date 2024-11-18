package controller;

import database.UserDAO;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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
        List<User> users = userDAO.getUsersByRole("user");
        request.setAttribute("users", users);
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

        User user = new User();
        user.setUserId(userId);
        user.setName(name);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setRole(role);

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
}
