<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<!-- Full-Width Tour Image -->
<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <c:if test="${tour.imagePath != null && !tour.imagePath.isEmpty()}">
        <img src="${pageContext.request.contextPath}/${tour.imagePath}" alt="${tour.title}"
             class="h-full w-full object-fill">
    </c:if>
    <c:if test="${tour.imagePath == null || tour.imagePath.isEmpty()}">
        <img src="${pageContext.request.contextPath}/assets/defaultTour.png" alt="Default Image"
             class="h-full w-full object-fill">
    </c:if>
</div>

<div class="px-6 py-2">
    <h1 class="text-2xl font-bold text-gray-800">${tour.title}</h1>
    <p class="text-sm text-gray-600 mt-1">${tour.description}</p>
</div>

<!-- Map and Reservation Form -->
<div class="grid grid-cols-1 sm:grid-cols-2 gap-6 p-6">
    <div class="bg-white p-4 rounded-lg shadow">
        <h2 class="text-lg font-semibold text-gray-800 mb-4">Make a Reservation</h2>
        <form action="ReservationServlet?action=insert" method="post" class="space-y-4">
            <!-- Tour ID -->
            <input type="hidden" name="tourId" value="${tour.tourId}" />

            <!-- Reservation Date -->
            <div>
                <label for="reservationDate" class="block text-sm font-medium text-gray-700 mb-1">Reservation Date</label>
                    <input
                        type="date"
                        id="reservationDate"
                        name="reservationDate"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500"
                    >
            </div>

            <!-- Number of People -->
            <div>
                <label for="numberOfPeople" class="block text-sm font-medium text-gray-700 mb-1">Number of People</label>
                    <input
                        type="number"
                        id="numberOfPeople"
                        name="numberOfPeople"
                        min="1"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500"
                    >
            </div>

            <!-- Submit Button -->
            <div>
                <button
                    type="submit"
                    class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition duration-300"
                >
                Reserve Now
                </button>
            </div>
        </form>
    </div>

    <!-- Map Embed Code -->
    <c:if test="${not empty tour.mapEmbedCode}">
        <div class="map-container rounded-lg shadow-md">
            <c:out value="<iframe src='${tour.mapEmbedCode}' width='100%' height='300' style='border:0;' allowfullscreen='' loading='lazy' referrerpolicy='no-referrer-when-downgrade'></iframe>" escapeXml="false" />
        </div>
        </c:if>
    </div>
</div>


<div class="grid grid-cols-1 sm:grid-cols-4 gap-6 m-8">
    <!-- Location Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-map-marker-alt text-red-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Location:</strong></p>
            <p class="text-white text-base">${tour.location}</p>
        </div>
    </div>

    <!-- Date Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-calendar-alt text-green-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Date:</strong></p>
            <p class="text-white text-base">${tour.date}</p>
        </div>
    </div>

    <!-- Category Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-tags text-yellow-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Category:</strong></p>
            <p class="text-white text-base">${tour.category}</p>
        </div>
    </div>
                
    <!-- Price Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-dollar-sign text-blue-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Price:</strong></p>
            <p class="text-white text-base">${tour.price}</p>
        </div>
    </div>
</div>



<!-- Associated Activity Section -->
<div class="m-4">
    <h2 class="text-xl font-semibold text-gray-700 flex items-center mb-4">
        <i class="fas fa-route mr-2"></i> Associated Activity
    </h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <c:forEach var="activity" items="${activities}">
            <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300">
                <a href="ActivityServlet?action=view&id=${activity.activityId}">
                    <c:if test="${activity.imagePath != null && !activity.imagePath.isEmpty()}">
                        <img src="${pageContext.request.contextPath}/${activity.imagePath}"
                             alt="${activity.name}" 
                             class="h-48 w-full object-cover">
                    </c:if>
                    <c:if test="${activity.imagePath == null || activity.imagePath.isEmpty()}">
                        <img src="${pageContext.request.contextPath}/assets/defaultBg.png"
                             alt="Default Activity Image"
                             class="h-48 w-full object-cover">
                    </c:if>
                </a>
                <div class="p-4">
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        <a href="ActivityServlet?action=view&id=${activity.activityId}" class="hover:text-blue-600">
                            ${activity.name}
                        </a>
                    </h3>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/includes/footer.jsp" />
