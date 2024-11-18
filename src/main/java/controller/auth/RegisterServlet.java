package controller.auth;

import database.UserDAO;
import models.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    // Regular expression pattern for validating email format
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,}$");

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phone_number").trim();
        String imagePath = "assets/default.png";

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            request.setAttribute("errorMessage", "Invalid email format. Please enter a valid email.");
            request.getRequestDispatcher("auth/register.jsp").forward(request, response);
            return;
        }

        try {
            if (userDAO.isEmailRegistered(email)) {
                request.setAttribute("errorMessage", "This email is already in use. Please try another email.");
                request.getRequestDispatcher("auth/register.jsp").forward(request, response);
                return;
            }

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            User user = new User(name, email, hashedPassword, phoneNumber, imagePath, "user");

            if (userDAO.registerUser(user)) {
                response.sendRedirect("auth/login.jsp");
            } else {
                request.setAttribute("errorMessage", "Error registering user. Please try again.");
                request.getRequestDispatcher("auth/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("auth/register.jsp").forward(request, response);
        }
    }
}
