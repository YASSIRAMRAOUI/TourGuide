<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="dark:bg-background-dark bg-background-light text-text-light dark:text-text-dark font-sans">
<head>
    <title>${sessionScope.role == 'admin' ? "All Reviews" : "My Reviews"}</title>
    <link href="../css/tailwind.css" rel="stylesheet">
</head>
<body class="transition-colors duration-300">
    <jsp:include page="/includes/header.jsp" />

    <h2 class="text-2xl font-bold my-4">${sessionScope.role == 'admin' ? "All Reviews" : "My Reviews"}</h2>

    <c:if test="${empty reviews}">
        <p>No reviews found.</p>
    </c:if>

    <c:if test="${not empty reviews}">
        <table class="min-w-full bg-white dark:bg-gray-800">
            <thead>
                <tr>
                    <th class="py-2 px-4 border-b">Tour Title</th>
                    <c:if test="${sessionScope.role == 'admin'}">
                        <th class="py-2 px-4 border-b">User Name</th>
                        <th class="py-2 px-4 border-b">User Email</th>
                    </c:if>
                    <th class="py-2 px-4 border-b">Comment</th>
                    <th class="py-2 px-4 border-b">Rating</th>
                    <th class="py-2 px-4 border-b">Date</th>
                    <c:if test="${sessionScope.role == 'admin'}">
                        <th class="py-2 px-4 border-b">Actions</th>
                    </c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${reviews}">
                    <tr>
                        <td class="py-2 px-4 border-b">${review.tourTitle}</td>
                        <c:if test="${sessionScope.role == 'admin'}">
                            <td class="py-2 px-4 border-b">${review.userName}</td>
                            <td class="py-2 px-4 border-b">${review.userEmail}</td>
                        </c:if>
                        <td class="py-2 px-4 border-b">${review.comment}</td>
                        <td class="py-2 px-4 border-b">${review.rating}</td>
                        <td class="py-2 px-4 border-b">${review.reviewDate}</td>
                        <c:if test="${sessionScope.role == 'user'}">
                            <td class="py-2 px-4 border-b">
                                <a href="<c:url value='/ReviewServlet?action=edit&id=${review.reviewId}' />" class="text-blue-500 hover:underline">Edit</a> |
                            </td>
                        </c:if>
                        <td class="py-2 px-4 border-b">
                            <a href="<c:url value='/ReviewServlet?action=delete&id=${review.reviewId}' />" class="text-red-500 hover:underline">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
