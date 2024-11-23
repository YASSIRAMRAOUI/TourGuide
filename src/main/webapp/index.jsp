<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<!-- Hero Section -->
<div class="relative bg-gradient-to-r from-blue-600 to-green-600 text-white">
    <div class="container mx-auto flex flex-col items-center justify-center h-96 text-center">
        <h1 class="text-5xl font-extrabold mb-4">Welcome to TourGuide Management System</h1>
        <p class="text-lg font-medium mb-6">Explore, plan, and manage your travel adventures seamlessly.</p>
        <a href="TourServlet?action=list" 
           class="px-6 py-3 bg-teal-500 rounded-lg text-lg font-semibold shadow-md hover:bg-teal-600 transition">
            Browse Tours
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="container mx-auto px-4 py-12">
    <!-- Tours Section -->
    <section class="mb-12">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-bold text-gray-800">Available Tours</h2>
            <a href="TourServlet?action=list" class="text-blue-500 hover:underline">View All Tours</a>
        </div>
        <c:if test="${not empty tours}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="tour" items="${tours}">
                    <!-- Tour Card -->
                    <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
                        <!-- Tour Image -->
                        <c:if test="${tour.imagePath != null && !tour.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/${tour.imagePath}" alt="${tour.title}"
                                 class="h-48 w-full object-cover">
                        </c:if>
                        <c:if test="${tour.imagePath == null || tour.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/assets/defaultTour.png" alt="Default Image"
                                 class="h-48 w-full object-cover">
                        </c:if>
                        <!-- Tour Details -->
                        <div class="p-4">
                            <h3 class="text-xl font-bold text-gray-800 mb-2">
                                <a href="TourServlet?action=view&id=${tour.tourId}" class="hover:text-teal-600">
                                    ${tour.title}
                                </a>
                            </h3>
                            <p class="text-gray-600 mb-4">${tour.description.substring(0, Math.min(tour.description.length(), 100))}...</p>
                            <a href="TourServlet?action=view&id=${tour.tourId}" 
                               class="text-blue-500 hover:underline font-medium">Learn More</a>
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
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-bold text-gray-800">Exciting Activities</h2>
            <a href="ActivityServlet?action=list" class="text-blue-500 hover:underline">View All Activities</a>
        </div>
        <c:if test="${not empty activities}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="activity" items="${activities}">
                    <!-- Activity Card -->
                    <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
                        <!-- Activity Image -->
                        <c:if test="${activity.imagePath != null && !activity.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/${activity.imagePath}" alt="${activity.name}"
                                 class="h-48 w-full object-cover">
                        </c:if>
                        <c:if test="${activity.imagePath == null || activity.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/assets/defaultActivity.png" alt="Default Image"
                                 class="h-48 w-full object-cover">
                        </c:if>
                        <!-- Activity Details -->
                        <div class="p-4">
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
