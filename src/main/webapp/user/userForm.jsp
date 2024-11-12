<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<jsp:include page="/includes/header.jsp" />

<h2>Edit User</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<form action="UserManagementServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="userId" value="${user.userId}">

    <label>Name:</label><br>
    <input type="text" name="name" value="${user.name}" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" value="${user.email}" required><br><br>

    <label>Phone Number:</label><br>
    <input type="text" name="phone_number" value="${user.phoneNumber}"><br><br>

    <label>Role:</label><br>
    <select name="role">
        <option value="user" <c:if test="${user.role == 'user'}">selected</c:if>>User</option>
        <option value="admin" <c:if test="${user.role == 'admin'}">selected</c:if>>Admin</option>
    </select><br><br>

    <input type="submit" value="Update User">
</form>

<jsp:include page="/includes/footer.jsp" />
