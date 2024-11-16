<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>${sessionScope.role == 'admin' ? "All Reservations" : "My Reservations"}</h2>

<c:if test="${empty reservations}">
    <p>No reservations found.</p>
</c:if>

<c:if test="${not empty reservations}">
    <table border="1">
        <tr>
            <th>Tour Title</th>
            <c:if test="${sessionScope.role == 'admin'}">
                <th>User Name</th>
                <th>User Email</th>
            </c:if>
            <th>Reservation Date</th>
            <th>Number of People</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="reservation" items="${reservations}">
            <tr>
                <td>${reservation.tourTitle}</td>
                <c:if test="${sessionScope.role == 'admin'}">
                    <td>${reservation.userName}</td>
                    <td>${reservation.userEmail}</td>
                </c:if>
                <td>${reservation.reservationDate}</td>
                <td>${reservation.numberOfPeople}</td>
                <td>${reservation.status}</td>
                <td>
                    <a href="ReservationServlet?action=edit&id=${reservation.reservationId}">Edit</a> |
                    <a href="ReservationServlet?action=delete&id=${reservation.reservationId}" onclick="return confirm('Are you sure you want to delete this reservation?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<jsp:include page="/includes/footer.jsp" />
