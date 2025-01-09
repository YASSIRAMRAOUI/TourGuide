<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</div>

<footer class="bg-gradient-to-r from-yellow-900 to-yellow-600 text-white py-12">
    <div class="container mx-auto px-4">
        <!-- About Section -->
        <div class="mb-8">
            <h3 class="text-lg font-semibold mb-4">About Us</h3>
            <p class="text-sm text-gray-300">
                Welcome to TourGuide Management System, your trusted companion for unforgettable travel experiences. Discover tours, connect with guides, and explore the world.
            </p>
        </div>

        <!-- Contact Section with Maps -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Contact Form -->
            <div>
                <h3 class="text-lg font-semibold mb-4">Contact Us</h3>
                <!-- Display Success or Error Message -->
                <c:if test="${not empty message}">
                    <div class="p-4 mb-4 text-green-700 bg-green-200 rounded-md">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="p-4 mb-4 text-red-700 bg-red-200 rounded-md">${error}</div>
                </c:if>
                <form id="contact-form" action="<c:url value='/ContactServlet' />" method="post" class="space-y-4">
                    <input type="text" id="name" name="name" placeholder="Your Name"
                        class="w-full p-2 bg-gray-700 text-white rounded-md focus:outline-none focus:ring-2 focus:ring-blue-600" 
                        required>
                    <input type="email" id="email" name="email" placeholder="Your Email"
                        class="w-full p-2 bg-gray-700 text-white rounded-md focus:outline-none focus:ring-2 focus:ring-blue-600" 
                        required>
                    <textarea id="message" name="message" rows="5" placeholder="Your Message"
                        class="w-full p-2 bg-gray-700 text-white rounded-md focus:outline-none focus:ring-2 focus:ring-blue-600" 
                        required></textarea>
                    <button type="submit"
                        class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md transition duration-300">
                        Send
                    </button>
                </form>
            </div>

            <!-- Maps -->
            <div>
                <h3 class="text-lg font-semibold mb-4">Our Location</h3>
                <iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d105867.01280859727!2d-6.868173!3d33.983693!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sma!4v1736341879944!5m2!1sen!2sma"
                        class="w-full h-64 border-0 rounded-md"
                        allowfullscreen=""
                        loading="lazy">
                </iframe>
            </div>
        </div>
    </div>
    <div class="text-center mt-8">
        <p class="text-sm text-gray-300">&copy; 2024 TourGuide Management System. All Rights Reserved.</p>
    </div>
</footer>
</body>
</html>
