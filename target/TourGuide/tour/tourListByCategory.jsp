<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />


<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <img src="../assets/hero2.jpg" alt="Contct Us"
        class="h-full w-full object-fill">
</div>

<div class="container mx-auto p-5">
    <!-- No Tours Message -->
    <c:if test="${empty tours}">
        <div class="text-center text-gray-500">
            <i class="fas fa-info-circle text-xl"></i>
            <p>No tours found.</p>
        </div>
    </c:if>

    <!-- Tours Card Layout -->
    <c:if test="${not empty tours}">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="tour" items="${tours}">
                <div class="bg-white shadow-md rounded-lg overflow-hidden">
                    <!-- Tour Image -->
                    <a href="TourServlet?action=view&id=${tour.tourId}">
                        <img src="${empty tour.imagePath ? '/default.jpg' : pageContext.request.contextPath}/${tour.imagePath}"
                            alt="${tour.title}"
                            class="w-full h-48 object-cover">
                    </a>

                    <div class="p-4">
                        <!-- Tour Title and Date -->
                        <div class="flex justify-between items-center mb-2">
                            <p class="text-gray-600 flex items-center">
                                <i class="fa-solid fa-plane-departure text-yellow-900 mr-2"></i>
                                ${tour.location}
                            </p>
                            <p class="text-gray-600 flex items-center">
                                <i class="fas fa-calendar-alt text-yellow-700 mr-2"></i>
                                ${tour.date}
                            </p>
                        </div>

                        <!-- Location and Price -->
                        <div class="flex justify-between items-center mb-2">
                            <c:if test="${sessionScope.role == 'user'}">
                                <c:set var="hasReviewed" value="${reviewDAO.hasUserReviewedTour(sessionScope.user_id, tour.tourId)}" />
                                <c:choose>
                                    <c:when test="${!hasReviewed}">
                                        <a href="ReviewServlet?action=insert&tourId=${tour.tourId}&tourTitle=${tour.title}"
                                            class="text-yellow-500 hover:text-yellow-700 flex items-center space-x-1">
                                            <i class="fa-regular fa-comment"></i>
                                            <span>Comment</span>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-500 flex items-center space-x-1">
                                            <i class="fa-regular fa-comment-slash"></i>
                                            <span>Already Reviewed</span>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <p class="text-green-600 text-lg flex items-center">
                                ${tour.price}
                                <i class="fas fa-dollar-sign text-green-400 ml-1"></i>
                            </p>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex justify-between mt-4">
                            <!-- Edit and Delete Buttons (for admin) -->
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