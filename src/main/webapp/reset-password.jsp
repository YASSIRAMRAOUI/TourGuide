<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="flex items-center justify-center min-h-screen bg-gray-100">
    <div class="w-full max-w-md px-6 py-8 bg-white rounded-lg shadow-lg">
        <h2 class="text-3xl font-semibold text-center text-gray-700 mb-4">Reset Password</h2>
        <p class="text-center text-gray-500 mb-8">Enter a new password for your account</p>

        <form action="ResetPasswordServlet" method="POST">
            <input type="hidden" name="token" value="<%= request.getAttribute("token") %>">

            <div class="mb-4">
                <label for="newPassword" class="block text-sm font-medium text-gray-600">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required
                       class="w-full px-4 py-2 mt-1 text-gray-700 bg-gray-50 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>

            <button type="submit" class="w-full px-4 py-2 font-semibold text-white bg-blue-500 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
                Reset Password
            </button>
        </form>
    </div>
</body>
</html>
