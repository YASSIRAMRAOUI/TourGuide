<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<div>
    <h2>User Profile</h2>

    <!-- Display success or error messages -->
    <c:if test="${not empty successMessage}">
        <div>${successMessage}</div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div>${errorMessage}</div>
    </c:if>

    <form action="<c:url value='/ProfileServlet' />" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="updateProfile">
        
        <div>
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="${user.name}" required>
        </div>

        <div>
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${user.email}" required>
        </div>

        <div>
            <label for="password">Password</label>
            <div>
                <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">
                <span onclick="togglePassword()">
                    <i id="togglePasswordIcon"></i>
                </span>
            </div>
        </div>

        <div>
            <label for="phone_number">Phone Number</label>
            <input type="text" id="phone_number" name="phone_number" value="${user.phoneNumber}">
        </div>

        <div>
            <label for="profile_image">Profile Image</label>
            <input type="file" id="profile_image" name="profile_image" accept="image/*">
        </div>

        <!-- Display current profile image if exists -->
        <div>
            <label>Current Profile Image:</label>
            <c:choose>
                <c:when test="${not empty user.imagePath}">
                    <img src="data:image/jpeg;base64,${user.imagePath}" alt="Profile Image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/default.png" alt="Default Profile Image">
                </c:otherwise>
            </c:choose>
        </div>

        <button type="submit">
            Update Profile
        </button>
    </form>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    function togglePassword() {
        const passwordInput = document.getElementById("password");
        const toggleIcon = document.getElementById("togglePasswordIcon");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }
</script>
