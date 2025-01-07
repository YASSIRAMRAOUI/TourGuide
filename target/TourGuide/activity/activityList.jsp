<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container mx-auto p-10">
    <!-- Page Header -->
    <div class="flex items-center justify-between mb-6 border-b-2 border-gray-300 pb-2">
        <h2 class="text-3xl font-extrabold text-gray-800">
            Manage Activities
        </h2>

        <!-- Add New Activity Button -->
        <a href="ActivityServlet?action=new"
           class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">
            Add New Activity
        </a>
    </div>

    <!-- No Activities Message -->
    <c:if test="${empty activities}">
        <p class="text-gray-500">No activities found.</p>
    </c:if>

    <!-- Activities Grid -->
    <c:if test="${not empty activities}">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="activity" items="${activities}">
                <!-- Activity Card -->
                <div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
                    <!-- Activity Image -->
                    <div class="h-60 bg-gray-200 flex items-center justify-center">
                        <c:if test="${activity.imagePath != null && !activity.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/${activity.imagePath}" alt="${activity.name}"
                                 class="h-full w-full object-cover">
                        </c:if>
                        <c:if test="${activity.imagePath == null || activity.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/assets/defaultBg.png" alt="Default Image"
                                 class="h-full w-full object-cover">
                        </c:if>
                    </div>

                    <!-- Activity Details -->
                    <div class="p-4">
                        <h3 class="text-xl font-semibold text-gray-800">
                            <a href="ActivityServlet?action=view&id=${activity.activityId}" class="hover:text-blue-600">
                                ${activity.name}
                            </a>
                        </h3>

                        <!-- Associated Tours -->
                        <div class="mt-4">
                            <h4 class="text-sm font-semibold text-gray-700">Tours:</h4>
                            <ul class="text-sm text-gray-600">
                                <c:forEach var="tour" items="${activity.associatedTours}">
                                    <li>• ${tour.title}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="p-4 flex justify-between border-t border-gray-200">
                        <a href="ActivityServlet?action=view&id=${activity.activityId}"
                           class="text-blue-500 hover:text-blue-700 text-sm font-medium">
                           <i class="fas fa-eye mr-1"></i>
                            View
                        </a>
                        <c:if test="${sessionScope.role == 'admin'}">
                            <div class="flex space-x-4">
                                <a href="ActivityServlet?action=edit&id=${activity.activityId}"
                                   class="text-green-500 hover:text-green-700 text-sm font-medium">
                                   <i class="fas fa-edit mr-1"></i>
                                    Edit
                                </a>
                                <button onclick="openDeleteActivity(${activity.activityId})"
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
            <p class="text-gray-600 mt-2">Are you sure you want to delete this activity? This action cannot be undone.</p>
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
