<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>${activity != null ? "Edit Activity" : "Add New Activity"}</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<form action="ActivityServlet" method="post">
    <input type="hidden" name="action" value="${activity != null ? 'update' : 'insert'}">
    <c:if test="${activity != null}">
        <input type="hidden" name="activityId" value="${activity.activityId}">
    </c:if>

    <label>Name:</label><br>
    <input type="text" name="name" value="${activity.name}" required><br><br>

    <label>Description:</label><br>
    <textarea name="description" required>${activity.description}</textarea><br><br>

    <label>Tour:</label><br>
    <select name="tourId" required>
        <option value="">-- Select a Tour --</option>
        <c:forEach var="tour" items="${tours}">
            <option value="${tour.tourId}" <c:if test="${tour.tourId == activity.tourId}">selected</c:if>>${tour.title}</option>
        </c:forEach>
    </select><br><br>

    <input type="submit" value="${activity != null ? 'Update Activity' : 'Create Activity'}">
</form>

<jsp:include page="/includes/footer.jsp" />
