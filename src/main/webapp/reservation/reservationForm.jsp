<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/includes/header.jsp" />

<h2>${reservation != null ? "Edit Reservation" : "Create New Reservation"}</h2>

<!-- Display Error Message -->
<c:if test="${not empty errorMessage}">
    <div style="color: red;">${errorMessage}</div>
</c:if>

<form action="${reservation != null ? 'ReservationServlet?action=update' : 'ReservationServlet?action=insert'}" method="post">
    <!-- Hidden Fields for Admin (Edit) -->
    <c:if test="${reservation != null}">
        <input type="hidden" name="reservationId" value="${reservation.reservationId}" />
    </c:if>

    <!-- Hidden Field for User (Create) -->
    <c:if test="${tour != null}">
        <input type="hidden" name="tourId" value="${tour.tourId}" />
    </c:if>

    <!-- User Selection (Admin Only) -->
    <c:if test="${users != null && sessionScope.role == 'admin'}">
        <label for="userId">User:</label>
        <select name="userId" id="userId" required>
            <option value="">-- Select User --</option>
            <c:forEach var="user" items="${users}">
                <option value="${user.userId}" <c:if test="${reservation != null && user.userId == reservation.userId}">selected</c:if>>
                    ${user.name} (${user.email})
                </option>
            </c:forEach>
        </select>
    </c:if>

    <!-- Tour Selection (Admin Only) -->
    <c:if test="${tours != null}">
        <label for="tourId">Tour:</label>
        <select name="tourId" id="tourId" required>
            <option value="">-- Select Tour --</option>
            <c:forEach var="tourItem" items="${tours}">
                <option value="${tourItem.tourId}" <c:if test="${reservation != null && tourItem.tourId == reservation.tourId}">selected</c:if>>
                    ${tourItem.title}
                </option>
            </c:forEach>
        </select>
    </c:if>

    <!-- Tour Information (User Only) -->
    <c:if test="${tour != null}">
        <h3>Tour: ${tour.title}</h3>
    </c:if>

    <!-- Reservation Date -->
    <label for="reservationDate">Reservation Date:</label>
    <c:if test="${reservation != null && reservation.reservationDate != null}">
        <fmt:formatDate var="formattedDate" value="${reservation.reservationDate}" pattern="yyyy-MM-dd" />
    </c:if>
    <input type="date" id="reservationDate" name="reservationDate"
           value="${reservation != null ? formattedDate : ''}" required />

    <!-- Number of People -->
    <label for="numberOfPeople">Number of People:</label>
    <input type="number" id="numberOfPeople" name="numberOfPeople" min="1"
           value="${reservation != null ? reservation.numberOfPeople : ''}" required />

    <!-- Status (Admin Only) -->
    <c:if test="${sessionScope.role == 'admin'}">
        <c:if test="${reservation != null && users != null}">
            <label for="status">Status:</label>
            <select name="status" id="status" required>
                <option value="">-- Select Status --</option>
                <option value="Confirmed" <c:if test="${reservation.status == 'Confirmed'}">selected</c:if>>Confirmed</option>
                <option value="Pending" <c:if test="${reservation.status == 'Pending'}">selected</c:if>>Pending</option>
                <option value="Cancelled" <c:if test="${reservation.status == 'Cancelled'}">selected</c:if>>Cancelled</option>
            </select>
        </c:if>
    </c:if>

    <!-- Submit Button -->
    <button type="submit">${reservation != null ? "Update Reservation" : "Create Reservation"}</button>
</form>

<jsp:include page="/includes/footer.jsp" />
