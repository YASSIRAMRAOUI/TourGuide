package controller;

import database.TourDAO;
import database.ActivityDAO;
import models.Tour;
import models.Activity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

    private TourDAO tourDAO;
    private ActivityDAO activityDAO;

    @Override
    public void init() {
        tourDAO = new TourDAO();
        activityDAO = new ActivityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch data
            List<Tour> tours = tourDAO.getAllTours();
            List<Activity> activities = activityDAO.getAllActivities();

            // Set data as request attributes
            request.setAttribute("tours", tours);
            request.setAttribute("activities", activities);

            // Forward to index.jsp
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
