<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container mx-auto p-10">
    <!-- Page Header -->
    <h2 class="text-3xl font-extrabold text-gray-800 mb-6 border-b-2 border-gray-300 pb-2">
        Manage Users
    </h2>

    <!-- Error Message -->
    <c:if test="${not empty errorMessage}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4 flex items-center space-x-2">
            <i class="fas fa-exclamation-circle text-red-500"></i>
            <span>${errorMessage}</span>
        </div>
    </c:if>

    <!-- Users List -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <c:forEach var="user" items="${users}">
            <div class="bg-white shadow-md rounded-lg overflow-hidden">
                <!-- User Image and Info -->
                <div class="p-4 flex items-center">
                    <c:choose>
                        <c:when test="${not empty user.imagePath}">
                            <img src="${pageContext.request.contextPath}/${user.imagePath}" 
                                 alt="${user.name}" 
                                 class="h-16 w-16 rounded-full mr-4">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/default.png" 
                                 alt="Default avatar" 
                                 class="h-16 w-16 rounded-full mr-4">
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <h3 class="text-lg font-semibold text-gray-900">${user.name}</h3>
                        <p class="text-sm text-gray-600">
                            <i class="fas fa-envelope text-gray-400 mr-1"></i>${user.email}
                        </p>
                        <p class="text-sm text-gray-600">
                            <i class="fas fa-phone text-gray-400 mr-1"></i>${user.phoneNumber}
                        </p>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="bg-gray-100 p-4 flex justify-between">
                    <a href="UserServlet?action=edit&id=${user.userId}" 
                       class="text-blue-500 hover:text-blue-700 flex items-center space-x-1">
                        <i class="fas fa-edit"></i>
                        <span>Edit</span>
                    </a>
                    <button onclick="openDeleteUser(${user.userId})" 
                            class="text-red-500 hover:text-red-700 flex items-center space-x-1">
                        <i class="fas fa-trash-alt"></i>
                        <span>Delete</span>
                    </button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg w-1/3">
        <div class="p-6">
            <h2 class="text-xl font-semibold text-gray-700 flex items-center space-x-2">
                <i class="fas fa-exclamation-triangle text-yellow-500"></i>
                <span>Confirm Delete</span>
            </h2>
            <p class="text-gray-600 mt-2">Are you sure you want to delete this user? This action cannot be undone.</p>
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
