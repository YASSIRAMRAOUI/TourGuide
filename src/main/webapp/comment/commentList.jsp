<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>Manage Comments</h2>

<table border="1">
    <tr>
        <th>Comment ID</th>
        <th>User ID</th>
        <th>Tour ID</th>
        <th>Content</th>
        <th>Comment Date</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="comment" items="${comments}">
        <tr>
            <td>${comment.commentId}</td>
            <td>${comment.userId}</td>
            <td>${comment.tourId}</td>
            <td>${comment.content}</td>
            <td>${comment.commentDate}</td>
            <td>
                <a href="CommentManagementServlet?action=delete&id=${comment.commentId}" onclick="return confirm('Are you sure you want to delete this comment?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/includes/footer.jsp" />
