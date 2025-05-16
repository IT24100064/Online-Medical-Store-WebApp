<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register New Admin</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-lg bg-white rounded-2xl shadow-2xl p-8 mx-4 animate-fade-in">
        <h1 class="text-3xl font-extrabold text-blue-800 text-center mb-6">Register New Admin</h1>

        <!-- Error Messages Container -->
        <c:if test="${not empty errors}">
            <div class="mb-6 p-4 bg-red-100 border border-red-300 text-red-700 rounded-lg">
                <h3 class="font-bold mb-2">Validation Errors:</h3>
                <ul class="list-disc pl-6 text-sm">
                    <c:forEach items="${errors}" var="error">
                        <li>${error.value}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/adminCreate" method="post" class="space-y-6">
            <!-- Employee ID Field -->
            <div>
                <label for="employeeId" class="block text-sm font-medium text-gray-700 mb-1">Employee ID</label>
                <input type="text" id="employeeId" name="employeeId"
                    placeholder="ID12345"
                    pattern="ID\d{5}"
                    title="ID followed by 5 digits (e.g. ID12345)"
                    value="${preservedEmployeeId}" required
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-500 transition disabled:bg-gray-100">
                <small class="text-gray-500">Format: ID followed by 5 digits (e.g. ID12345)</small>
                <c:if test="${not empty errors.employeeId}">
                    <span class="text-red-600 text-xs mt-1 block">${errors.employeeId}</span>
                </c:if>
            </div>

            <!-- Username Field -->
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <input type="text" id="username" name="username"
                    value="${preservedUsername}" required
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-500 transition disabled:bg-gray-100">
                <c:if test="${not empty errors.username}">
                    <span class="text-red-600 text-xs mt-1 block">${errors.username}</span>
                </c:if>
            </div>

            <!-- Password Field -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input type="password" id="password" name="password" required
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-500 transition disabled:bg-gray-100">
                <c:if test="${not empty errors.password}">
                    <span class="text-red-600 text-xs mt-1 block">${errors.password}</span>
                </c:if>
            </div>

            <!-- Email Field -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input type="email" id="email" name="email"
                    value="${preservedEmail}" required
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-500 transition disabled:bg-gray-100">
                <c:if test="${not empty errors.email}">
                    <span class="text-red-600 text-xs mt-1 block">${errors.email}</span>
                </c:if>
            </div>

            <!-- Permissions Checkboxes -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Permissions</label>
                <div class="flex flex-wrap gap-3">
                    <c:forEach items="${allPermissions}" var="perm">
                        <label class="flex items-center space-x-2 bg-blue-50 px-3 py-1 rounded-lg text-blue-800 font-medium cursor-pointer transition hover:bg-blue-100">
                            <input type="checkbox" name="permissions" value="${perm}"
                                class="accent-blue-600 rounded"
                                <c:if test="${preservedPermissions != null && preservedPermissions.contains(perm)}">checked</c:if>
                            >
                            <span>${perm.replace('_', ' ')}</span>
                        </label>
                    </c:forEach>
                </div>
                <c:if test="${not empty errors.permissions}">
                    <span class="text-red-600 text-xs mt-1 block">${errors.permissions}</span>
                </c:if>
            </div>

            <button type="submit"
                class="w-full py-3 bg-blue-700 text-white font-bold rounded-lg shadow hover:bg-blue-800 transition text-lg tracking-wide">
                Create Admin
            </button>
        </form>
    </div>
    <style>
        @keyframes fade-in {
            from { opacity: 0; transform: translateY(30px);}
            to { opacity: 1; transform: translateY(0);}
        }
        .animate-fade-in {
            animation: fade-in 0.6s cubic-bezier(0.4,0,0.2,1);
        }
    </style>
</body>
</html>
