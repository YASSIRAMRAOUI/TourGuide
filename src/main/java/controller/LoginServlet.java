package controller;

import database.UserDAO;
import models.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // "on" if checked, null if unchecked

        try {
            User user = userDAO.getUserByEmail(email);

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                // Password is correct, create session
                HttpSession session = request.getSession();
                session.setAttribute("user_id", user.getUserId());
                session.setAttribute("name", user.getName());
                session.setAttribute("role", user.getRole());

                // Handle "Remember Me" functionality
                if ("on".equals(remember)) {
                    // Create a cookie to remember the email
                    Cookie emailCookie = new Cookie("rememberedEmail", email);
                    emailCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
                    response.addCookie(emailCookie);
                } else {
                    // Remove the cookie if "Remember Me" is not checked
                    Cookie emailCookie = new Cookie("rememberedEmail", "");
                    emailCookie.setMaxAge(0); // Delete the cookie
                    response.addCookie(emailCookie);
                }

                // Redirect based on role
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("adminHome.jsp"); // Change to admin home page
                } else if ("user".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("userHome.jsp"); // Change to user home page
                } else {
                    // Redirect to a general home page or error page if role is unrecognized
                    response.sendRedirect("error.jsp");
                }
            } else {
                // Invalid email or password
                request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
