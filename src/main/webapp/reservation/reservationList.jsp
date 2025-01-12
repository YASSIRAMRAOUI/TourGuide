<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container mx-auto p-10">
    <div class="flex items-center justify-between mb-6 border-b-2 border-gray-300 pb-2">
        <h2 class="text-3xl font-extrabold text-gray-800">
            ${sessionScope.role == 'admin' ? "All Reservations" : "My Reservations"}
        </h2>
        <c:if test="${sessionScope.role == 'admin'}">
            <form action="ReservationServlet" method="get" class="flex">
                <input
                    type="text"
                    name="search"
                    placeholder="Search reservations..."
                    class="border border-gray-300 rounded-l-lg px-4 py-2"
                    value="${searchQuery != null ? searchQuery : ''}">
                <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-r-lg">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </c:if>
    </div>

    <!-- No Reservations Message -->
    <c:if test="${empty reservations}">
        <div class="text-center text-gray-500">
            <i class="fas fa-info-circle text-xl"></i>
            <p>No reservations found.</p>
        </div>
    </c:if>

    <!-- Reservations Card Layout -->
    <c:if test="${not empty reservations}">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="reservation" items="${reservations}">
                <div class="bg-white shadow-md rounded-lg overflow-hidden">
                    <!-- Tour Image -->
                    <c:if test="${reservation.imagePath != null && !reservation.imagePath.isEmpty()}">
                        <a href="TourServlet?action=view&id=${reservation.reservationId}">
                            <img src="${pageContext.request.contextPath}/${reservation.imagePath}"
                                alt="${reservation.tourTitle}"
                                class="w-full h-48 object-cover">
                        </a>
                    </c:if>
                    <c:if test="${reservation.imagePath == null || reservation.imagePath.isEmpty()}">
                        <img src="${pageContext.request.contextPath}/assets/defaultTour.png"
                            alt="Default Tour Image"
                            class="w-full h-48 object-cover">
                    </c:if>

                    <div class="p-4">
                        <!-- Tour Title and Date -->
                        <div class="flex justify-between items-center mb-2">
                            <h3 class="text-lg font-bold text-gray-900">
                                <i class="fas fa-map-marker-alt text-gray-500 mr-1"></i>
                                ${reservation.tourTitle}
                            </h3>
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fas fa-calendar-alt text-gray-400 mr-1"></i>
                                ${reservation.reservationDate}
                            </p>
                        </div>

                        <!-- People and Status -->
                        <div class="flex justify-between items-center mb-2">
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fas fa-users text-gray-400 mr-1"></i>
                                People: ${reservation.numberOfPeople}
                            </p>
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fas fa-info-circle text-gray-400 mr-1"></i>
                                Status:
                                <span class="px-2 py-1 rounded text-xs font-medium
                                    ${reservation.status == 'Confirmed'
                                        ? 'bg-green-100 text-green-800'
                                        : reservation.status == 'Pending'
                                            ? 'bg-yellow-100 text-yellow-800'
                                            : 'bg-red-100 text-red-800'}">
                                    ${reservation.status}
                                </span>
                            </p>
                        </div>

                        <!-- User Info (Admin Only) -->
                        <c:if test="${sessionScope.role == 'admin'}">
                            <div class="flex justify-between items-center mb-2 text-gray-600 text-sm">
                                <p class="flex items-center">
                                    <i class="fas fa-user text-gray-400 mr-1"></i>
                                    ${reservation.userName}
                                </p>
                                <p class="flex items-center">
                                    <i class="fas fa-envelope text-gray-400 mr-1"></i>
                                    ${reservation.userEmail}
                                </p>
                            </div>
                        </c:if>

                        <!-- Action Buttons -->
                        <div class="flex justify-between mt-4">
                            <c:if test="${reservation.status == 'Pending' || reservation.status == 'Cancelled'}">
                                <a href="ReservationServlet?action=edit&id=${reservation.reservationId}"
                                class="text-blue-500 hover:text-blue-700 flex items-center space-x-1">
                                    <i class="fas fa-edit"></i>
                                    <span>Edit</span>
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.role == 'user' && reservation.status == 'Confirmed' && !reservation.hasReviewed}">
                                <a href="ReviewServlet?action=insert&tourId=${reservation.tourId}&tourTitle=${reservation.tourTitle}"
                                    class="text-yellow-500 hover:text-yellow-700 flex items-center space-x-1">
                                    <i class="fa-regular fa-comment"></i>
                                    <span>Comment</span>
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.role == 'user' && reservation.status == 'Confirmed' && reservation.hasReviewed}">
                                <span class="text-gray-500 flex items-center space-x-1">
                                    <i class="fa-regular fa-comment-slash"></i>
                                    <span>Already Reviewed</span>
                                </span>
                            </c:if>
                            <button onclick="openDeleteReservation(${reservation.reservationId})"
                                    class="text-red-500 hover:text-red-700 flex items-center space-x-1">
                                <i class="fas fa-trash-alt"></i>
                                <span>Delete</span>
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg w-1/3">
        <div class="p-6">
            <h2 class="text-xl font-semibold text-gray-700 flex items-center space-x-2">
                <i class="fas fa-exclamation-triangle text-yellow-500"></i>
                <span>Confirm Delete</span>
            </h2>
            <p class="text-gray-600 mt-2">Are you sure you want to delete this reservation? This action cannot be undone.</p>
        </div>
        <div class="flex justify-end p-4 border-t border-gray-200">
            <button class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md mr-2" onclick="closeDeleteModal()">Cancel</button>
            <a id="deleteConfirmBtn" href="#" class="bg-red-500 text-white px-4 py-2 rounded-md flex items-center space-x-1">
                <span>Delete</span>
            </a>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
