<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TourGuide</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="/assets/alert.js"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-lg fixed w-full top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex-shrink-0">
                    <a href="<c:url value='/HomeServlet' />" class="flex items-center">
                        <img src="<c:url value='/assets/logo.png' />" alt="TourGuide Logo" class="h-10 w-auto">
                    </a>
                </div>

                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-8 items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user_id}">
                            <c:if test="${sessionScope.role == 'admin'}">
                                <a href="<c:url value='/TourServlet?action=list' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Tours</a>
                                <a href="<c:url value='/UserServlet' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Users</a>
                                <a href="<c:url value='/ReservationServlet?action=listAll' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Reservations</a>
                                <a href="<c:url value='/ReviewServlet?action=listAll' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Reviews</a>
                                <a href="<c:url value='/ActivityServlet' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Activities</a>
                            </c:if>
                            <c:if test="${sessionScope.role == 'user'}">
                                <a href="<c:url value='/TourServlet?action=list' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Tours</a>
                                <a href="<c:url value='/ReservationServlet?action=list' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Reservations</a>
                                <a href="<c:url value='/ReviewServlet?action=list' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Reviews</a>
                            </c:if>
                            <a href="<c:url value='/LogoutServlet' />" class="text-gray-700 hover:text-red-600 transition duration-300">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/auth/login.jsp' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Login</a>
                            <a href="<c:url value='/auth/register.jsp' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Register</a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Profile or Menu -->
                <div class="flex items-center">
                    <c:if test="${not empty sessionScope.user_id}">
                        <a href="<c:url value='/ProfileServlet?action=viewProfile' />" class="flex items-center space-x-2">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user_imagePath}">
                                    <img src="<c:url value='/${sessionScope.user_imagePath}' />" alt="User Profile" class="h-10 w-10 rounded-full border-2 border-gray-300">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/assets/default.png' />" alt="User Profile" class="h-10 w-10 rounded-full border-2 border-gray-300">
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </c:if>
                    <button class="ml-4 md:hidden text-gray-700 hover:text-yellow-600 text-2xl" onclick="toggleMenu()">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Mobile Menu -->
        <div id="navbar-links" class="md:hidden hidden bg-white space-y-2 px-4 py-2 shadow-lg">
            <c:choose>
                <c:when test="${not empty sessionScope.user_id}">
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-map-marked-alt mr-2"></i>Tours</a>
                        <a href="<c:url value='/UserServlet' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-users mr-2"></i>Users</a>
                        <a href="<c:url value='/ReservationServlet?action=listAll' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-calendar-check mr-2"></i>Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=listAll' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-star mr-2"></i>Reviews</a>
                        <a href="<c:url value='/ActivityServlet' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-route mr-2"></i>Activities</a>
                    </c:if>
                    <c:if test="${sessionScope.role == 'user'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-map-marked-alt mr-2"></i>Tours</a>
                        <a href="<c:url value='/ReservationServlet?action=list' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-calendar-check mr-2"></i>Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=list' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-star mr-2"></i>Reviews</a>
                    </c:if>
                    <a href="<c:url value='/LogoutServlet' />" class="block text-gray-700 hover:text-red-600 transition duration-300"><i class="fas fa-sign-out-alt mr-2"></i>Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/auth/login.jsp' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-sign-in-alt mr-2"></i>Login</a>
                    <a href="<c:url value='/auth/register.jsp' />" class="block text-gray-700 hover:text-yellow-600 transition duration-300"><i class="fas fa-user-plus mr-2"></i>Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="mt-16 mx-auto">