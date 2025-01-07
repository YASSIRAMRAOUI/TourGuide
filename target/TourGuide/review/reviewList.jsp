<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<div class="container mx-auto p-10">
    <div class="flex items-center justify-between mb-6 border-b-2 border-gray-300 pb-2">
        <h2 class="text-3xl font-extrabold text-gray-800">
            ${sessionScope.role == 'admin' ? "All Reviews" : "My Reviews"}
        </h2>

        <!-- Search Bar -->
        <form action="ReviewServlet" method="get" class="flex">
            <input type="hidden" name="action" value="list" />
            <input
                type="text"
                name="search"
                placeholder="Search reviews..."
                class="border border-gray-300 rounded-l-lg px-4 py-2"
                value="${searchQuery != null ? searchQuery : ''}">
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-r-lg">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <!-- No Reviews Message -->
    <c:if test="${empty reviews}">
        <div class="text-center text-gray-500">
            <i class="fas fa-info-circle text-xl"></i>
            <p>No reviews found.</p>
        </div>
    </c:if>

    <!-- Reviews Card Layout -->
    <c:if test="${not empty reviews}">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="review" items="${reviews}">
                <div class="bg-white shadow-md rounded-lg overflow-hidden">
                    <div class="p-4">
                        <c:if test="${sessionScope.role == 'admin'}">
                            <div class="flex items-center mb-4">
                                <c:choose>
                                    <c:when test="${not empty review.userImagePath}">
                                        <img src="${pageContext.request.contextPath}/${review.userImagePath}" 
                                            alt="${review.userName}"
                                            class="h-12 w-12 rounded-full mr-4">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/default.png"
                                            alt="Default avatar"
                                            class="h-12 w-12 rounded-full mr-4">
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-800">${review.userName}</h4>
                                    <p class="text-sm text-gray-500">
                                        <i class="fas fa-envelope text-gray-400 mr-1"></i>${review.userEmail}
                                    </p>
                                </div>
                            </div>
                        </c:if>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">
                            <i class="fas fa-map-marker-alt text-gray-500 mr-2"></i>${review.tourTitle}
                        </h3>
                        <p class="text-gray-600 mb-4">
                            <i class="fas fa-comment-alt text-gray-400 mr-2"></i>${review.comment}
                        </p>
                        <div class="flex items-center justify-between text-gray-600">
                            <span>
                                <!-- Loop to display filled stars -->
                                <c:forEach var="i" begin="1" end="${review.rating}">
                                    <i class="fas fa-star text-yellow-500"></i>
                                </c:forEach>
                                <!-- Loop to display empty stars -->
                                <c:forEach var="i" begin="1" end="${5 - review.rating}">
                                    <i class="far fa-star text-gray-300"></i>
                                </c:forEach>
                            </span>
                                                        <span>
                                <i class="fas fa-calendar-alt text-gray-400 mr-1"></i>${review.reviewDate}
                            </span>
                        </div>
                    </div>
                    <div class="bg-gray-100 p-4 flex justify-between">
                        <c:if test="${sessionScope.role == 'user'}">
                            <a href="ReviewServlet?action=edit&id=${review.reviewId}"
                               class="text-blue-500 hover:text-blue-700 font-medium flex items-center">
                                <i class="fas fa-edit mr-1"></i>Edit
                            </a>
                        </c:if>
                        <button onclick="openDeleteReview(${review.reviewId})"
                                class="text-red-500 hover:text-red-700 font-medium flex items-center">
                            <i class="fas fa-trash-alt mr-1"></i>Delete
                        </button>
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
            <h2 class="text-xl font-semibold text-gray-700">
                <i class="fas fa-exclamation-triangle text-yellow-500 mr-2"></i>Confirm Delete
            </h2>
            <p class="text-gray-600 mt-2">Are you sure you want to delete this review? This action cannot be undone.</p>
        </div>
        <div class="flex justify-end p-4 border-t border-gray-200">
            <button class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md mr-2" onclick="closeDeleteModal()">Cancel</button>
            <a id="deleteConfirmBtn" href="#" class="bg-red-500 text-white px-4 py-2 rounded-md flex items-center">
                Delete
            </a>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
