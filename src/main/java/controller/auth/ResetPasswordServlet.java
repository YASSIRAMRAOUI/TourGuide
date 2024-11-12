package controller.auth;

import database.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        request.setAttribute("token", token);
        request.getRequestDispatcher("auth/reset-password.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");

        try {
            // Verify token and reset password
            boolean isTokenValid = userDAO.verifyPasswordResetToken(token);
            if (isTokenValid) {
                userDAO.updatePassword(token, newPassword);
                request.setAttribute("message", "Password successfully reset. You may log in now.");
                response.sendRedirect("auth/login.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid or expired token.");
                request.getRequestDispatcher("auth/reset-password.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("auth/reset-password.jsp").forward(request, response);
        }
    }
}
