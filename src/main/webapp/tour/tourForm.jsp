<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>${tour != null ? "Edit Tour" : "Create Tour"}</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<form action="TourServlet" method="post">
    <input type="hidden" name="action" value="${tour != null ? 'update' : 'insert'}" />
    <c:if test="${tour != null}">
        <input type="hidden" name="id" value="${tour.tourId}" />
    </c:if>

    <label>Title:</label><br>
    <input type="text" name="title" value="${tour.title}" required><br><br>

    <label>Description:</label><br>
    <textarea name="description" required>${tour.description}</textarea><br><br>

    <label>Location:</label><br>
    <input type="text" name="location" value="${tour.location}" required><br><br>

    <label>Date:</label><br>
    <input type="date" name="date" value="${tour.date}" required><br><br>

    <label>Price:</label><br>
    <input type="number" step="0.01" name="price" value="${tour.price}" required><br><br>

    <input type="submit" value="${tour != null ? 'Update' : 'Create'} Tour">
</form>

<jsp:include page="/includes/footer.jsp" />
