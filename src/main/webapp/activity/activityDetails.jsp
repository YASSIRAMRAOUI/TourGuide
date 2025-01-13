<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<!-- Full-Width Activity Image -->
<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <c:if test="${activity.imagePath != null && !activity.imagePath.isEmpty()}">
        <img src="${pageContext.request.contextPath}/${activity.imagePath}" alt="${activity.name}"
             class="h-full w-full object-fill">
    </c:if>
    <c:if test="${activity.imagePath == null || activity.imagePath.isEmpty()}">
        <img src="${pageContext.request.contextPath}/assets/defaultBg.png" alt="Default Image"
             class="h-full w-full object-fill">
    </c:if>
</div>

<div class="container mx-auto p-6">
    <!-- Activity Info -->
    <div>
        <h1 class="text-3xl font-bold text-gray-800">${activity.name}</h1>
        <p class="text-gray-600 mt-4">${activity.description}</p>

        <!-- Associated Tours Section -->
        <div class="mt-8">
            <h2 class="text-xl font-semibold text-gray-700 flex items-center mb-4">
                <i class="fas fa-route mr-2"></i> Associated Tours
            </h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="tour" items="${activity.associatedTours}">
                    <!-- Tour Card -->
                    <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300">
                        <!-- Tour Image -->
                        <c:if test="${tour.imagePath != null && !tour.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/${tour.imagePath}"
                                 alt="${tour.title}"
                                 class="h-48 w-full object-cover">
                        </c:if>
                        <c:if test="${tour.imagePath == null || tour.imagePath.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/assets/defualtBg.png"
                                 alt="Default Tour Image"
                                 class="h-48 w-full object-cover">
                        </c:if>

                        <!-- Tour Title -->
                        <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 px-4 py-2">
                            <h3 class="text-lg font-semibold text-gray-300 mb-2">
                                <a href="TourServlet?action=view&id=${tour.tourId}" class="hover:text-gray-400">
                                    ${tour.title}
                                </a>
                            </h3>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>


<jsp:include page="/includes/footer.jsp" />