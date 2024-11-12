<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>TourGuide Management System</title>
    <style>
        /* Basic styling for navigation menu */
        nav a {
            margin-right: 15px;
        }
    </style>
</head>
<body>
<nav>
    <a href="<c:url value='/TourServlet?action=list' />">Home</a>
    <c:choose>
        <c:when test="${not empty sessionScope.user_id}">
            <c:if test="${sessionScope.role == 'admin'}">
                <a href="<c:url value='/TourServlet?action=list' />">Manage Tours</a>
                <a href="<c:url value='/UserManagementServlet' />">Manage Users</a>
                <a href="<c:url value='/ReservationManagementServlet' />">Manage Reservations</a>
                <a href="<c:url value='/ActivityManagementServlet' />">Manage Activities</a>
                <a href="<c:url value='/CommentManagementServlet' />">Manage Comments</a>
                <a href="<c:url value='/LogoutServlet' />">Logout</a>
            </c:if>
            <c:if test="${sessionScope.role == 'user'}">
                <a href="<c:url value='/TourServlet?action=list' />">View Tours</a>
                <a href="<c:url value='/ReservationServlet?action=list' />">My Reservations</a>
                <a href="<c:url value='/LogoutServlet' />">Logout</a>
            </c:if>
        </c:when>
        <c:otherwise>
            <a href="<c:url value='/auth/login.jsp' />">Login</a>
            <a href="<c:url value='/auth/register.jsp' />">Register</a>
        </c:otherwise>
    </c:choose>
</nav>
<hr>
