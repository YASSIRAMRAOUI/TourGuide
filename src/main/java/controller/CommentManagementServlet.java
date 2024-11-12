package controller;

import database.CommentDAO;
import models.Comment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CommentManagementServlet")
public class CommentManagementServlet extends HttpServlet {

    private CommentDAO commentDAO;

    @Override
    public void init() {
        commentDAO = new CommentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            if (role == null || !"admin".equalsIgnoreCase(role)) {
                response.sendRedirect("LoginServlet");
                return;
            }

            String action = request.getParameter("action");
            if ("delete".equals(action)) {
                deleteComment(request, response);
            } else {
                listComments(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // List all comments
    private void listComments(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Comment> comments = commentDAO.getAllComments();
        request.setAttribute("comments", comments);
        request.getRequestDispatcher("comment/commentList.jsp").forward(request, response);
    }

    // Delete a comment
    private void deleteComment(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int commentId = Integer.parseInt(request.getParameter("id"));
        commentDAO.deleteComment(commentId);
        response.sendRedirect("CommentManagementServlet");
    }
}
