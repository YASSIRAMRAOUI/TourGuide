<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />

<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <img src="../assets/hero2.jpg" alt="Contact Us" class="h-full w-full object-fill">
</div>

<div class="container mx-auto p-5 md:px-20">
    <div class="flex items-center justify-between mb-6 border-b-2 border-gray-300 pb-2">
        <h2 class="text-3xl font-extrabold text-gray-800">
            ${category} tours
        </h2>
    </div>
    <!-- No Tours Message -->
    <c:if test="${empty tours}">
        <div class="text-center text-gray-500">
            <i class="fas fa-info-circle text-xl"></i>
            <p>No tours found.</p>
        </div>
    </c:if>

    <!-- Tours Card Layout -->
    <c:if test="${not empty tours}">
        <div class="flex flex-col space-y-4"> <!-- Vertical layout for multiple tours -->
            <c:forEach var="tour" items="${tours}">
    <div class="bg-white shadow-md rounded-lg overflow-hidden flex flex-col md:flex-row h-auto md:h-48">
        <!-- Tour Image -->
        <a href="TourServlet?action=view&id=${tour.tourId}" class="w-full md:w-1/3">
            <img src="${empty tour.imagePath ? '/default.jpg' : pageContext.request.contextPath}/${tour.imagePath}"
                alt="${tour.title}"
                class="w-full h-full object-cover">
        </a>

        <!-- Tour Details -->
        <div class="w-full md:w-2/3 p-4 flex flex-col justify-between">
            <!-- Tour Title and Average Rating -->
            <div class="flex items-center justify-between mb-2">
                <h3 class="text-xl font-bold text-gray-800">${tour.title}</h3>
                <div class="flex items-center text-yellow-500">
                    <c:set var="averageRating" value="${reviewDAO.getAverageRating(tour.tourId)}" />
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= averageRating}">
                                <i class="fas fa-star"></i>
                            </c:when>
                            <c:when test="${i - 0.5 <= averageRating}">
                                <i class="fas fa-star-half-alt"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="far fa-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <span class="ml-2 text-gray-600">(${averageRating > 0 ? averageRating : 'No reviews'})</span>
                </div>
            </div>

            <!-- Tour Duration, Route, and Price -->
            <div class="flex flex-col md:flex-row items-start md:items-center justify-between text-gray-600 mb-2">
                <div class="flex flex-col md:flex-row items-start md:items-center space-y-2 md:space-y-0 md:space-x-4">
                    <div class="flex items-center">
                        <i class="fas fa-clock text-yellow-700 mr-2"></i>
                        <span>${tour.date}</span>
                    </div>
                    <div class="flex items-center px-4">
                        <i class="fas fa-plane-departure text-yellow-700 mr-2"></i>
                        ${tour.start}
                        <i class="fas fa-plane text-yellow-700 mx-4"></i>
                        ${tour.end}
                        <i class="fas fa-plane-arrival text-yellow-700 ml-2"></i>
                    </div>
                </div>
                <p class="text-green-600 text-xl font-semibold mt-2 md:mt-0">
                    ${tour.price} EUR
                </p>
            </div>

            <!-- Comment and Admin Actions -->
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center border-t border-gray-200 pt-2 space-y-2 md:space-y-0">
                <c:if test="${sessionScope.role == 'user'}">
                    <c:set var="hasReviewed" value="${reviewDAO.hasUserReviewed(sessionScope.user_id, tour.tourId)}" />
                    <c:set var="reservationStatus" value="" />
                    <c:forEach var="reservation" items="${reservations}">
                        <c:if test="${reservation.tourId == tour.tourId}">
                            <c:set var="reservationStatus" value="${reservation.status}" />
                        </c:if>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${!hasReviewed && sessionScope.role == 'user' && reservationStatus == 'Confirmed'}">
                            <a href="ReviewServlet?action=insert&tourId=${tour.tourId}&tourTitle=${tour.title}"
                                class="text-yellow-500 hover:text-yellow-700 flex items-center space-x-1">
                                <i class="fa-regular fa-comment"></i>
                                <span>Comment</span>
                            </a>
                        </c:when>
                        <c:when test="${hasReviewed}">
                            <a href="ReviewServlet?action=list"
                                class="text-gray-500 flex items-center space-x-1">
                                <i class="fa-solid fa-comment-slash"></i>
                                <span>Already Reviewed</span>
                            </a>
                        </c:when>
                    </c:choose>
                </c:if>
                <c:if test="${sessionScope.role == 'admin'}">
                    <a href="TourServlet?action=edit&id=${tour.tourId}"
                        class="text-yellow-500 hover:text-yellow-700 flex items-center space-x-1">
                        <i class="fas fa-edit"></i>
                        <span>Edit</span>
                    </a>
                    <button onclick="openDeleteTour(${tour.tourId})"
                            class="text-red-500 hover:text-red-700 flex items-center space-x-1">
                        <i class="fas fa-trash-alt"></i>
                        <span>Delete</span>
                    </button>
                </c:if>
                <a href="TourServlet?action=view&id=${tour.tourId}"
                   class="bg-yellow-500 text-white px-4 py-2 rounded-md hover:bg-yellow-600 transition duration-300">
                    View Details
                </a>
            </div>
        </div>
    </div>
</c:forEach>
        </div>
    </c:if>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg w-11/12 md:w-1/3">
        <div class="p-6">
            <h2 class="text-xl font-semibold text-gray-700 flex items-center space-x-2">
                <i class="fas fa-exclamation-triangle text-yellow-500"></i>
                <span>Confirm Delete</span>
            </h2>
            <p class="text-gray-600 mt-2">Are you sure you want to delete this tour? This action cannot be undone.</p>
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

<script>
    function openDeleteTour(tourId) {
        document.getElementById('deleteConfirmBtn').href = "TourServlet?action=delete&id=" + tourId;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }
</script>