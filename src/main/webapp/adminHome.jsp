<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if admin is logged in
    if (session == null || session.getAttribute("user_id") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve admin information from session
    String adminName = (String) session.getAttribute("name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="styles.css"> <!-- Add your CSS file link here -->
</head>
<body>
    <header>
        <h1>Admin Dashboard</h1>
        <p>Welcome, <strong><%= adminName %></strong>!</p>
    </header>

    <nav>
        <ul>
            <li><a href="manageUsers.jsp">Manage Users</a></li>
            <li><a href="manageTours.jsp">Manage Tours</a></li>
            <li><a href="manageReservations.jsp">Manage Reservations</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>

    <footer>
        <p>&copy; 2024 Tour Guide Management System. All rights reserved.</p>
    </footer>
</body>
</html>
