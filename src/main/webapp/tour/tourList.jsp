<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>Available Tours</h2>

<c:if test="${empty tours}">
    <p>No tours available at the moment.</p>
</c:if>

<c:if test="${not empty tours}">
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Location</th>
            <th>Date</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="tour" items="${tours}">
            <tr>
                <td>${tour.title}</td>
                <td>${tour.location}</td>
                <td>${tour.date}</td>
                <td>${tour.price}</td>
                <td>
                    <a href="TourServlet?id=${tour.tourId}">View</a>
                    <c:if test="${sessionScope.role == 'admin' && sessionScope.user_id == tour.guideId}">
                        | <a href="TourServlet?action=edit&id=${tour.tourId}">Edit</a>
                        | <a href="TourServlet?action=delete&id=${tour.tourId}" onclick="return confirm('Are you sure you want to delete this tour?');">Delete</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<jsp:include page="/includes/footer.jsp" />
