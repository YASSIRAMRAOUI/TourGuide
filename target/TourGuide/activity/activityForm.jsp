<!-- activityForm.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<h2>${activity != null ? "Edit Activity" : "Create New Activity"}</h2>

<form action="${activity != null ? 'ActivityServlet?action=update' : 'ActivityServlet?action=insert'}" method="post">
    <c:if test="${activity != null}">
        <input type="hidden" name="activityId" value="${activity.activityId}" />
    </c:if>

    <label for="name">Activity Name:</label>
    <input type="text" id="name" name="name" value="${activity != null ? activity.name : ''}" required />

    <label for="description">Description:</label>
    <textarea id="description" name="description" required>${activity != null ? activity.description : ''}</textarea>

    <fieldset>
        <legend>Associated Tours:</legend>
        <c:forEach var="tour" items="${allTours}">
            <label>
                <input type="checkbox" name="tourIds" value="${tour.tourId}"
                       <c:if test="${activity != null && activity.associatedTours.contains(tour)}">checked</c:if> />
                ${tour.title}
            </label><br />
        </c:forEach>
    </fieldset>

    <button type="submit">${activity != null ? "Update Activity" : "Create Activity"}</button>
</form>

<jsp:include page="/includes/footer.jsp" />
