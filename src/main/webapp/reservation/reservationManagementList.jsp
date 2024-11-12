<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>Manage Reservations</h2>

<table border="1">
    <tr>
        <th>Reservation ID</th>
        <th>User</th>
        <th>Tour</th>
        <th>Reservation Date</th>
        <th>Number of People</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="reservation" items="${reservations}">
        <tr>
            <td>${reservation.reservationId}</td>
            <td>${reservation.userName}</td>
            <td>${reservation.tourTitle}</td>
            <td>${reservation.reservationDate}</td>
            <td>${reservation.numberOfPeople}</td>
            <td>${reservation.status}</td>
            <td>
                <a href="ReservationManagementServlet?action=edit&id=${reservation.reservationId}">Edit</a> |
                <a href="ReservationManagementServlet?action=delete&id=${reservation.reservationId}" onclick="return confirm('Are you sure you want to delete this reservation?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/includes/footer.jsp" />
