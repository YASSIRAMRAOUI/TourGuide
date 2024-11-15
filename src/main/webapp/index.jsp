<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<h2>Welcome to TourGuide Management System</h2>

<!-- Display Tours -->
<h3>Available Tours</h3>
<c:if test="${not empty tours}">
    <ul>
        <c:forEach var="tour" items="${tours}">
            <li>
                <a href="TourServlet?action=view&id=${tour.tourId}">${tour.title}</a> - ${tour.description}
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty tours}">
    <p>No tours available at the moment.</p>
</c:if>

<!-- Display Activities -->
<h3>Activities</h3>
<c:if test="${not empty activities}">
    <ul>
        <c:forEach var="activity" items="${activities}">
            <li>
                <strong>${activity.name}</strong> - ${activity.description}
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty activities}">
    <p>No activities available at the moment.</p>
</c:if>

<!-- Display Recent Comments -->
<h3>Recent Comments</h3>
<c:if test="${not empty comments}">
    <ul>
        <c:forEach var="comment" items="${comments}">
            <li>
                <strong>${comment.userName}</strong> commented on <a href="TourServlet?action=view&id=${comment.tourId}">Tour ID ${comment.tourId}</a>
                <br />
                ${comment.content}
                <br />
                <em>${comment.commentDate}</em>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty comments}">
    <p>No comments available at the moment.</p>
</c:if>

<jsp:include page="/includes/footer.jsp" />
