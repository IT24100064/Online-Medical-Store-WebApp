<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pharmacy Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-4xl bg-white rounded-3xl shadow-2xl flex overflow-hidden">
        <!-- Left Branding Panel -->
        <div class="w-1/2 bg-blue-600 flex flex-col justify-center items-center p-10 relative">
            <!-- Pharmacy Logo (optional, replace src as needed) -->
            <div class="mb-8">
                <svg class="h-12 w-12 text-white" fill="none" viewBox="0 0 48 48">
                  <circle cx="24" cy="24" r="24" fill="#fff" fill-opacity="0.1"/>
                  <path d="M24 12l8 8-8 8-8-8 8-8z" fill="#fff" fill-opacity="0.2"/>
                </svg>
            </div>
            <h2 class="text-3xl font-extrabold text-white mb-2 text-center">AI FOR PHARMACY</h2>
            <p class="text-blue-100 text-lg text-center mb-10">Secure access to manage your pharmacy and make accurate decisions.</p>
            <!-- Decorative hexagons/cubes (optional for effect) -->
            <div class="absolute inset-0 pointer-events-none">
                <div class="absolute top-10 left-10 w-16 h-16 bg-white bg-opacity-10 rounded-2xl blur-2xl"></div>
                <div class="absolute bottom-10 right-10 w-20 h-20 bg-white bg-opacity-10 rounded-2xl blur-2xl"></div>
            </div>
        </div>
        <!-- Right Login Form -->
        <div class="w-1/2 flex flex-col justify-center px-10 py-12">
            <h3 class="text-2xl font-bold text-gray-800 mb-2 text-center">Welcome to Pharmacy Portal</h3>
            <p class="text-gray-400 text-center mb-8">Sign in to manage your pharmacy account</p>
            <c:if test="${not empty param.error}">
                <div class="mb-4 bg-red-100 text-red-700 px-4 py-2 rounded text-center">Invalid credentials. Please try again.</div>
            </c:if>
            <form action="login" method="post" class="space-y-6">
                <div>
                    <label class="block mb-1 text-gray-700 font-medium">Email/Username</label>
                    <input type="text" name="username" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                </div>
                <div>
                    <label class="block mb-1 text-gray-700 font-medium">Password</label>
                    <input type="password" name="password" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                </div>
                <div>
                    <label class="block mb-1 text-gray-700 font-medium">Role</label>
                    <select name="role" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                        <option value="Admin">Admin</option>
                        <option value="Regular">Regular User</option>
                    </select>
                </div>
                <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-lg shadow transition duration-150 text-lg">Login</button>
            </form>
            <!-- Optional: Add links for help/privacy/terms as in the image -->
            <div class="flex justify-center gap-6 mt-8 text-sm text-gray-400">
                <a href="#" class="hover:text-blue-600">Help</a>
                <a href="#" class="hover:text-blue-600">Privacy</a>
                <a href="#" class="hover:text-blue-600">Terms</a>
            </div>
        </div>
    </div>
</body>
</html>