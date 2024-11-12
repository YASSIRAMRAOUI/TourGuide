<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tour Guide Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="flex flex-col h-screen bg-gray-100 font-sans">

    <!-- Header Section with Logo and Language Switch -->
    <header class="w-full bg-gradient-to-r from-blue-600 to-green-600 text-white text-center py-4 flex-shrink-0">
        <div class="flex items-center justify-between mx-6">
            <!-- Logo and Title -->
            <div class="flex items-center space-x-4">
                <%-- <img src="assets/touriste.jpg" alt="Carpooling Service Logo" class="w-14 h-14 animate-spin-slow"> --%>
                <h1 class="text-4xl font-bold">Tour Guide Management System</h1>
            </div>

            <!-- Language Switch Icons -->
            <div class="flex space-x-4">
                <!-- English Flag -->
                <a href="ChangeLanguageServlet?lang=en" title="English" class="hover:opacity-75">
                    en
                </a>
                <!-- Spanish Flag -->
                <a href="ChangeLanguageServlet?lang=es" title="Español" class="hover:opacity-75">
                    es
                </a>
                <!-- French Flag -->
                <a href="ChangeLanguageServlet?lang=fr" title="Français" class="hover:opacity-75">
                    fr
                </a>
            </div>
        </div>
        <p class="text-gray-100 mt-2">Connecting tourists with experienced guides for unforgettable journeys.</p>
    </header>

    <!-- Main Content Section with Image -->
    <div class="flex flex-1 items-center justify-center w-full">
        <div class="flex flex-col items-center w-full max-w-3xl px-6 text-center animate-fadeIn">
            <!-- Content Image -->
            <img src="assets/touriste.jpg" alt="Tour Guide Image" class="w-full h-64 object-cover rounded-lg shadow-lg mb-6 mx-auto max-w-md">
            <h2 class="text-3xl font-semibold text-gray-800 mb-4">Welcome to Our Tour Guide Management System</h2>
            <p class="text-gray-600 mb-8 leading-relaxed">
                Explore new destinations and experiences with our platform. Whether you're a tourist looking to discover unique places or a guide aiming to share your knowledge,
                our system connects you to the best opportunities. Make reservations, plan activities, and engage with other travelers and guides in one seamless experience.
            </p>

            <!-- Navigation Buttons with Hover Animation -->
            <div class="space-x-6">
                <a href="auth/login.jsp" class="inline-block px-8 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-500 transform hover:scale-105 transition duration-200">Login</a>
                <a href="auth/register.jsp" class="inline-block px-8 py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-500 transform hover:scale-105 transition duration-200">Register</a>
            </div>
        </div>
    </div>

    <!-- Footer Section -->
    <footer class="w-full bg-gray-900 text-white text-center py-4 flex-shrink-0">
        <p class="text-sm">&copy; 2024 Tour Guide Management System - All Rights Reserved</p>
    </footer>

    <!-- Custom Animations -->
    <style>
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .animate-fadeIn {
            animation: fadeIn 1.5s ease-out forwards;
        }
        @keyframes spinSlow {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        .animate-spin-slow {
            animation: spinSlow 20s linear infinite;
        }
    </style>
</body>
</html>
