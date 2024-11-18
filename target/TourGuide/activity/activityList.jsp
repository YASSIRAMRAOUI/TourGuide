<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>Manage Activities</h2>

<a href="ActivityServlet?action=new">Add New Activity</a>

<table border="1">
    <tr>
        <th>Name</th>
        <th>Description</th>
        <th>Tour Name</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="activity" items="${activities}">
        <tr>
            <td>${activity.name}</td>
            <td>${activity.description}</td>
            <td>
                <c:forEach var="tour" items="${activity.associatedTours}">
                    ${tour.title}<br>
                </c:forEach>
            </td>
            <td>
                <a href="ActivityServlet?action=edit&id=${activity.activityId}">Edit</a> |
                <a href="ActivityServlet?action=delete&id=${activity.activityId}" onclick="return confirm('Are you sure you want to delete this activity?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/includes/footer.jsp" />
