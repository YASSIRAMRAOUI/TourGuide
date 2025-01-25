<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<div class="container px-20 py-10">
    <!-- Page Header -->
    <h2 class="text-3xl font-extrabold text-gray-800 mb-6">
        ${tour != null ? "Edit Tour" : "Create New Tour"}
    </h2>

    <c:if test="${not empty errorMessage}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <strong>Error:</strong> ${errorMessage}
        </div>
    </c:if>

    <!-- Tour Form -->
    <form action="${tour != null ? 'TourServlet?action=update' : 'TourServlet?action=insert'}" method="post" enctype="multipart/form-data"
          class="bg-white p-6 px-20 shadow-lg rounded-lg space-y-6">
        <c:if test="${tour != null}">
            <input type="hidden" name="id" value="${tour.tourId}" />
        </c:if>

        <!-- Start -->
        <div class="flex flex-col space-y-4 sm:flex-row sm:space-y-0 sm:space-x-4">
            <!-- Depart Field -->
            <div class="flex-1">
                <label for="start" class="block text-sm font-medium text-gray-700">Depart:</label>
                <input type="text" id="start" name="start" value="${tour != null ? tour.start : ''}" required
                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500" />
            </div>

            <!-- Return Field -->
            <div class="flex-1">
                <label for="end" class="block text-sm font-medium text-gray-700">Return:</label>
                <input type="text" id="end" name="end" value="${tour != null ? tour.end : ''}" required
                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500" />
            </div>
        </div>

        <div class="flex flex-col space-y-4 sm:flex-row sm:space-y-0 sm:space-x-4">
            <!-- Date -->
            <div class="flex-1">
                <label for="date" class="block text-sm font-medium text-gray-700">Date:</label>
                <input type="text" id="date" name="date" value="${tour != null ? tour.date : ''}" required
                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500" />
            </div>

            <!-- Price -->
            <div class="flex-1">
                <label for="price" class="block text-sm font-medium text-gray-700">Price:</label>
                <input type="number" step="0.01" id="price" name="price" value="${tour != null ? tour.price : ''}" required
                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500" />
            </div>
        </div>

        <div class="flex flex-col space-y-4 sm:flex-row sm:space-y-0 sm:space-x-4">
            <div class="flex-1">
                <!-- Title -->
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700">Title:</label>
                    <input type="text" id="title" name="title" value="${tour != null ? tour.title : ''}" required
                        class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500" />
                </div>
                <!-- Category -->
                <div class="flex-1 mt-4">
                    <label for="category" class="block text-sm font-medium text-gray-700">Category:</label>
                    <select id="category" name="category" required
                            class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500">
                        <option value="">Select Category</option>
                        <option value="casa" ${tour != null && tour.category == 'casa' ? 'selected' : ''}>Casa</option>
                        <option value="marrakech" ${tour != null && tour.category == 'marrakech' ? 'selected' : ''}>Marrakech</option>
                        <option value="merzouga" ${tour != null && tour.category == 'merzouga' ? 'selected' : ''}>Merzouga</option>
                        <option value="tanger" ${tour != null && tour.category == 'tanger' ? 'selected' : ''}>Tanger</option>
                        <option value="fes" ${tour != null && tour.category == 'fes' ? 'selected' : ''}>Fes</option>
                        <option value="other" ${tour != null && tour.category == 'other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
            </div>

            <!-- Map Embed Code -->
            <div class="flex-1">
                <label for="mapEmbedCode" class="block text-sm font-medium text-gray-700">Map Embed Code:</label>
                <textarea id="mapEmbedCode" name="mapEmbedCode" rows="4" required
                        class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"><iframe src="${tour != null ? tour.mapEmbedCode : ''}"></iframe></textarea>
                <p class="text-gray-600 text-sm mt-1">
                    Please paste the full iframe embed code from Google Maps.
                </p>
            </div>
        </div>

        <!-- Description with Quill.js -->
        <div>
            <label for="description" class="block text-sm font-medium text-gray-700">Description:</label>
            <div id="editor-container" style="height: 300px;" class="border border-gray-300 rounded-md"></div>
            <!-- Hidden Input to Submit Form Data -->
            <input type="hidden" name="description" id="description">
        </div>

        <!-- Image Upload -->
        <div class="mb-4">
            <label for="image" class="block text-gray-700 font-bold mb-2">Tour Image:</label>
            <input type="file" id="image" name="image" accept="image/*"
                   class="border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>

        <c:if test="${tour != null && tour.imagePath != null}">
            <div class="mb-4">
                <img src="${pageContext.request.contextPath}/${tour.imagePath}" alt="Tour Image" class="w-32 h-32">
            </div>
        </c:if>
        
        <!-- Submit Button -->
        <div>
            <button type="submit"
                    class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition duration-300">
                ${tour != null ? "Update Tour" : "Create Tour"}
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
        placeholder: 'Enter tour description here...',
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
    const existingDescription = `${tour != null ? tour.description : ''}`;
    if (existingDescription) {
        quill.root.innerHTML = existingDescription;
    }
</script>

<jsp:include page="/includes/footer.jsp" />
