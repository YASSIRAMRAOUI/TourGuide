<jsp:include page="/includes/header.jsp" />

<h2>My Reservations</h2>

<c:if test="${empty reservations}">
    <p>You have no reservations.</p>
</c:if>

<c:if test="${not empty reservations}">
    <table border="1">
        <tr>
            <th>Tour Title</th>
            <th>Reservation Date</th>
            <th>Number of People</th>
            <th>Status</th>
        </tr>
        <c:forEach var="reservation" items="${reservations}">
            <tr>
                <td>${reservation.tourTitle}</td>
                <td>${reservation.reservationDate}</td>
                <td>${reservation.numberOfPeople}</td>
                <td>${reservation.status}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<jsp:include page="/includes/footer.jsp" />
