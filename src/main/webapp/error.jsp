<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/includes/header.jsp" />

<h2>Error</h2>

<p>${errorMessage}</p>

<a href="TourServlet?action=list">Return to Home Page</a>

<jsp:include page="/includes/footer.jsp" />
