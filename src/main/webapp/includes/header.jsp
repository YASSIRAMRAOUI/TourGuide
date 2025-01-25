<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TourGuide</title>

    <link rel="icon" type="image/x-icon" href="/assets/images/favicon.ico">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/images/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/images/favicon-16x16.png">
    <link rel="apple-touch-icon" sizes="180x180" href="/assets/images/apple-touch-icon.png">
    <link rel="manifest" href="/site.webmanifest">

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="/assets/alert.js"></script>
</head>
<body class="bg-gradient-to-tl from-stone-300 via-yellow-200 to-stone-300">
    <!-- Navigation Bar -->
    <nav class="backdrop-blur-sm bg-white/30 shadow-lg fixed w-full top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex-shrink-0">
                    <a href="<c:url value='/HomeServlet' />" class="flex items-center">
                        <img src="<c:url value='/assets/Logo.png' />" alt="TourGuide Logo" class="h-10 w-auto">
                    </a>
                </div>

                <!-- Navigation Links -->
                <div class="hidden md:flex justify-center flex-grow space-x-6 items-center">
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
                                <a href="<c:url value='/HomeServlet' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Home</a>
                                <a href="<c:url value='/ReservationServlet?action=list' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">My Reservations</a>
                                <a href="<c:url value='/ReviewServlet?action=list' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">My Reviews</a>
                                <div class="relative group">
                                    <a href="<c:url value='/TourServlet?action=list' />"
                                        class="text-gray-700 hover:text-yellow-600 transition duration-300">
                                        Tours
                                        <i id="tours-dropdown-icon" class="ml-1 text-xs fas fa-chevron-down"></i>
                                    </a>
                                    <div class="absolute hidden group-hover:block bg-white shadow-lg rounded w-48">
                                        <a href="<c:url value='/TourServlet?action=listByCategory&category=casa' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Casablanca</a>
                                        <a href="<c:url value='/TourServlet?action=listByCategory&category=marrakech' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Marrakech</a>
                                        <a href="<c:url value='/TourServlet?action=listByCategory&category=merzouga' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Merzouga</a>
                                        <a href="<c:url value='/TourServlet?action=listByCategory&category=tanger' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Tanger</a>
                                        <a href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Fes</a>
                                    </div>
                                </div>
                                <a href="<c:url value='/includes/contact.jsp' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Contact us</a>
                                <a href="<c:url value='/includes/about.jsp' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">About us</a>
                            </c:if>
                        </c:when>
                    </c:choose>
                </div>
               <c:if test="${empty sessionScope.user_id}">
                    <div class="hidden md:flex justify-center flex-grow space-x-6 items-center">
                        <a href="<c:url value='/HomeServlet' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Home</a>
                        <div class="relative group">
                            <a href="<c:url value='/TourServlet?action=list' />"
                                class="text-gray-700 hover:text-yellow-600 transition duration-300">
                                Tours
                                <i id="tours-dropdown-icon" class="ml-1 text-xs fas fa-chevron-down"></i>
                            </a>
                            <div class="absolute hidden group-hover:block bg-white shadow-lg rounded w-48">
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=casa' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Casablanca</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=marrakech' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Marrakech</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=merzouga' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Merzouga</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=tanger' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Tanger</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Fes</a>
                            </div>
                        </div>
                        <a href="<c:url value='/includes/contact.jsp' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">Contact us</a>
                        <a href="<c:url value='/includes/about.jsp' />" class="text-gray-700 hover:text-yellow-600 transition duration-300">About us</a>
                    </div>
                    <div class="hidden md:flex space-x-2 ml-auto">
                        <a href="<c:url value='/auth/login.jsp' />"
                            class="px-6 py-2 bg-stone-500 text-white text-sm font-medium rounded-full hover:bg-yellow-600 transition duration-300">
                            Login
                        </a>
                        <a href="<c:url value='/auth/register.jsp' />"
                            class="px-6 py-2 bg-yellow-500 text-white text-sm font-medium rounded-full hover:bg-yellow-600 transition duration-300">
                            Get Started
                            <i class="fa-solid fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </c:if>

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
        <div id="navbar-links" class="md:hidden hidden bg-gradient-to-tl from-stone-400 via-yellow-300 to-stone-300">
            <c:choose>
                <c:when test="${not empty sessionScope.user_id}">
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-map-marked-alt mr-2"></i>Tours</a>
                        <a href="<c:url value='/UserServlet' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-users mr-2"></i>Users</a>
                        <a href="<c:url value='/ReservationServlet?action=listAll' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-calendar-check mr-2"></i>Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=listAll' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-star mr-2"></i>Reviews</a>
                        <a href="<c:url value='/ActivityServlet' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-route mr-2"></i>Activities</a>
                    </c:if>
                    <c:if test="${sessionScope.role == 'user'}">
                        <a href="<c:url value='/ReservationServlet?action=list' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-calendar-check mr-2"></i>My Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=list' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-star mr-2"></i>My Reviews</a>
                        <div class="relative">
                            <button onclick="toggleToursDropdown()" class="w-full text-left text-gray-700 p-2 hover:bg-yellow-500 flex items-center justify-between">
                                <span><i class="fas fa-map-marked-alt mr-2"></i>Tours</span>
                                <i id="tours-dropdown-icon" class="fas fa-chevron-down"></i>
                            </button>
                            <div id="tours-dropdown" class="hidden">
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=casa' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Casablanca</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=marrakech' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Marrakech</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=merzouga' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Merzouga</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=tanger' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Tanger</a>
                                <a href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Fes</a>
                            </div>
                        </div>
                        <a href="<c:url value='/includes/contact.jsp' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-envelope mr-2"></i>Contact us</a>
                    </c:if>
                    <a href="<c:url value='/LogoutServlet' />" class="block text-gray-700 p-2 hover:bg-red-400"><i class="fas fa-sign-out-alt mr-2"></i>Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/HomeServlet' />" class="block text-gray-700 p-2 hover:bg-yellow-500">Home</a>
                    <div class="relative">
                        <button onclick="toggleToursDropdown()" class="w-full text-left text-gray-700 p-2 hover:bg-yellow-500 flex items-center justify-between">
                            <span>Tours</span>
                            <i id="tours-dropdown-icon" class="fas fa-chevron-down"></i>
                        </button>
                        <div id="tours-dropdown" class="hidden">
                            <a href="<c:url value='/TourServlet?action=listByCategory&category=casa' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Casablanca</a>
                            <a href="<c:url value='/TourServlet?action=listByCategory&category=marrakech' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Marrakech</a>
                            <a href="<c:url value='/TourServlet?action=listByCategory&category=merzouga' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Merzouga</a>
                            <a href="<c:url value='/TourServlet?action=listByCategory&category=tanger' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Tanger</a>
                            <a href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="block px-4 py-2 text-gray-700 hover:bg-yellow-600 hover:text-white transition duration-300">From Fes</a>
                        </div>
                    </div>
                    <a href="<c:url value='/includes/contact.jsp' />" class="block text-gray-700 p-2 hover:bg-yellow-500">Contact us</a>
                    <a href="<c:url value='/includes/about.jsp' />" class="block text-gray-700 p-2 hover:bg-yellow-500">About us</a>
                    <a href="<c:url value='/auth/login.jsp' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fas fa-sign-in-alt mr-2"></i>Login</a>
                    <a href="<c:url value='/auth/register.jsp' />" class="block text-gray-700 p-2 hover:bg-yellow-500"><i class="fa-solid fa-arrow-right mr-2"></i>Get Started</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

<div class="mt-16 mx-auto">

<script>
    document.addEventListener('click', function(event) {
        const dropdowns = document.querySelectorAll('.group');
        dropdowns.forEach((dropdown) => {
            if (!dropdown.contains(event.target)) {
                const menu = dropdown.querySelector('.absolute');
                if (menu) {
                    menu.classList.add('hidden');
                }
            }
        });
    });
    // Toggle mobile menu
    function toggleMenu() {
        const mobileMenu = document.getElementById('navbar-links');
        mobileMenu.classList.toggle('hidden');
    }

    // Toggle Tours dropdown in mobile menu
    function toggleToursDropdown() {
        const toursDropdown = document.getElementById('tours-dropdown');
        const toursDropdownIcon = document.getElementById('tours-dropdown-icon');
        toursDropdown.classList.toggle('hidden');
        toursDropdownIcon.classList.toggle('fa-chevron-down');
        toursDropdownIcon.classList.toggle('fa-chevron-up');
    }

    // Close dropdowns when clicking outside
    document.addEventListener('click', function(event) {
        const dropdowns = document.querySelectorAll('.relative');
        dropdowns.forEach((dropdown) => {
            if (!dropdown.contains(event.target)) {
                const menu = dropdown.querySelector('.hidden');
                if (menu) {
                    menu.classList.add('hidden');
                }
            }
        });
    });
</script>