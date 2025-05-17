<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function showRegularFields() {
            const role = document.getElementById("role").value;
            const isRegular = role === "Regular";
            document.getElementById("regularFields").style.display = isRegular ? "block" : "none";
            document.getElementById("address").required = isRegular;
            document.getElementById("contact").required = isRegular;
        }

        window.onload = function () {
            document.querySelector('form').reset();
            document.getElementById("role").addEventListener('change', showRegularFields);
            showRegularFields();
        };

        function validateForm() {
            const contact = document.getElementById("contact");
            const role = document.getElementById("role").value;
            if (role === "Regular") {
                const contactValue = contact.value.trim();
                const contactPattern = /^[0-9]{10}$/;
                if (!contactPattern.test(contactValue)) {
                    alert("Contact number must be exactly 10 digits.");
                    contact.focus();
                    return false;
                }
            }
            return true;
        }
    </script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-4xl bg-white rounded-3xl shadow-2xl flex overflow-hidden">
        <!-- Left Branding Panel -->
        <div class="w-1/2 bg-blue-600 flex flex-col justify-center items-center p-10 relative">
            <!-- Pharmacy Logo (placeholder, replace with your logo if needed) -->
            <div class="mb-8">
                <svg class="h-12 w-12 text-white" fill="none" viewBox="0 0 48 48">
                  <circle cx="24" cy="24" r="24" fill="#fff" fill-opacity="0.1"/>
                  <path d="M24 12l8 8-8 8-8-8 8-8z" fill="#fff" fill-opacity="0.2"/>
                </svg>
            </div>
            <h2 class="text-3xl font-extrabold text-white mb-2 text-center">Register for Pharmacy</h2>
            <p class="text-blue-100 text-lg text-center mb-10">Create your account to access pharmacy services and manage your health.</p>
            <!-- Decorative cubes/hexagons for effect -->
            <div class="absolute inset-0 pointer-events-none">
                <div class="absolute top-10 left-10 w-16 h-16 bg-white bg-opacity-10 rounded-2xl blur-2xl"></div>
                <div class="absolute bottom-10 right-10 w-20 h-20 bg-white bg-opacity-10 rounded-2xl blur-2xl"></div>
            </div>
        </div>
        <!-- Right Registration Form -->
        <div class="w-1/2 flex flex-col justify-center px-10 py-12">
            <h3 class="text-2xl font-bold text-gray-800 mb-2 text-center">User Registration</h3>
            <p class="text-gray-400 text-center mb-8">Sign up to start managing your pharmacy account</p>
            <form method="post" action="register" autocomplete="off" novalidate onsubmit="return validateForm();" class="space-y-5">
                <!-- Hidden dummy fields to prevent autofill -->
                <input type="email" name="fakeEmail" style="display:none;">
                <input type="password" name="fakePassword" style="display:none;">

                <c:if test="${not empty param.error}">
                    <div class="mb-4 bg-red-100 text-red-700 px-4 py-2 rounded text-center">
                        <c:choose>
                            <c:when test="${param.error == 'InvalidRole'}">Invalid user role selected</c:when>
                            <c:when test="${param.error == 'FileWriteError'}">Error saving user data</c:when>
                            <c:when test="${param.error == 'InvalidContact'}">Contact number must be exactly 10 digits</c:when>
                            <c:otherwise>Registration error occurred</c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <div>
                    <label class="block mb-1 text-gray-700 font-medium">Username</label>
                    <input type="text" name="username" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                </div>

                <div>
                    <label class="block mb-1 text-gray-700 font-medium">Email</label>
                    <input type="email" name="email" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                </div>

                <div>
                    <label class="block mb-1 text-gray-700 font-medium">Password</label>
                    <input type="password" name="password"
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                           required minlength="8"
                           pattern="^(?=.[A-Za-z])(?=.\\d).{8,}$"
                           title="Password must be at least 8 characters long and include at least one letter and one number.">
                </div>

                <div>
                    <label class="block mb-1 text-gray-700 font-medium">User Role</label>
                    <select name="role" id="role" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                        <option value="">Select Role</option>
                        <option value="Admin">Admin</option>
                        <option value="Regular">Regular User</option>
                    </select>
                </div>

                <div id="regularFields" style="display: none;">
                    <div class="mt-3">
                        <label class="block mb-1 text-gray-700 font-medium">Address</label>
                        <input type="text" name="address" id="address" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                    </div>
                    <div class="mt-3">
                        <label class="block mb-1 text-gray-700 font-medium">Contact Number</label>
                        <input type="tel" name="contact" id="contact"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                               pattern="[0-9]{10}"
                               maxlength="10"
                               title="Enter a valid 10-digit contact number.">
                    </div>
                </div>

                <div class="flex flex-col gap-2 mt-6">
                    <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-lg shadow transition duration-150 text-lg">Register</button>
                    <a href="login.jsp" class="text-blue-600 hover:underline text-center">Already have an account? Login</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>