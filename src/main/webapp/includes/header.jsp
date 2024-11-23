<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>TourGuide</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="/assets/alert.js"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <nav class="bg-white shadow-md fixed w-full top-0">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex-shrink-0">
                    <a href="<c:url value='/HomeServlet' />">
                        <img src="<c:url value='/assets/logo.png' />" alt="TourGuide Logo" class="h-10 w-auto">
                    </a>
                </div>

                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-8">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user_id}">
                            <c:if test="${sessionScope.role == 'admin'}">
                                <a href="<c:url value='/TourServlet?action=list' />" class="text-gray-600 hover:text-blue-500">Tours</a>
                                <a href="<c:url value='/UserServlet' />" class="text-gray-600 hover:text-blue-500">Users</a>
                                <a href="<c:url value='/ReservationServlet?action=listAll' />" class="text-gray-600 hover:text-blue-500">Reservations</a>
                                <a href="<c:url value='/ReviewServlet?action=listAll' />" class="text-gray-600 hover:text-blue-500">Reviews</a>
                                <a href="<c:url value='/ActivityServlet' />" class="text-gray-600 hover:text-blue-500">Activities</a>
                                <a href="<c:url value='/LogoutServlet' />" class="text-gray-600 hover:text-blue-500">Logout</a>
                            </c:if>
                            <c:if test="${sessionScope.role == 'user'}">
                                <a href="<c:url value='/TourServlet?action=list' />" class="text-gray-600 hover:text-blue-500">Tours</a>
                                <a href="<c:url value='/ReservationServlet?action=list' />" class="text-gray-600 hover:text-blue-500">Reservations</a>
                                <a href="<c:url value='/ReviewServlet?action=list' />" class="text-gray-600 hover:text-blue-500">Reviews</a>
                                <a href="<c:url value='/LogoutServlet' />" class="text-gray-600 hover:text-blue-500">Logout</a>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/auth/login.jsp' />" class="text-gray-600 hover:text-blue-500">Login</a>
                            <a href="<c:url value='/auth/register.jsp' />" class="text-gray-600 hover:text-blue-500">Register</a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Profile or Menu -->
                <div class="flex items-center">
                    <c:if test="${not empty sessionScope.user_id}">
                        <a href="<c:url value='/ProfileServlet?action=viewProfile' />" class="flex items-center space-x-2">
                            <c:choose>
                            <c:when test="${not empty sessionScope.user_imagePath}">
                                <img src="<c:url value='/${sessionScope.user_imagePath}' />"
                                    alt="User Profile" class="h-10 w-10 rounded-full border-2 border-gray-300">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/assets/default.png' />"
                                    alt="User Profile" class="h-10 w-10 rounded-full border-2 border-gray-300">
                            </c:otherwise>
                        </c:choose>
                        </a>
                    </c:if>
                    <button class="ml-4 md:hidden text-gray-600 hover:text-blue-500 text-2xl" onclick="toggleMenu()"><i class="fa-solid fa-bars"></i></button>
                </div>
            </div>
        </div>

        <!-- Mobile Menu -->
        <div id="navbar-links" class="md:hidden hidden bg-gray-100 space-y-2 px-4 p-4">
            <c:choose>
                <c:when test="${not empty sessionScope.user_id}">
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-map-marked-alt mr-2"></i> Tours
                        </a>
                        <a href="<c:url value='/UserServlet' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-users mr-2"></i> Users
                        </a>
                        <a href="<c:url value='/ReservationServlet?action=listAll' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-calendar-check mr-2"></i> Reservations
                        </a>
                        <a href="<c:url value='/ReviewServlet?action=listAll' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-star mr-2"></i> Reviews
                        </a>
                        <a href="<c:url value='/ActivityServlet' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-route mr-2"></i> Activities
                        </a>
                        <a href="<c:url value='/LogoutServlet' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-sign-out-alt mr-2"></i> Logout
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.role == 'user'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-map-marked-alt mr-2"></i> Tours
                        </a>
                        <a href="<c:url value='/ReservationServlet?action=list' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-calendar-check mr-2"></i> Reservations
                        </a>
                        <a href="<c:url value='/ReviewServlet?action=list' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-star mr-2"></i> Reviews
                        </a>
                        <a href="<c:url value='/LogoutServlet' />" class="flex items-center text-gray-600 hover:text-blue-500">
                            <i class="fas fa-sign-out-alt mr-2"></i> Logout
                        </a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/auth/login.jsp' />" class="flex items-center text-gray-600 hover:text-blue-500">
                        <i class="fas fa-sign-in-alt mr-2"></i> Login
                    </a>
                    <a href="<c:url value='/auth/register.jsp' />" class="flex items-center text-gray-600 hover:text-blue-500">
                        <i class="fas fa-user-plus mr-2"></i> Register
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="mt-16 mx-auto">
