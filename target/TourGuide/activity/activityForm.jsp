<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container py-10 px-20">
    <!-- Page Header -->
    <h2 class="text-3xl font-extrabold text-gray-800 mb-6 border-b-2 border-gray-300 pb-2">
        ${activity != null ? "Edit Activity" : "Create New Activity"}
    </h2>

    <!-- Activity Form -->
    <form action="${activity != null ? 'ActivityServlet?action=update' : 'ActivityServlet?action=insert'}"
          method="post"
          enctype="multipart/form-data"
          class="bg-white p-6 shadow-lg rounded-lg space-y-6">
        <c:if test="${activity != null}">
            <input type="hidden" name="activityId" value="${activity.activityId}" />
        </c:if>

        <!-- Image Upload -->
        <div class="mb-4">
            <label for="image" class="block text-gray-700 font-bold mb-2">Activity Image:</label>
            <input type="file" name="image" id="image" accept="image/*"
                   class="border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>

        <c:if test="${activity != null && activity.imagePath != null}">
            <div class="mb-4">
                <img src="${pageContext.request.contextPath}/${activity.imagePath}" alt="Activity Image" class="w-32 h-32">
            </div>
        </c:if>

        <!-- Activity Name -->
        <div>
            <label for="name" class="block text-sm font-medium text-gray-700">Activity Name:</label>
            <input type="text" id="name" name="name" value="${activity != null ? activity.name : ''}" required
                   class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500" />
        </div>

        <!-- Description with Quill.js -->
        <div>
            <label for="description" class="block text-sm font-medium text-gray-700">Description:</label>
            <div id="editor-container" style="height: 300px;" class="border border-gray-300 rounded-md"></div>
            <!-- Hidden Input to Submit Form Data -->
            <input type="hidden" name="description" id="description">
        </div>

        <!-- Associated Tours -->
        <fieldset class="border border-gray-300 p-4 rounded-md">
            <legend class="text-sm font-medium text-gray-700">Associated Tours:</legend>
            <div class="mt-2 space-y-2">
                <c:forEach var="tour" items="${allTours}">
                    <label class="flex items-center">
                        <input type="checkbox" name="tourIds" value="${tour.tourId}" 
                               class="h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500"
                               <c:if test="${activity != null && activity.associatedTours.contains(tour)}">checked</c:if> />
                        <span class="ml-2 text-gray-700">${tour.title}</span>
                    </label>
                </c:forEach>
            </div>
        </fieldset>

        <!-- Submit Button -->
        <div>
            <button type="submit"
                    class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition duration-300">
                ${activity != null ? "Update Activity" : "Create Activity"}
            </button>
        </div>
    </form>
</div>

<!-- Quill.js Scripts -->
<link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
<script>
    // Initialize Quill Editor
    var quill = new Quill('#editor-container', {
        theme: 'snow', // Snow theme for a clean design
        placeholder: 'Enter activity description here...',
        modules: {
            toolbar: [
                [{ 'header': [1, 2, false] }],
                ['bold', 'italic', 'underline'],
                [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                ['link', 'image']
            ]
        }
    });

    // Sync Quill content with hidden input field for form submission
    var form = document.querySelector('form');
    form.onsubmit = function() {
        document.querySelector('#description').value = quill.root.innerHTML;
    };

    // Pre-fill Quill with existing data (if editing)
    const existingDescription = `${activity != null ? activity.description : ''}`;
    if (existingDescription) {
        quill.root.innerHTML = existingDescription;
    }
</script>

<jsp:include page="/includes/footer.jsp" />
