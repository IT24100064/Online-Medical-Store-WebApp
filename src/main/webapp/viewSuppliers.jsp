<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Suppliers | PharmaCare Admin</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen">
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="bg-blue-800 text-white w-64 flex flex-col py-8 px-4">
            <div class="mb-10 text-2xl font-bold tracking-wide text-center">PharmaCare Admin</div>
            <nav class="flex-1 space-y-2">
                <a href="index.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Dashboard</a>
                <a href="addSupplier.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Add Supplier</a>
                <a href="viewSuppliers.jsp" class="block py-2 px-4 rounded hover:bg-blue-700 bg-blue-700 font-semibold">View Suppliers</a>
            </nav>
            <div class="mt-auto text-sm text-blue-200 text-center">
                &copy; 2025 PharmaCare
            </div>
        </aside>
        <!-- Main Content -->
        <main class="flex-1 p-8">
            <div class="flex flex-col md:flex-row md:justify-between md:items-center mb-8 gap-4">
                <h1 class="text-3xl font-extrabold text-blue-800">Suppliers</h1>
                <div class="flex flex-col md:flex-row gap-2 md:gap-4">
                    <form action="viewSuppliers" method="get" class="flex gap-2">
                        <input type="text" name="search" placeholder="Search suppliers..."
                               class="px-4 py-2 border border-blue-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-300 bg-blue-50"
                               value="${param.search}">
                        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg font-semibold hover:bg-blue-700 transition">
                            Search
                        </button>
                    </form>
                    <a href="addSupplier.jsp" class="bg-green-600 text-white px-4 py-2 rounded-lg font-semibold hover:bg-green-700 transition">
                        + Add New Supplier
                    </a>
                </div>
            </div>
            <div class="bg-white rounded-xl shadow p-6">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-blue-100">
                        <thead>
                            <tr class="bg-blue-50">
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">ID</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Name</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Email</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Phone</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Address</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Company</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Type</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Details</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-blue-100">
                            <c:forEach items="${suppliers}" var="supplier">
                                <tr class="hover:bg-blue-50">
                                    <td class="px-4 py-2">${supplier.id}</td>
                                    <td class="px-4 py-2">${supplier.name}</td>
                                    <td class="px-4 py-2">${supplier.email}</td>
                                    <td class="px-4 py-2">${supplier.phone}</td>
                                    <td class="px-4 py-2">${supplier.address}</td>
                                    <td class="px-4 py-2">${supplier.companyName}</td>
                                    <td class="px-4 py-2">
                                        <c:choose>
                                            <c:when test="${supplier.getClass().simpleName == 'LocalSupplier'}">
                                                <span class="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-xs">Local</span>
                                            </c:when>
                                            <c:when test="${supplier.getClass().simpleName == 'InternationalSupplier'}">
                                                <span class="px-2 py-1 bg-green-100 text-green-800 rounded-full text-xs">International</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2 py-1 bg-gray-100 text-gray-800 rounded-full text-xs">Standard</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-4 py-2">
                                        <c:choose>
                                            <c:when test="${supplier.getClass().simpleName == 'LocalSupplier'}">
                                                Tax ID: ${supplier.taxId}
                                            </c:when>
                                            <c:when test="${supplier.getClass().simpleName == 'InternationalSupplier'}">
                                                Duty: ${supplier.importDuty}, Country: ${supplier.country}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-4 py-2 space-x-2">
                                        <a href="editSupplier?id=${supplier.id}"
                                           class="px-3 py-1.5 bg-yellow-500 text-white rounded-md hover:bg-yellow-600 text-sm">
                                            Edit
                                        </a>
                                        <a href="deleteSupplier?id=${supplier.id}"
                                           class="px-3 py-1.5 bg-red-500 text-white rounded-md hover:bg-red-600 text-sm"
                                           onclick="return confirm('Are you sure you want to delete this supplier?');">
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty suppliers}">
                                <tr>
                                    <td colspan="9" class="text-center py-8 text-gray-500">No suppliers found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
