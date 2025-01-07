<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex items-center justify-center min-h-screen bg-gradient-to-tl from-stone-300 via-yellow-200 to-stone-300">
    <div class="w-full max-w-md px-6 py-8 bg-white rounded-lg shadow-lg">
        <h2 class="text-3xl font-semibold text-center text-gray-700 mb-4">Forgot Password</h2>
        <p class="text-center text-gray-500 mb-8">Enter your email to reset your password</p>

        <form action="/ForgotPasswordServlet" method="POST">
            <div class="mb-4">
                <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 mt-1 text-gray-700 bg-gray-50 border rounded-lg focus:outline-none focus:ring-2 focus:ring-stone-500">
            </div>

            <button type="submit" class="w-full px-4 py-3 bg-yellow-700 text-white text-sm font-medium rounded-full hover:bg-yellow-600 transition duration-300">
                Send Reset Link
            </button>
        </form>

        <p class="mt-6 text-sm text-center text-gray-600">
            <a href="login.jsp" class="text-stone-500 hover:underline">Back to Login</a>
        </p>
    </div>
</body>
</html>
