<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <img src="../assets/contactUs.jpg" alt="Contct Us"
        class="h-full w-full object-fill">
</div>
<section class="text-gray-600 body-font relative">
    <div class="flex justify-center items-center py-4">
        <h2 class="text-4xl font-bold text-gray-700">Contact us</h2>
        <span class="inline-flex ml-20">
            <a href="https://www.facebook.com/yassir.amraoui.100/" class="text-blue-600 text-3xl hover:text-blue-800">
                <i class="fa-brands fa-facebook"></i>
            </a>
            <a href="https://www.instagram.com/yassir_5.0/" class="ml-3 text-pink-600 text-3xl hover:text-pink-800">
                <i class="fa-brands fa-instagram"></i>
            </a>
            <a href="https://www.x.com/yassir_Amraoui_" class="ml-3 text-blue-400 text-3xl hover:text-blue-600">
                <i class="fa-brands fa-twitter"></i>
            </a>
            <a href="https://www.linkedin.com/in/yassir-amraoui/" class="ml-3 text-blue-700 text-3xl hover:text-blue-900">
                <i class="fa-brands fa-linkedin"></i>
            </a>
            <a href="https://www.tripadvisor.com/Profile/527yassira">
                <img src="../assets/tripadvisor.png" alt="Tripadvisor" class="ml-3 h-9 w-9">
            </a>
        </span>
    </div>
    <div class="container p-5 mx-auto flex sm:flex-nowrap flex-wrap">
        <div class="lg:w-2/3 md:w-1/2 rounded-lg overflow-hidden sm:mr-10 p-10 flex items-end justify-start relative">
            <iframe
                width="100%" height="100%" class="absolute inset-0" frameborder="0" title="map" marginheight="0"
                marginwidth="0" scrolling="no"
                src=https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d105867.01280859727!2d-6.868173!3d33.983693!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sma!4v1736341879944!5m2!1sen!2sma"
                style="filter: contrast(1.2);"></iframe>
            <div class="bg-white relative flex flex-wrap py-6 rounded shadow-md">
                <div class="lg:w-1/2 px-6">
                    <h2 class="title-font font-semibold text-gray-900 tracking-widest text-xs"><i class="fa-solid fa-location-dot mr-2"></i>ADDRESS</h2>
                    <p class="mt-1">Ennarjis, Errachidia, Morocco</p>
                </div>
                <div class="lg:w-1/2 px-6 mt-4 lg:mt-0">
                    <h2 class="title-font font-semibold text-gray-900 tracking-widest text-xs"><i class="fa-solid fa-envelope mr-2"></i>EMAIL</h2>
                    <a class="leading-relaxed">info@tourist.com</a>
                    <h2 class="title-font font-semibold text-gray-900 tracking-widest text-xs mt-4"><i class="fa-solid fa-phone mr-2"></i>PHONE</h2>
                    <p class="leading-relaxed">+212 643627141</p>
                </div>
            </div>
        </div>

        <!-- Contact Form Section -->
        <div class="lg:w-1/3 md:w-1/2 bg-white flex flex-col md:ml-auto w-full md:py-8 md:mt-0 px-6 rounded-lg">
            <h2 class="text-gray-900 text-lg my-2 font-medium title-font">Get in Touch</h2>
            <p class="leading-relaxed mb-5 text-gray-600">Have a question or comment? We'd love to hear from you!</p>

            <!-- Display Success or Error Messages -->
            <c:if test="${not empty message}">
                <div class="p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg" role="alert">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg" role="alert">
                    ${error}
                </div>
            </c:if>

            <!-- Contact Form -->
            <form action="<c:url value='/ContactServlet' />" method="post">
                <div class="relative mb-4">
                    <label for="name" class="leading-7 text-sm text-gray-600">Name</label>
                    <input type="text" id="name" name="name"
                        class="w-full bg-white rounded border border-gray-300 focus:border-bleu-500 focus:ring-2 focus:ring-bleu-200 text-base outline-none text-gray-700 py-2 px-4 leading-8 transition-colors duration-200 ease-in-out"
                        required>
                </div>
                <div class="relative mb-4">
                    <label for="email" class="leading-7 text-sm text-gray-600">Email</label>
                    <input type="email" id="email" name="email"
                        class="w-full bg-white rounded border border-gray-300 focus:border-bleu-500 focus:ring-2 focus:ring-bleu-200 text-base outline-none text-gray-700 py-2 px-4 leading-8 transition-colors duration-200 ease-in-out"
                        required>
                </div>
                <div class="relative mb-4">
                    <label for="message" class="leading-7 text-sm text-gray-600">Message</label>
                    <textarea id="message" name="message"
                        class="w-full bg-white rounded border border-gray-300 focus:border-bleu-500 focus:ring-2 focus:ring-bleu-200 h-32 text-base outline-none text-gray-700 py-2 px-4 resize-none leading-6 transition-colors duration-200 ease-in-out"
                        required></textarea>
                </div>
                <button
                    class="w-full px-4 py-3 bg-yellow-700 text-white text-sm font-medium rounded-full hover:bg-yellow-600 transition duration-300">
                    Submit
                </button>
            </form>

            <p class="text-xs text-gray-500 my-3">
                We typically respond within 24 hours.
            </p>
        </div>
    </div>
</section>

<jsp:include page="/includes/footer.jsp" />
