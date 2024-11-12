<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="flex items-center justify-center min-h-screen bg-gray-100">
    <div class="w-full max-w-md px-6 py-8 bg-white rounded-lg shadow-lg">
        <h2 class="text-3xl font-semibold text-center text-gray-700 mb-4">Forgot Password</h2>
        <p class="text-center text-gray-500 mb-8">Enter your email to reset your password</p>

        <form action="/ForgotPasswordServlet" method="POST">
            <div class="mb-4">
                <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 mt-1 text-gray-700 bg-gray-50 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>

            <button type="submit" class="w-full px-4 py-2 font-semibold text-white bg-blue-500 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
                Send Reset Link
            </button>
        </form>

        <p class="mt-6 text-sm text-center text-gray-600">
            <a href="login.jsp" class="text-blue-500 hover:underline">Back to Login</a>
        </p>
    </div>
</body>
</html>
