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
    <link rel="stylesheet" href="css/output.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100 text-gray-900 min-h-screen flex flex-col">

    <!-- Header Section -->
    <header class="bg-blue-600 text-white p-4 shadow-md">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold">Admin Dashboard</h1>
        <p>Welcome, <strong><%= adminName %></strong>!</p>

        <!-- Language Switcher Icons -->
        <div class="flex space-x-4">
            <a href="ChangeLanguageServlet?lang=en" class="text-white hover:text-gray-300">
                <i class="fas fa-flag-usa"></i> <!-- English Flag -->
            </a>
            <a href="ChangeLanguageServlet?lang=es" class="text-white hover:text-gray-300">
                <i class="fas fa-flag"></i> <!-- Spanish Flag (Generic) -->
            </a>
            <a href="ChangeLanguageServlet?lang=fr" class="text-white hover:text-gray-300">
                <i class="fas fa-flag"></i> <!-- French Flag (Generic) -->
            </a>
        </div>
    </div>
</header>


    <!-- Navigation Section -->
    <nav class="bg-white shadow-md">
        <ul class="container mx-auto flex justify-around p-4">
            <li><a href="manageUsers.jsp" class="text-blue-600 hover:text-blue-800">Manage Users</a></li>
            <li><a href="manageTours.jsp" class="text-blue-600 hover:text-blue-800">Manage Tours</a></li>
            <li><a href="manageReservations.jsp" class="text-blue-600 hover:text-blue-800">Manage Reservations</a></li>
            <li><a href="LogoutServlet" class="text-red-600 hover:text-red-800">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content Section -->
    <main class="container mx-auto flex-grow p-4">
        <div class="bg-white p-6 rounded-lg shadow-md">
            <h2 class="text-xl font-semibold mb-4">Dashboard Overview</h2>
            <!-- Additional content for the dashboard can go here -->
            <p>This is where you can manage users, tours, and reservations.</p>
        </div>
    </main>

    <!-- Footer Section -->
    <footer class="bg-gray-800 text-white p-4 text-center">
        <p>&copy; 2024 Tour Guide Management System. All rights reserved.</p>
    </footer>

</body>
</html>
