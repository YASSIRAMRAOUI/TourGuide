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

        <div class="container mx-auto px-6 py-12">
            <div class="md:flex md:items-center md:justify-between">
                <div class="mb-8 md:mb-0">
                    <h1 class="text-2xl font-bold text-gray-800">${tour.title}</h1>
                    <p class="text-sm text-gray-600 mt-1">${tour.description}</p>
                </div>
            </div>
        </div>

        <div class="m-8">
            <div class="grid grid-cols-1 sm:grid-cols-4 gap-6">
                <!-- Location Card -->
                <div class="bg-white shadow-md rounded-lg p-4 flex items-center">
                    <i class="fas fa-map-marker-alt text-red-500 text-2xl mr-4"></i>
                    <div>
                        <p class="text-gray-600 text-sm"><strong>Location:</strong></p>
                        <p class="text-gray-800 text-base">${tour.location}</p>
                    </div>
                </div>
                <!-- Date Card -->
                <div class="bg-white shadow-md rounded-lg p-4 flex items-center">
                    <i class="fas fa-calendar-alt text-green-500 text-2xl mr-4"></i>
                    <div>
                        <p class="text-gray-600 text-sm"><strong>Date:</strong></p>
                        <p class="text-gray-800 text-base">${tour.date}</p>
                    </div>
                </div>
                <!-- Category Card -->
                <div class="bg-white shadow-md rounded-lg p-4 flex items-center">
                    <i class="fas fa-tags text-yellow-500 text-2xl mr-4"></i>
                    <div>
                        <p class="text-gray-600 text-sm"><strong>Category:</strong></p>
                        <p class="text-gray-800 text-base">${tour.category}</p>
                    </div>
                </div>
                <!-- Price Card -->
                <div class="bg-white shadow-md rounded-lg p-4 flex items-center">
                    <i class="fas fa-dollar-sign text-blue-500 text-2xl mr-4"></i>
                    <div>
                        <p class="text-gray-600 text-sm"><strong>Price:</strong></p>
                        <p class="text-gray-800 text-base">${tour.price}</p>
                    </div>
                </div>
            </div>
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
            <div class="bg-white p-4 rounded-lg shadow">
                <c:if test="${not empty tour.mapEmbedCode}">
                    <div class="mb-6">
                        <h2 class="text-xl font-bold text-gray-800 mb-4">Map</h2>
                        <div class="map-container">
                            <c:out value="<iframe src='${tour.mapEmbedCode}' width='100%' height='300' style='border:0;' allowfullscreen='' loading='lazy' referrerpolicy='no-referrer-when-downgrade'></iframe>" escapeXml="false" />
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
