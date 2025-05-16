<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin List</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-7xl mx-auto p-6">
        <div class="bg-white rounded-2xl shadow-2xl p-8">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
                <h1 class="text-3xl font-extrabold text-blue-800 mb-4 md:mb-0">All Admin Accounts</h1>
                <div class="flex gap-3">
                    <a href="adminCreate.jsp" class="bg-blue-700 text-white px-5 py-2 rounded-lg shadow hover:bg-blue-800 font-bold transition">Register New Admin</a>
                    <a href="index.jsp" class="bg-gray-200 text-blue-800 px-5 py-2 rounded-lg shadow hover:bg-blue-100 font-bold transition">Back to Dashboard</a>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full table-auto text-left border-separate border-spacing-y-2">
                    <thead class="bg-blue-100">
                        <tr>
                            <th class="px-4 py-3 text-blue-800 font-semibold rounded-l-xl">Employee ID</th>
                            <th class="px-4 py-3 text-blue-800 font-semibold">Username</th>
                            <th class="px-4 py-3 text-blue-800 font-semibold">Email</th>
                            <th class="px-4 py-3 text-blue-800 font-semibold">Permissions</th>
                            <th class="px-4 py-3 text-blue-800 font-semibold">Activity Log</th>
                            <th class="px-4 py-3 text-blue-800 font-semibold rounded-r-xl">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="admin" items="${admins}">
                            <tr class="bg-white hover:bg-blue-50 transition-shadow shadow-sm rounded-xl">
                                <td class="px-4 py-3 font-mono text-blue-700">${admin.employeeId}</td>
                                <td class="px-4 py-3">${admin.username}</td>
                                <td class="px-4 py-3">${admin.email}</td>
                                <td class="px-4 py-3">
                                    <c:forEach var="perm" items="${admin.permissions}">
                                        <span class="inline-block bg-blue-100 text-blue-800 text-xs font-semibold mr-1 mb-1 px-2 py-1 rounded">${perm}</span>
                                    </c:forEach>
                                </td>
                                <td class="px-4 py-3 max-w-xs break-words">
                                    <c:forEach var="log" items="${admin.activityLog}">
                                        <span class="block text-gray-600 text-xs mb-1">${log}</span>
                                    </c:forEach>
                                </td>
                                <td class="px-4 py-3 flex gap-2">
                                    <form action="${pageContext.request.contextPath}/adminUpdate" method="get">
                                        <input type="hidden" name="employeeId" value="${admin.employeeId}" />
                                        <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-4 py-1 rounded shadow font-semibold transition">Edit</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/adminDelete" method="post" onsubmit="return confirm('Are you sure?')">
                                        <input type="hidden" name="employeeId" value="${admin.employeeId}" />
                                        <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-4 py-1 rounded shadow font-semibold transition">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
