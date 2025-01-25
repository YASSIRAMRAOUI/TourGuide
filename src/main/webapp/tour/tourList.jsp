<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <img src="../assets/hero2.jpg" alt="Contct Us"
        class="h-full w-full object-fill">
</div>

<div class="container mx-auto p-5 px-20">
    <!-- Page Header -->
    <c:if test="${sessionScope.role == 'admin'}">
        <div class="flex items-center justify-between mb-6 border-b-2 border-gray-300 pb-2">

        <h2 class="text-3xl font-extrabold text-gray-800">
            Manage Tours
        </h2>

        <!-- Add New Tour Button -->
        <a href="TourServlet?action=new"
            class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">
            Add New Tour
        </a>
        </div>
    </c:if>

    <!-- No Tours Message -->
    <c:if test="${empty tours}">
        <p class="text-gray-500">No tours found.</p>
    </c:if>

    <!-- Tours Grid -->
    <c:if test="${not empty tours}">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="tour" items="${tours}">
                <!-- Tour Card -->
                <div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
                    <!-- Tour Image -->
                    <div class="h-60 bg-gray-200 flex items-center justify-center">
                        <c:if test="${tour.imagePath != null && !tour.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/${tour.imagePath}" alt="${tour.title}"
                                 class="h-full w-full object-cover">
                        </c:if>
                        <c:if test="${tour.imagePath == null || tour.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/assets/defaultTour.png" alt="Default Image"
                                 class="h-full w-full object-cover">
                        </c:if>
                    </div>

                    <!-- Tour Depart -->
                    <div class="p-4">
                        <!-- Title and Date -->
                        <div class="flex justify-between items-center mb-2">
                            <h3 class="text-xl font-semibold text-gray-800">
                                <a href="TourServlet?action=view&id=${tour.tourId}" class="hover:text-blue-600">
                                    ${tour.title}
                                </a>
                            </h3>
                            <p class="text-yellow-500 font-bold text-lg flex items-center">
                                ${tour.price} dh
                            </p>
                        </div>

                        <!-- Detaisl and Category -->
                        <div class="flex justify-between items-center mb-2">
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fas fa-tags mr-2"></i>
                                ${tour.category}
                            </p>
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fa-solid fa-plane-departure mr-2"></i>
                                ${tour.start}
                            </p>
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fa-solid fa-plane-arrival mr-2"></i>
                                ${tour.end}
                            </p>
                            <p class="text-gray-600 text-sm flex items-center">
                                <i class="fa-regular fa-clock text-green-500 mr-2"></i>
                                ${tour.date}
                            </p>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="p-4 flex justify-between border-t border-gray-200">
                        <a href="TourServlet?action=view&id=${tour.tourId}"
                           class="text-blue-500 hover:text-blue-700 text-sm font-medium">
                           <i class="fas fa-eye mr-1"></i>
                            View
                        </a>
                        <c:if test="${sessionScope.role == 'admin'}">
                            <div class="flex space-x-4">
                                <a href="TourServlet?action=edit&id=${tour.tourId}"
                                   class="text-green-500 hover:text-green-700 text-sm font-medium">
                                   <i class="fas fa-edit mr-1"></i>
                                    Edit
                                </a>
                                <button onclick="openDeleteTour(${tour.tourId})"
                                    class="text-red-500 hover:text-red-700 text-sm font-medium">
                                    <i class="fas fa-trash-alt mr-1"></i>
                                    Delete
                                </button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal"
     class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg w-1/3">
        <div class="p-6">
            <h2 class="text-xl font-semibold text-gray-700">Confirm Delete</h2>
            <p class="text-gray-600 mt-2">Are you sure you want to delete this tour? This action cannot be undone.</p>
        </div>
        <div class="flex justify-end p-4 border-t border-gray-200">
            <button class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md mr-2"
                    onclick="closeDeleteModal()">Cancel
            </button>
            <a id="deleteConfirmBtn" href="#" class="bg-red-500 text-white px-4 py-2 rounded-md">Delete</a>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
