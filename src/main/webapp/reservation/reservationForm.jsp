<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/includes/header.jsp" />

<div class="flex items-center justify-center p-5">
    <div class="w-full max-w-lg bg-white shadow-md rounded-lg p-8">
        <!-- Page Header -->
        <h2 class="text-3xl font-semibold text-gray-800 mb-6 text-center">
            ${reservation != null ? "Edit Reservation" : "Create New Reservation"}
        </h2>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="flex items-center gap-3 bg-red-100 border border-red-300 text-red-700 px-4 py-3 rounded-md mb-6">
                <i class="fas fa-exclamation-circle text-red-600"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Reservation Form -->
        <form action="${reservation != null ? 'ReservationServlet?action=update' : 'ReservationServlet?action=insert'}" method="post" class="space-y-6">
            <!-- Hidden Fields -->
            <c:if test="${reservation != null}">
                <input type="hidden" name="reservationId" value="${reservation.reservationId}" />
            </c:if>
            <c:if test="${tour != null}">
                <input type="hidden" name="tourId" value="${tour.tourId}" />
            </c:if>

            <!-- User Selection (Admin Only) -->
            <c:if test="${users != null && sessionScope.role == 'admin'}">
                <div>
                    <label for="userId" class="block text-sm font-medium text-gray-700 mb-1">User</label>
                    <select
                        name="userId"
                        id="userId"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                        <option value="">-- Select User --</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.userId}" <c:if test="${reservation != null && user.userId == reservation.userId}">selected</c:if>>
                                ${user.name} (${user.email})
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>

            <!-- Tour Selection (Admin Only) -->
            <c:if test="${tours != null}">
                <div>
                    <label for="tourId" class="block text-sm font-medium text-gray-700 mb-1">Tour</label>
                    <select
                        name="tourId"
                        id="tourId"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                        <option value="">-- Select Tour --</option>
                        <c:forEach var="tourItem" items="${tours}">
                            <option value="${tourItem.tourId}" <c:if test="${reservation != null && tourItem.tourId == reservation.tourId}">selected</c:if>>
                                ${tourItem.title}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>

            <!-- Tour Information (User Only) -->
            <c:if test="${tour != null}">
                <div>
                    <h3 class="text-lg font-medium text-gray-700">Tour: ${tour.title}</h3>
                </div>
            </c:if>

            <!-- Reservation Date -->
            <div>
                <label for="reservationDate" class="block text-sm font-medium text-gray-700 mb-1">Reservation Date</label>
                <c:if test="${reservation != null && reservation.reservationDate != null}">
                    <fmt:formatDate var="formattedDate" value="${reservation.reservationDate}" pattern="yyyy-MM-dd" />
                </c:if>
                <input
                    type="date"
                    id="reservationDate"
                    name="reservationDate"
                    value="${reservation != null ? formattedDate : ''}"
                    required
                    class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                >
            </div>

            <!-- Number of People -->
            <div>
                <label for="numberOfPeople" class="block text-sm font-medium text-gray-700 mb-1">Number of People</label>
                <input
                    type="number"
                    id="numberOfPeople"
                    name="numberOfPeople"
                    min="1"
                    value="${reservation != null ? reservation.numberOfPeople : ''}"
                    required
                    class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                >
            </div>

            <!-- Status (Admin Only) -->
            <c:if test="${sessionScope.role == 'admin'}">
                <div>
                    <label for="status" class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                    <select
                        name="status"
                        id="status"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                        <option value="">-- Select Status --</option>
                        <option value="Confirmed" <c:if test="${reservation.status == 'Confirmed'}">selected</c:if>>Confirmed</option>
                        <option value="Pending" <c:if test="${reservation.status == 'Pending'}">selected</c:if>>Pending</option>
                        <option value="Cancelled" <c:if test="${reservation.status == 'Cancelled'}">selected</c:if>>Cancelled</option>
                    </select>
                </div>
            </c:if>

            <!-- Submit Button -->
            <div>
                <button
                    type="submit"
                    class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition duration-300"
                >
                    ${reservation != null ? "Update Reservation" : "Create Reservation"}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
