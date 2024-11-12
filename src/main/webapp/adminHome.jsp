<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<jsp:include page="/includes/header.jsp" />

<h2>Welcome, ${sessionScope.name}</h2>

<p>This is the admin dashboard.</p>
<ul>
    <li><a href="<c:url value='/TourServlet?action=list' />">Manage Tours</a></li>
    <li><a href="<c:url value='/UserManagementServlet' />">Manage Users</a></li>
    <li><a href="<c:url value='/ReservationManagementServlet' />">Manage Reservations</a></li>
    <li><a href="<c:url value='/ActivityManagementServlet' />">Manage Activities</a></li>
    <li><a href="<c:url value='/CommentManagementServlet' />">Manage Comments</a></li>
</ul>

<jsp:include page="/includes/footer.jsp" />
