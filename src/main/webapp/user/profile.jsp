<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<div class="container mx-auto max-w-2xl bg-white p-8 my-20 mb-8 rounded-xl shadow-lg">
    <!-- Display success or error messages -->
    <c:if test="${not empty successMessage}">
        <div class="flex items-center gap-3 rounded-md bg-green-50 p-4 text-sm text-green-700 border border-green-200">
            <i class="fas fa-check-circle text-green-600"></i>
            ${successMessage}
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="mb-6 flex items-center gap-3 rounded-md bg-red-50 p-4 text-sm text-red-700 border border-red-200">
            <i class="fas fa-exclamation-circle text-red-600"></i>
            ${errorMessage}
        </div>
    </c:if>

    <!-- Display current profile image -->
    <div class="flex flex-col items-center mb-10">
        <c:choose>
            <c:when test="${not empty user.imagePath}">
                <img class="w-48 h-48 rounded-full object-cover shadow-md" src="${pageContext.request.contextPath}/${user.imagePath}" alt="Profile Image">
            </c:when>
            <c:otherwise>
                <img class="w-48 h-48 rounded-full object-cover shadow-md" src="${pageContext.request.contextPath}/assets/default.png" alt="Default Profile Image">
            </c:otherwise>
        </c:choose>
        <p class="text-gray-500 mt-3 text-sm">Current Profile Image</p>
    </div>

    <!-- Profile Form -->
    <form action="<c:url value='/ProfileServlet' />" method="post" enctype="multipart/form-data" class="space-y-6">
        <input type="hidden" name="action" value="updateProfile">

        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
            <!-- Name -->
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                <div class="relative mt-1 border border-gray-300 rounded-md shadow-sm focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500">
                    <i class="fas fa-user absolute inset-y-0 left-3 flex items-center text-gray-400"></i>
                    <input
                        type="text"
                        id="name"
                        name="name"
                        value="${user.name}"
                        required
                        class="w-full pl-10 pr-4 py-2 rounded-md border-none focus:ring-0 focus:outline-none"
                    >
                </div>
            </div>

            <!-- Email -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <div class="relative mt-1 border border-gray-300 rounded-md shadow-sm focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500">
                    <i class="fas fa-envelope absolute inset-y-0 left-3 flex items-center text-gray-400"></i>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        value="${user.email}"
                        required
                        class="w-full pl-10 pr-4 py-2 rounded-md border-none focus:ring-0 focus:outline-none"
                    >
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
            <!-- Password -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <div class="relative mt-1 border border-gray-300 rounded-md shadow-sm focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500">
                    <i class="fas fa-lock absolute inset-y-0 left-2 flex items-center text-gray-400"></i>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Leave blank to keep current password"
                        class="w-full pl-7 py-2 rounded-md border-none focus:ring-0 focus:outline-none text-sm"
                    >
                    <span class="absolute inset-y-0 right-1 flex items-center text-gray-400 cursor-pointer hover:text-gray-600" onclick="togglePassword()">
                        <i id="togglePasswordIcon" class="fas fa-eye-slash"></i>
                    </span>
                </div>
            </div>

            <!-- Phone Number -->
            <div>
                <label for="phone_number" class="block text-sm font-medium text-gray-700">Phone Number</label>
                <div class="relative mt-1 border border-gray-300 rounded-md shadow-sm focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500">
                    <i class="fas fa-phone absolute inset-y-0 left-3 flex items-center text-gray-400"></i>
                    <input
                        type="text"
                        id="phone_number"
                        name="phone_number"
                        value="${user.phoneNumber}"
                        class="w-full pl-10 pr-4 py-2 rounded-md border-none focus:ring-0 focus:outline-none"
                    >
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 items-center">
            <!-- Profile Image -->
            <div>
                <label for="profile_image" class="block text-sm font-medium text-gray-700">Update Profile Image</label>
                <input
                    type="file"
                    id="profile_image"
                    name="profile_image"
                    accept="image/*"
                    class="mt-2 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100"
                >
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end items-center space-x-4">
                <button
                    type="submit"
                    class="py-2 px-6 bg-indigo-600 text-white font-medium text-sm rounded-md shadow-md hover:bg-indigo-700 focus:ring-2 focus:ring-indigo-400 focus:ring-offset-2"
                >
                    Update Profile
                </button>

                <a href="<c:url value='/LogoutServlet' />"
                    class="py-2 px-6 bg-gray-100 text-gray-700 font-medium text-sm rounded-md shadow-md hover:bg-red-100 hover:text-red-600 focus:ring-2 focus:ring-red-400 focus:ring-offset-2">
                    <i class="fas fa-sign-out-alt mr-2"></i>
                    Logout
                </a>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/includes/footer.jsp" />


<script>
    function togglePassword() {
        const passwordInput = document.getElementById("password");
        const toggleIcon = document.getElementById("togglePasswordIcon");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleIcon.classList.replace("fa-eye-slash", "fa-eye");
        } else {
            passwordInput.type = "password";
            toggleIcon.classList.replace("fa-eye", "fa-eye-slash");
        }
    }
</script>