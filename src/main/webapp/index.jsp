<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Online Pharmacy Admin System</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen">
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="bg-blue-800 text-white w-64 flex flex-col py-8 px-4">
            <div class="mb-10 text-2xl font-bold tracking-wide text-center">Pharmacy Admin</div>
            <nav class="flex-1 space-y-2">
                <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="block py-2 px-4 rounded hover:bg-blue-700 bg-blue-700 font-semibold">Admin Dashboard</a>
                <a href="${pageContext.request.contextPath}/adminList" class="block py-2 px-4 rounded hover:bg-blue-700">View Admins</a>
                <a href="${pageContext.request.contextPath}/adminCreate.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Register New Admin</a>
            </nav>
            <div class="mt-auto text-sm text-blue-200 text-center">
                &copy; 2025 Online Pharmacy
            </div>
        </aside>
        <!-- Main Content -->
        <main class="flex-1 p-8">
            <div class="flex items-center justify-between mb-8">
                <h1 class="text-3xl font-extrabold text-blue-800">Welcome, Admin</h1>
                <span class="bg-blue-100 text-blue-800 px-4 py-2 rounded-lg font-semibold">Admin Panel</span>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">
                <a href="${pageContext.request.contextPath}/index.jsp" class="bg-white rounded-xl shadow-lg p-6 flex flex-col items-center hover:shadow-xl transition group">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-blue-600 mb-4 group-hover:text-blue-800 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M13 5v6h6"/>
                    </svg>
                    <span class="font-bold text-lg text-blue-800">Go to Admin Dashboard</span>
                    <span class="text-gray-500 text-sm mt-2">Overview & stats</span>
                </a>
                <a href="${pageContext.request.contextPath}/adminList" class="bg-white rounded-xl shadow-lg p-6 flex flex-col items-center hover:shadow-xl transition group">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-green-600 mb-4 group-hover:text-green-800 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a4 4 0 00-3-3.87M9 20H4v-2a4 4 0 013-3.87M16 3.13a4 4 0 010 7.75M8 3.13a4 4 0 010 7.75"/>
                    </svg>
                    <span class="font-bold text-lg text-green-800">View Admins</span>
                    <span class="text-gray-500 text-sm mt-2">Manage admin users</span>
                </a>
                <a href="${pageContext.request.contextPath}/adminCreate.jsp" class="bg-white rounded-xl shadow-lg p-6 flex flex-col items-center hover:shadow-xl transition group">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-purple-600 mb-4 group-hover:text-purple-800 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    <span class="font-bold text-lg text-purple-800">Register New Admin</span>
                    <span class="text-gray-500 text-sm mt-2">Add new admin account</span>
                </a>
            </div>
            <div class="bg-white rounded-xl shadow-lg p-6">
                <h2 class="text-xl font-semibold text-blue-800 mb-4">System Tips</h2>
                <ul class="list-disc pl-5 text-gray-700 space-y-2">
                    <li>Monitor pharmacy inventory and staff actions in real time.</li>
                    <li>Quickly add or remove admin users as needed.</li>
                    <li>Access reports and analytics from the dashboard for informed decisions.</li>
                </ul>
            </div>
        </main>
    </div>
</body>
</html>
