<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve user information from session
    String userName = (String) session.getAttribute("name");
    String userRole = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="styles.css"> <!-- Add your CSS file link here -->
</head>
<body>
    <header>
        <h1>Welcome to the User Dashboard</h1>
        <p>Hello, <strong><%= userName %></strong>! You are logged in as a <strong><%= userRole %></strong>.</p>
        <nav>
            <a href="userProfile.jsp">View Profile</a> |
            <a href="tourList.jsp">Browse Tours</a> |
            <a href="reservations.jsp">My Reservations</a> |
            <a href="LogoutServlet">Logout</a>
        </nav>
    </header>

    <main>
        <h2>Available Tours</h2>
        <!-- Example content for tours, replace with actual data from your backend -->
        <table border="1">
            <tr>
                <th>Tour Name</th>
                <th>Location</th>
                <th>Date</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            <tr>
                <td>City Tour</td>
                <td>New York</td>
                <td>2024-12-15</td>
                <td>$100</td>
                <td><a href="reserveTour.jsp?tourId=1">Reserve</a></td>
            </tr>
            <tr>
                <td>Beach Adventure</td>
                <td>Miami</td>
                <td>2025-01-10</td>
                <td>$150</td>
                <td><a href="reserveTour.jsp?tourId=2">Reserve</a></td>
            </tr>
            <!-- Add more rows as needed -->
        </table>

        <h2>My Comments</h2>
        <!-- Example section for comments, replace with actual data from your backend -->
        <table border="1">
            <tr>
                <th>Tour</th>
                <th>Comment</th>
                <th>Date</th>
            </tr>
            <tr>
                <td>City Tour</td>
                <td>Great experience!</td>
                <td>2024-10-01</td>
            </tr>
            <tr>
                <td>Beach Adventure</td>
                <td>Loved it!</td>
                <td>2024-11-20</td>
            </tr>
            <!-- Add more rows as needed -->
        </table>
    </main>

    <footer>
        <p>&copy; 2024 Tour Guide Management System. All rights reserved.</p>
    </footer>
</body>
</html>
