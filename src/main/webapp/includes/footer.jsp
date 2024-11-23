<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </div>

    <footer class="bg-gray-800 text-white py-8">
    <div class="container mx-auto px-4">
        <!-- About Section -->
        <div class="mb-8">
            <h3 class="text-lg font-semibold mb-2">About Us</h3>
            <p class="text-sm">
                Welcome to TourGuide Management System, your trusted companion for unforgettable travel experiences. Discover tours, connect with guides, and explore the world.
            </p>
        </div>

        <!-- Contact Section with Maps -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Contact Form -->
            <div>
                <h3 class="text-lg font-semibold mb-4">Contact Us</h3>
                <form id="contact-form" action="<c:url value='/ContactServlet' />" method="post" class="space-y-4">
                    <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Your Name"
                        class="w-full p-2 bg-gray-700 text-white rounded-md" 
                        required>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Your Email"
                        class="w-full p-2 bg-gray-700 text-white rounded-md" 
                        required>
                    <textarea
                        id="message"
                        name="message"
                        rows="5"
                        placeholder="Your Message"
                        class="w-full p-2 bg-gray-700 text-white rounded-md" 
                        required></textarea>
                    <button
                        type="submit"
                        class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">
                        Send
                    </button>
                </form>
            </div>

            <!-- Maps -->
            <div>
                <h3 class="text-lg font-semibold mb-4">Our Location</h3>
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3151.8354345096195!2d144.9537353153167!3d-37.81621897975179!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad642af0f11fd81%3A0xf577d0f6886b5bfb!2sFederation%20Square!5e0!3m2!1sen!2sau!4v1638894812113!5m2!1sen!2sau" 
                    class="w-full h-64 border-0 rounded-md"
                    allowfullscreen=""
                    loading="lazy">
                </iframe>
            </div>
        </div>
    </div>
    <div class="text-center">
        <p class="text-sm">&copy; 2024 TourGuide Management System. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
