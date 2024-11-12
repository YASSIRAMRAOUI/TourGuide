package controller.auth;

import database.UserDAO;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email").trim();

        try {
            User user = userDAO.getUserByEmail(email);
            if (user != null) {
                // Generate a unique token for password reset
                String resetToken = UUID.randomUUID().toString();

                // Save the token to the database (optional)
                userDAO.savePasswordResetToken(user.getUserId(), resetToken);

                // Construct the reset link
                String resetLink = request.getRequestURL().toString().replace("ForgotPasswordServlet",
                        "ResetPasswordServlet") + "?token=" + resetToken;

                // Send the reset link via email (simulated here)
                sendPasswordResetEmail(email, resetLink);

                request.setAttribute("message", "A password reset link has been sent to your email.");
            } else {
                request.setAttribute("errorMessage", "No account found with this email.");
            }

            request.getRequestDispatcher("auth/forgot-password.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("auth/forgot-password.jsp").forward(request, response);
        }
    }

    private void sendPasswordResetEmail(String email, String resetLink) {
        // Logic to send email
        System.out.println("Sending password reset link to " + email + ": " + resetLink);
    }
}
