<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<div class="flex items-center justify-center p-5">
    <div class="w-full max-w-lg bg-white shadow-md rounded-lg p-8">
        <!-- Page Header -->
        <h2 class="text-3xl font-semibold text-gray-800 mb-6 text-center">Edit User</h2>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="flex items-center gap-3 bg-red-100 border border-red-300 text-red-700 px-4 py-3 rounded-md mb-6">
                <i class="fas fa-exclamation-circle text-red-600"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Edit User Form -->
        <form action="UserServlet" method="post" class="space-y-6">
            <!-- Hidden Inputs -->
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="userId" value="${user.userId}">

            <!-- Name Field -->
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                <div class="relative">
                    <input
                        type="text"
                        id="name"
                        name="name"
                        value="${user.name}"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                </div>
            </div>

            <!-- Email Field -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <div class="relative">
                    <input
                        type="email"
                        id="email"
                        name="email"
                        value="${user.email}"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                </div>
            </div>

            <!-- Phone Number Field -->
            <div>
                <label for="phone_number" class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                <div class="relative">
                    <input
                        type="text"
                        id="phone_number"
                        name="phone_number"
                        value="${user.phoneNumber}"
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                </div>
            </div>

            <!-- Submit Button -->
            <div class="mt-4">
                <button
                    type="submit"
                    class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition duration-300"
                >
                    Update User
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
