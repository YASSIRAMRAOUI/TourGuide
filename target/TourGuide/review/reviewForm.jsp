<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<c:choose>
    <c:when test="${not empty review}">
        <h2>Edit Review for ${review.tourTitle}</h2>
    </c:when>
    <c:otherwise>
        <h2>Write a Review for ${tour.title}</h2>
    </c:otherwise>
</c:choose>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<c:choose>
    <c:when test="${not empty review}">
        <form action="<c:url value='/ReviewServlet' />" method="post">
            <input type="hidden" name="action" value="${not empty review ? 'update' : 'insert'}">
            <input type="hidden" name="reviewId" value="${review.reviewId}">
            <input type="hidden" name="tourId" value="${review.tourId}">
            <input type="hidden" name="tourTitle" value="${review.tourTitle}">
            
            <label>Rating:</label><br>
            <select name="rating" required>
                <option value="">Select a rating</option>
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}" <c:if test="${review.rating == i}">selected</c:if>>${i}</option>
                </c:forEach>
            </select><br><br>
        
            <label>Comment:</label><br>
            <textarea name="comment" required>${review.comment}</textarea><br><br>
        
            <input type="submit" value="Update Review">
        </form>
    </c:when>
    <c:otherwise>
        <form action="<c:url value='/ReviewServlet?action=insert' />" method="post">
            <input type="hidden" name="tourId" value="${tour.tourId}">
            <input type="hidden" name="tourTitle" value="${tour.title}">
            
            <label>Rating:</label><br>
            <select name="rating" required>
                <option value="">Select a rating</option>
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}">${i}</option>
                </c:forEach>
            </select><br><br>
        
            <label>Comment:</label><br>
            <textarea name="comment" required></textarea><br><br>
        
            <input type="submit" value="Submit Review">
        </form>
    </c:otherwise>
</c:choose>

<jsp:include page="/includes/footer.jsp" />
