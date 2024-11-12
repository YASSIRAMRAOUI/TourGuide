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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("list".equals(action)) {
                listUsers(request, response);
            } else if ("delete".equals(action)) {
                deleteUser(request, response);
            } else {
                response.sendRedirect("UserServlet?action=list");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // List all users
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("user/userList.jsp").forward(request, response);
    }

    // Delete a user
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(userId);
        response.sendRedirect("UserServlet?action=list");
    }
}
