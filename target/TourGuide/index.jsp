<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<!-- Hero Section -->
<div class="relative bg-gradient-to-r from-blue-600 to-green-600 text-white py-20 overflow-hidden h-96">
    <!-- Swiper Container -->
    <div class="swiper-container absolute inset-0 w-full h-full">
        <div class="swiper-wrapper">
            <!-- Slide 1 -->
            <div class="swiper-slide">
                <img src="/assets/hero1.webp" alt="TourGuide Hero Image 1" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Explore the World</h2>
                    <p class="text-lg">Discontain breathtaking destinations with our guided tours.</p>
                </div>
            </div>
            <!-- Slide 2 -->
            <div class="swiper-slide">
                <img src="/assets/hero2.jpg" alt="TourGuide Hero Image 2" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Adventure Awaits</h2>
                    <p class="text-lg">Experience thrilling activities and create unforgettable memories.</p>
                </div>
            </div>
            <!-- Slide 3 -->
            <div class="swiper-slide">
                <img src="/assets/hero3.webp" alt="TourGuide Hero Image 3" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Plan Your Journey</h2>
                    <p class="text-lg">Let us help you organize the perfect trip.</p>
                </div>
            </div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>
</div>

<!-- Main Content -->
<div class="container mx-auto px-4 py-12">
    <!-- Tours Section -->
    <section class="mb-12">
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800">Available Tours</h2>
            <a href="TourServlet?action=list" class="text-blue-600 hover:text-blue-800 transition duration-300">View All Tours</a>
        </div>
        <c:if test="${not empty tours}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach var="tour" items="${tours}">
                    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300">
                        <c:choose>
                            <c:when test="${not empty tour.imagePath}">
                                <img src="${pageContext.request.contextPath}/${tour.imagePath}" alt="${tour.title}" class="h-48 w-full object-cover">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/defaultTour.png" alt="Default Image" class="h-48 w-full object-cover">
                            </c:otherwise>
                        </c:choose>
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-gray-800 mb-2">
                                <a href="TourServlet?action=view&id=${tour.tourId}" class="hover:text-teal-600 transition duration-300">${tour.title}</a>
                            </h3>
                            <p class="text-gray-600 mb-4">${tour.description.substring(0, Math.min(tour.description.length(), 100))}...</p>
                            <a href="TourServlet?action=view&id=${tour.tourId}" class="text-blue-600 hover:text-blue-800 transition duration-300">Learn More</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty tours}">
            <p class="text-gray-500">No tours available at the moment.</p>
        </c:if>
    </section>

    <!-- Activities Section -->
    <section>
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800">Exciting Activities</h2>
            <a href="ActivityServlet?action=list" class="text-blue-600 hover:text-blue-800 transition duration-300">View All Activities</a>
        </div>
        <c:if test="${not empty activities}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach var="activity" items="${activities}">
                    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300">
                        <c:choose>
                            <c:when test="${not empty activity.imagePath}">
                                <img src="${pageContext.request.contextPath}/${activity.imagePath}" alt="${activity.name}" class="h-48 w-full object-cover">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/defaultActivity.png" alt="Default Image" class="h-48 w-full object-cover">
                            </c:otherwise>
                        </c:choose>
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-gray-800 mb-2">${activity.name}</h3>
                            <p class="text-gray-600">${activity.description.substring(0, Math.min(activity.description.length(), 100))}...</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty activities}">
            <p class="text-gray-500">No activities available at the moment.</p>
        </c:if>
    </section>
</div>

<jsp:include page="/includes/footer.jsp" />



<!-- Swiper JS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->
<script>
    const swiper = new Swiper('.swiper-container', {
        loop: true, // Infinite loop
        effect: 'fade', // Fade effect
        autoplay: {
            delay: 3000, // Auto-slide every 3 seconds
            disableOnInteraction: false, // Continue autoplay after user interaction
        },
        pagination: {
            el: '.swiper-pagination', // Pagination dots
            clickable: true,
        },
    });
</script>