<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard | Pharmacy System</title>
    <meta charset="UTF-8">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen">
    <!-- Sidebar Navigation -->
    <div class="flex min-h-screen">
        <aside class="bg-blue-800 text-white w-64 flex flex-col py-8 px-4">
            <div class="mb-10 text-2xl font-bold tracking-wide text-center">PharmaCare Admin</div>
            <nav class="flex-1 space-y-2">
                <a href="dashboard.jsp" class="block py-2 px-4 rounded hover:bg-blue-700 bg-blue-700 font-semibold">Dashboard</a>
                <a href="addMedicine.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Add Medicine</a>
                <a href="viewMedicines" class="block py-2 px-4 rounded hover:bg-blue-700">View Medicines</a>
            </nav>
            <div class="mt-auto text-sm text-blue-200 text-center">
                &copy; 2025 PharmaCare
            </div>
        </aside>
        <!-- Main Content -->
        <main class="flex-1 p-8">
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-3xl font-extrabold text-blue-800">Medicine Dashboard</h1>
                <a href="addMedicine.jsp" class="bg-blue-700 text-white px-6 py-2 rounded-lg shadow hover:bg-blue-800 font-bold transition">+ Add Medicine</a>
            </div>
            <!-- Medicines Table -->
            <div class="bg-white rounded-xl shadow p-6">
                <h2 class="text-xl font-bold text-blue-700 mb-4">All Medicines</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-blue-100">
                        <thead>
                            <tr class="bg-blue-50">
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">ID</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Name</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Category</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Price</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Quantity</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Expiry</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="medicine" items="${medicines}">
                                <tr class="hover:bg-blue-100 transition">
                                    <td class="px-4 py-2">${medicine.id}</td>
                                    <td class="px-4 py-2">${medicine.name}</td>
                                    <td class="px-4 py-2 capitalize">${medicine.category}</td>
                                    <td class="px-4 py-2">₹${medicine.price}</td>
                                    <td class="px-4 py-2">${medicine.quantity}</td>
                                    <td class="px-4 py-2">${medicine.expiryDate}</td>
                                    <td class="px-4 py-2 space-x-2">
                                        <a href="editMedicine.jsp?id=${medicine.id}" class="inline-block bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 text-sm font-semibold">Edit</a>
                                        <form action="deleteMedicine" method="post" class="inline-block" onsubmit="return confirm('Are you sure you want to delete this medicine?');">
                                            <input type="hidden" name="id" value="${medicine.id}">
                                            <button type="submit" class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700 text-sm font-semibold">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty medicines}">
                                <tr>
                                    <td colspan="7" class="px-4 py-8 text-center text-gray-400">No medicines found.</td>
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