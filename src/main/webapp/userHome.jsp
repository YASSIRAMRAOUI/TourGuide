<jsp:include page="/includes/header.jsp" />

<h2>Welcome, ${sessionScope.name}</h2>

<p>This is your dashboard.</p>
<ul>
    <li><a href="TourServlet?action=list">View Tours</a></li>
    <li><a href="ReservationServlet?action=list">My Reservations</a></li>
    <!-- Add more user functionalities as needed -->
</ul>

<jsp:include page="/includes/footer.jsp" />
