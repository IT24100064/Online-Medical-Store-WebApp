<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard | Supplier Management</title>
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
                <a href="index.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Dashboard</a>
                <a href="addSupplier.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Add Supplier</a>
                <a href="viewSuppliers" class="block py-2 px-4 rounded hover:bg-blue-700">View Supplier</a>
               <!--   <a href="supplierDashboard.jsp" class="block py-2 px-4 rounded hover:bg-blue-700 bg-blue-700 font-semibold">Suppliers</a>-->
            </nav>
            <div class="mt-auto text-sm text-blue-200 text-center">
                &copy; 2025 PharmaCare
            </div>
        </aside>
        <!-- Main Content -->
        <main class="flex-1 p-8 bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen">
    <!-- Top Row: Search and Avatar -->
    <div class="flex justify-between items-center mb-8">
        <div class="relative w-1/2">
            <input type="text" placeholder="Search suppliers..." class="w-full px-5 py-3 rounded-full bg-white shadow focus:outline-none focus:ring-2 focus:ring-blue-300 text-gray-700" />
            <span class="absolute right-4 top-1/2 -translate-y-1/2 text-blue-400">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/></svg>
            </span>
        </div>
        <div class="flex items-center gap-4">
            <span class="text-gray-700 font-semibold">Hi, Supplier Admin</span>
            <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-blue-300 shadow" />
        </div>
    </div>

    <!-- Hero / Announcement Card -->
    <div class="bg-blue-100 rounded-2xl flex flex-col md:flex-row items-center p-6 mb-8 shadow">
    <div class="flex-1">
        <h2 class="text-2xl font-bold text-blue-900 mb-2">Stay Informed with Supplier Updates!</h2>
        <p class="text-blue-700 mb-2">
            Get the latest analytics and insights on your suppliers for April 2025. Monitor growth, compliance, and performance-all in one place.
        </p>
        <p class="text-blue-400 text-sm">Check back regularly for new reports and tips to optimize your supply chain.</p>
    </div>
    <div class="flex-1 flex justify-center mt-4 md:mt-0">
        <!-- Animated SVG illustration -->
        <svg class="h-32 w-32 object-contain animate-bounce-slow" fill="none" viewBox="0 0 128 128">
            <ellipse cx="64" cy="110" rx="50" ry="10" fill="#bfdbfe"/>
            <rect x="36" y="40" width="56" height="36" rx="8" fill="#fff" stroke="#3b82f6" stroke-width="3"/>
            <rect x="52" y="60" width="24" height="8" rx="4" fill="#3b82f6"/>
            <circle cx="64" cy="80" r="8" fill="#fff" stroke="#3b82f6" stroke-width="3"/>
            <text x="64" y="85" text-anchor="middle" fill="#3b82f6" font-size="12" font-family="Arial">Info</text>
            <!-- Animated hand -->
            <g>
                <rect x="80" y="30" width="12" height="24" rx="6" fill="#3b82f6">
                    <animate attributeName="y" values="30;25;30" dur="1.5s" repeatCount="indefinite"/>
                </rect>
                <circle cx="86" cy="26" r="6" fill="#3b82f6">
                    <animate attributeName="cy" values="26;21;26" dur="1.5s" repeatCount="indefinite"/>
                </circle>
            </g>
        </svg>
    </div>
</div>
<!-- Tailwind custom animation for slower bounce -->
<style>
@keyframes bounce-slow {
  0%, 100% { transform: translateY(0);}
  50% { transform: translateY(-10px);}
}
.animate-bounce-slow {
  animation: bounce-slow 2s infinite;
}
</style>


    <!-- Dashboard Stat Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <!-- Total Suppliers -->
        <div class="bg-blue-100 rounded-2xl p-6 flex items-center gap-4 shadow">
            <div class="bg-blue-400 rounded-full p-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a4 4 0 00-3-3.87M9 20H4v-2a4 4 0 013-3.87M16 3.13a4 4 0 010 7.75M8 3.13a4 4 0 010 7.75M12 14a4 4 0 01-4-4V7a4 4 0 018 0v3a4 4 0 01-4 4z"/>
                </svg>
            </div>
            <div>
                <div class="text-2xl font-bold text-blue-900"><c:out value="${totalSuppliers}" default="0"/></div>
                <div class="text-blue-700 text-sm font-medium">Total Suppliers</div>
            </div>
        </div>
        <!-- Recently Added Supplier #1 -->
        <c:if test="${not empty recentSuppliers[0]}">
            <div class="bg-yellow-100 rounded-2xl p-6 flex items-center gap-4 shadow">
                <div class="bg-yellow-400 rounded-full p-4">
                    <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 10a4 4 0 100-8 4 4 0 000 8zm0 2a6 6 0 00-6 6v1h12v-1a6 6 0 00-6-6z"/>
                    </svg>
                </div>
                <div>
                    <div class="text-lg font-semibold text-gray-700">${recentSuppliers[0].name}</div>
                    <div class="text-gray-500 text-xs">${recentSuppliers[0].companyName} &middot; ${recentSuppliers[0].email}</div>
                    <div class="text-xs mt-1 text-gray-400">Added on ${recentSuppliers[0].addedDate}</div>
                </div>
            </div>
        </c:if>
        <!-- Recently Added Supplier #2 -->
        <c:if test="${not empty recentSuppliers[1]}">
            <div class="bg-pink-100 rounded-2xl p-6 flex items-center gap-4 shadow">
                <div class="bg-pink-400 rounded-full p-4">
                    <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 10a4 4 0 100-8 4 4 0 000 8zm0 2a6 6 0 00-6 6v1h12v-1a6 6 0 00-6-6z"/>
                    </svg>
                </div>
                <div>
                    <div class="text-lg font-semibold text-gray-700">${recentSuppliers[1].name}</div>
                    <div class="text-gray-500 text-xs">${recentSuppliers[1].companyName} &middot; ${recentSuppliers[1].email}</div>
                    <div class="text-xs mt-1 text-gray-400">Added on ${recentSuppliers[1].addedDate}</div>
                </div>
            </div>
        </c:if>
        <!-- Recently Added Supplier #3 -->
        <c:if test="${not empty recentSuppliers[2]}">
            <div class="bg-purple-100 rounded-2xl p-6 flex items-center gap-4 shadow">
                <div class="bg-purple-400 rounded-full p-4">
                    <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 10a4 4 0 100-8 4 4 0 000 8zm0 2a6 6 0 00-6 6v1h12v-1a6 6 0 00-6-6z"/>
                    </svg>
                </div>
                <div>
                    <div class="text-lg font-semibold text-gray-700">${recentSuppliers[2].name}</div>
                    <div class="text-gray-500 text-xs">${recentSuppliers[2].companyName} &middot; ${recentSuppliers[2].email}</div>
                    <div class="text-xs mt-1 text-gray-400">Added on ${recentSuppliers[2].addedDate}</div>
                </div>
            </div>
        </c:if>
    </div>





            <!-- Suppliers Table -->
            <div class="bg-white rounded-xl shadow p-6">
                <h2 class="text-xl font-bold text-blue-700 mb-4">All Suppliers</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-blue-100">
                        <thead>
                            <tr class="bg-blue-50">
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">ID</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Name</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Company</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Email</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Phone</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Type</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Details</th>
                                <th class="px-4 py-2 text-left text-xs font-semibold text-blue-800 uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="supplier" items="${suppliers}">
                                <tr class="hover:bg-blue-100 transition">
                                    <td class="px-4 py-2">${supplier.id}</td>
                                    <td class="px-4 py-2">${supplier.name}</td>
                                    <td class="px-4 py-2">${supplier.companyName}</td>
                                    <td class="px-4 py-2">${supplier.email}</td>
                                    <td class="px-4 py-2">${supplier.phone}</td>
                                    <td class="px-4 py-2 capitalize">
                                        <c:choose>
                                            <c:when test="${supplier['class'].simpleName eq 'LocalSupplier'}">Local</c:when>
                                            <c:when test="${supplier['class'].simpleName eq 'InternationalSupplier'}">International</c:when>
                                            <c:otherwise>General</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-4 py-2 text-xs">
                                        <c:choose>
                                            <c:when test="${supplier['class'].simpleName eq 'LocalSupplier'}">
                                                Tax ID: ${supplier.localTaxId}
                                            </c:when>
                                            <c:when test="${supplier['class'].simpleName eq 'InternationalSupplier'}">
                                                Country: ${supplier.country}<br/>
                                                Import Duty: ${supplier.importDuty}
                                            </c:when>
                                            <c:otherwise>
                                                &ndash;
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-4 py-2 space-x-2">
                                        <a href="editSupplier.jsp?id=${supplier.id}" class="inline-block bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 text-sm font-semibold">Edit</a>
                                        <form action="deleteSupplier" method="post" class="inline-block" onsubmit="return confirm('Are you sure you want to delete this supplier?');">
                                            <input type="hidden" name="id" value="${supplier.id}">
                                            <button type="submit" class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700 text-sm font-semibold">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty suppliers}">
                                <tr>
                                    <td colspan="8" class="px-4 py-8 text-center text-gray-400">No suppliers found.</td>
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
