<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>TourGuide Management System</title>
</head>
<body>
    <nav>
        <div>
            <a href="<c:url value='/HomeServlet' />">
                <img src="<c:url value='/assets/logo.png' />" alt="TourGuide Logo">
            </a>
        </div>
        
        <div>
            <c:choose>
                <c:when test="${not empty sessionScope.user_id}">
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="<c:url value='/TourServlet?action=list' />">Tours</a>
                        <a href="<c:url value='/UserServlet' />">Users</a>
                        <a href="<c:url value='/ReservationServlet?action=listAll' />">Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=listAll' />">Reviews</a>
                        <a href="<c:url value='/ActivityServlet' />">Activities</a>
                        <a href="<c:url value='/LogoutServlet' />">Logout</a>
                    </c:if>
                    <c:if test="${sessionScope.role == 'user'}">
                        <a href="<c:url value='/TourServlet?action=list' />">Tours</a>
                        <a href="<c:url value='/ReservationServlet?action=list' />">Reservations</a>
                        <a href="<c:url value='/ReviewServlet?action=list' />">Reviews</a>
                        <a href="<c:url value='/LogoutServlet' />">Logout</a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/auth/login.jsp' />">Login</a>
                    <a href="<c:url value='/auth/register.jsp' />">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${not empty sessionScope.user_id}">
            <div>
                <a href="<c:url value='/ProfileServlet?action=viewProfile' />">
                    <img src="<c:url value='/${sessionScope.user_imagePath != null ? sessionScope.user_imagePath : "assets/default.png"}' />" alt="User Profile">
                </a>
            </div>
        </c:if>
    </nav>
    <hr>
</body>
</html>
