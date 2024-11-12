<jsp:include page="/includes/header.jsp" />

<h2>Make a Reservation for ${tour.title}</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<form action="ReservationServlet" method="post">
    <input type="hidden" name="action" value="insert">
    <input type="hidden" name="tourId" value="${tour.tourId}">
    
    <label>Reservation Date:</label><br>
    <input type="date" name="reservationDate" required><br><br>

    <label>Number of People:</label><br>
    <input type="number" name="numberOfPeople" min="1" required><br><br>

    <input type="submit" value="Reserve">
</form>

<jsp:include page="/includes/footer.jsp" />
