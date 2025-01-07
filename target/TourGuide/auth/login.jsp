<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
    <body class="flex items-center justify-center min-h-screen bg-gradient-to-tl from-stone-300 via-yellow-200 to-stone-300">
        <jsp:include page="/includes/header.jsp" />

        <%
            // Check if there is a "rememberedEmail" cookie
            String rememberedEmail = "";
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("rememberedEmail".equals(cookie.getName())) {
                        rememberedEmail = cookie.getValue();
                        break;
                    }
                }
            }
        %>

        <script>
            function togglePassword() {
                const passwordInput = document.getElementById("password");
                const toggleIcon = document.getElementById("togglePasswordIcon");

                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    toggleIcon.classList.remove("fa-eye-slash");
                    toggleIcon.classList.add("fa-eye");
                } else {
                    passwordInput.type = "password";
                    toggleIcon.classList.remove("fa-eye");
                    toggleIcon.classList.add("fa-eye-slash");
                }
            }
        </script>

        <div class="w-full max-w-md bg-white rounded-lg shadow-lg p-6 mx-10">
            <div class="flex justify-center mb-6">
                <img src="../assets/touriste.jpg" alt="Logo" class="w-32 h-20"> <!-- Adjust the width and height as needed -->
            </div>

            <h2 class="text-3xl font-semibold text-center text-gray-700 mb-4">Welcome Back</h2>
            <p class="text-center text-gray-500 mb-8">Please log in to your account</p>

            <% String errorMessage = (String) request.getAttribute("errorMessage"); if (errorMessage != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4" role="alert">
                <span class="block sm:inline"><%= errorMessage %></span>
            </div>
            <% } %>

            <form action="/LoginServlet" method="POST">
                <div class="mb-4">
                    <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
                    <input type="text" id="email" name="email" required value="<%= rememberedEmail %>"
                        class="w-full px-4 py-2 mt-1 text-gray-700 bg-gray-50 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                
                <div class="mb-4 relative">
                    <label for="password" class="block text-sm font-medium text-gray-600">Password</label>
                    <div class="flex items-center mt-1 bg-gray-50 border rounded-lg">
                        <input type="password" id="password" name="password" required
                            class="w-full px-4 py-2 text-gray-700 bg-gray-50 border-none rounded-l-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <!-- Eye icon to toggle password visibility -->
                        <span class="px-3 flex items-center cursor-pointer" onclick="togglePassword()">
                            <i id="togglePasswordIcon" class="fas fa-eye-slash text-gray-500"></i>
                        </span>
                    </div>
                </div>

                <div class="flex items-center justify-between mb-6">
                    <label class="flex items-center text-sm text-gray-600">
                        <input type="checkbox" name="remember" class="mr-2 rounded focus:ring-2 focus:ring-blue-500" <%= rememberedEmail.isEmpty() ? "" : "checked" %>>
                        Remember me
                    </label>
                    <a href="forgot-password.jsp" class="text-sm text-blue-500 hover:underline">Forgot your password?</a>
                </div>

                <button type="submit" class="w-full px-4 py-3 bg-yellow-700 text-white text-sm font-medium rounded-full hover:bg-yellow-600 transition duration-300">
                    Log In
                </button>
            </form>

            <p class="mt-6 text-sm text-center text-gray-600">
                Don't have an account? <a href="register.jsp" class="text-blue-500 hover:underline">Register here</a>
            </p>
        </div>

    </body>
</html>
