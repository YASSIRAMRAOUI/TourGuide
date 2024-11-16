<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="dark:bg-background-dark bg-background-light text-text-light dark:text-text-dark font-sans">
<head>
    <title>TourGuide Management System</title>
    <link href="../css/tailwind.css" rel="stylesheet">
</head>
<body class="transition-colors duration-300">
    <nav class="flex justify-between items-center p-4 bg-primary-light dark:bg-primary-dark">
        <div class="flex space-x-4">
            <a href="<c:url value='/HomeServlet' />" class="hover:text-primary-dark">Home</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user_id}">
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="hover:text-primary-dark">Tours</a>
                        <a href="<c:url value='/UserServlet' />" class="hover:text-primary-dark">Users</a>
                        <a href="<c:url value='/ReservationServlet?action=listAll' />" class="hover:text-primary-dark">Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=listAll' />" class="hover:text-primary-dark">Reviews</a>
                        <a href="<c:url value='/ActivityServlet' />" class="hover:text-primary-dark">Activities</a>
                        <a href="<c:url value='/LogoutServlet' />" class="hover:text-primary-dark">Logout</a>
                    </c:if>
                    <c:if test="${sessionScope.role == 'user'}">
                        <a href="<c:url value='/TourServlet?action=list' />" class="hover:text-primary-dark">Tours</a>
                        <a href="<c:url value='/ReservationServlet?action=list' />" class="hover:text-primary-dark">My Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=list' />" class="hover:text-primary-dark">My Reviews</a>
                        <a href="<c:url value='/LogoutServlet' />" class="hover:text-primary-dark">Logout</a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/auth/login.jsp' />" class="hover:text-primary-dark">Login</a>
                    <a href="<c:url value='/auth/register.jsp' />" class="hover:text-primary-dark">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
    <hr class="border-t border-primary-dark dark:border-text-dark mt-2">

