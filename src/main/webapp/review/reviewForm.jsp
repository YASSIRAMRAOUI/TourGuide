<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/includes/header.jsp" />

<h2>Write a Review for ${tour.title}</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<form action="ReviewServlet" method="post">
    <input type="hidden" name="tourId" value="${tour.tourId}">
    
    <label>Rating:</label><br>
    <select name="rating" required>
        <option value="">Select a rating</option>
        <c:forEach var="i" begin="1" end="5">
            <option value="${i}">${i}</option>
        </c:forEach>
    </select><br><br>

    <label>Comment:</label><br>
    <textarea name="comment" required></textarea><br><br>

    <input type="submit" value="Submit Review">
</form>

<jsp:include page="/includes/footer.jsp" />
