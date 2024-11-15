<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<h2>Edit Reservation</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<form action="ReservationManagementServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="reservationId" value="${reservation.reservationId}">

    <label>User ID:</label><br>
    <input type="number" name="userId" value="${reservation.userId}" required><br><br>

    <label>Tour ID:</label><br>
    <input type="number" name="tourId" value="${reservation.tourId}" required><br><br>

    <label>Status:</label><br>
    <select name="status">
        <option value="Pending" <c:if test="${reservation.status == 'Pending'}">selected</c:if>>Pending</option>
        <option value="Confirmed" <c:if test="${reservation.status == 'Confirmed'}">selected</c:if>>Confirmed</option>
        <option value="Cancelled" <c:if test="${reservation.status == 'Cancelled'}">selected</c:if>>Cancelled</option>
    </select><br><br>

    <input type="submit" value="Update Reservation">
</form>

<jsp:include page="/includes/footer.jsp" />
