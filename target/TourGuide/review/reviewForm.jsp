<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<div class="flex items-center justify-center p-10">
    <div class="w-full max-w-lg bg-white rounded-lg shadow-lg p-8">
        <!-- Page Header -->
        <c:choose>
            <c:when test="${not empty review}">
                <h2 class="text-3xl font-bold text-gray-800 mb-6 text-center">
                    Edit Review for ${review.tourTitle}
                </h2>
            </c:when>
            <c:otherwise>
                <h2 class="text-3xl font-bold text-gray-800 mb-6 text-center">
                    Write a Review for ${tour.title}
                </h2>
            </c:otherwise>
        </c:choose>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <p class="bg-red-100 text-red-700 border border-red-300 px-4 py-3 rounded mb-6">
                ${errorMessage}
            </p>
        </c:if>

        <!-- Form -->
        <c:choose>
            <c:when test="${not empty review}">
                <form action="<c:url value='/ReviewServlet' />" method="post" class="space-y-6">
                    <input type="hidden" name="action" value="${not empty review ? 'update' : 'insert'}">
                    <input type="hidden" name="reviewId" value="${review.reviewId}">
                    <input type="hidden" name="tourId" value="${review.tourId}">
                    <input type="hidden" name="tourTitle" value="${review.tourTitle}">

                    <!-- Rating Field -->
                    <div>
                        <label for="rating" class="block text-sm font-medium text-gray-700 mb-1">
                            Rating
                        </label>
                        <select 
                            id="rating" 
                            name="rating" 
                            required 
                            class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500">
                            <option value="">Select a rating</option>
                            <c:forEach var="i" begin="1" end="5">
                                <option value="${i}" <c:if test="${review.rating == i}">selected</c:if>>${i}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Comment Field -->
                    <div>
                        <label for="comment" class="block text-sm font-medium text-gray-700 mb-1">
                            Comment
                        </label>
                        <textarea 
                            id="comment" 
                            name="comment" 
                            required 
                            class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500">${review.comment}</textarea>
                    </div>

                    <!-- Submit Button -->
                    <button 
                        type="submit" 
                        class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition">
                        Update Review
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <form action="<c:url value='/ReviewServlet?action=insert' />" method="post" class="space-y-6">
                    <input type="hidden" name="tourId" value="${tour.tourId}">
                    <input type="hidden" name="tourTitle" value="${tour.title}">

                    <!-- Rating Field -->
                    <div>
                        <label for="rating" class="block text-sm font-medium text-gray-700 mb-1">
                            Rating
                        </label>
                        <select 
                            id="rating" 
                            name="rating" 
                            required 
                            class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500">
                            <option value="">Select a rating</option>
                            <c:forEach var="i" begin="1" end="5">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Comment Field -->
                    <div>
                        <label for="comment" class="block text-sm font-medium text-gray-700 mb-1">
                            Comment
                        </label>
                        <textarea 
                            id="comment" 
                            name="comment" 
                            required 
                            class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500"></textarea>
                    </div>

                    <!-- Submit Button -->
                    <button 
                        type="submit" 
                        class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition">
                        Submit Review
                    </button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
