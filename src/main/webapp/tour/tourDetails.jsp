<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/includes/header.jsp" />

<h2>${tour.title}</h2>

<p><strong>Description:</strong> ${tour.description}</p>
<p><strong>Location:</strong> ${tour.location}</p>
<p><strong>Date:</strong> ${tour.date}</p>
<p><strong>Price:</strong> $${tour.price}</p>

<c:if test="${sessionScope.role == 'user'}">
    <a href="ReservationServlet?action=new&tourId=${tour.tourId}">Make a Reservation</a><br>
    <a href="ReviewServlet?tourId=${tour.tourId}">Write a Review</a>
</c:if>

<h3>Reviews:</h3>
<c:if test="${empty reviews}">
    <p>No reviews yet.</p>
</c:if>
<c:if test="${not empty reviews}">
    <table border="1">
        <tr>
            <th>User</th>
            <th>Rating</th>
            <th>Comment</th>
            <th>Date</th>
        </tr>
        <c:forEach var="review" items="${reviews}">
            <tr>
                <td>${review.userName}</td>
                <td>${review.rating}</td>
                <td>${review.comment}</td>
                <td>${review.reviewDate}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>


<jsp:include page="/includes/footer.jsp" />
