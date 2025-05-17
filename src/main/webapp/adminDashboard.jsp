<%@ page import="com.onlinepharmacy.model.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100 min-h-screen">
    <!-- Header -->
    <header class="bg-blue-700 shadow py-6 px-8 flex items-center justify-between">
        <h1 class="text-3xl font-extrabold text-white tracking-wide">Admin Dashboard</h1>
        <a href="logout" class="text-blue-100 hover:text-white font-semibold transition">Logout</a>
    </header>

    <main class="max-w-6xl mx-auto py-10 px-4">
        <%
            User admin = (User) session.getAttribute("currentUser");
            if (admin != null && "Admin".equals(admin.getRole())) {
        %>
        <!-- Admin Info Card -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-8 flex items-center gap-6">
            <div class="flex-shrink-0">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Admin" class="w-20 h-20 rounded-full border-4 border-blue-200 bg-blue-100 object-cover">
            </div>
            <div>
                <h3 class="text-xl font-bold text-blue-700 mb-1">Your Details</h3>
                <div class="text-gray-700">
                    <div><span class="font-semibold">ID:</span> <%= admin.getId() %></div>
                    <div><span class="font-semibold">Name:</span> <%= admin.getUsername() %></div>
                    <div><span class="font-semibold">Email:</span> <%= admin.getEmail() %></div>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="bg-white rounded-xl shadow-md p-6 mb-8 text-center text-red-600 font-semibold text-lg">
            You are not logged in as admin.
        </div>
        <%
            }
        %>

        <!-- Search Bar -->
        <div class="flex items-center justify-between mb-6">
            <form action="adminDashboard.jsp" method="get" class="flex w-full max-w-xl">
                <input type="text" name="search"
                    class="flex-1 px-4 py-2 rounded-l-lg border border-blue-300 focus:ring-2 focus:ring-blue-400 focus:outline-none text-gray-700"
                    placeholder="Search by Name or Email"
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit"
                    class="px-6 py-2 bg-blue-600 text-white font-semibold rounded-r-lg hover:bg-blue-700 transition">Search</button>
            </form>
        </div>

        <h3 class="text-2xl font-bold text-blue-700 mb-4">All Registered Users</h3>
        <div class="overflow-x-auto bg-white rounded-xl shadow-md">
            <table class="min-w-full divide-y divide-blue-100">
                <thead class="bg-blue-100">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-bold text-blue-700 uppercase tracking-wider">Name</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-blue-700 uppercase tracking-wider">Email</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-blue-700 uppercase tracking-wider">Role</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-blue-700 uppercase tracking-wider">Details</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-blue-700 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-blue-50">
                    <%
                        String searchQuery = request.getParameter("search");
                        String filePath = application.getRealPath("/WEB-INF/data/users.txt");

                        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                            String line;
                            boolean anyUser = false;
                            while ((line = reader.readLine()) != null) {
                                String[] parts = line.split(",", -1);
                                if(parts.length >= 5) {
                                    String username = parts[1];
                                    String email = parts[2];

                                    // Simple search functionality (case-insensitive)
                                    if (searchQuery != null && !searchQuery.isEmpty() &&
                                        !(username.toLowerCase().contains(searchQuery.toLowerCase()) ||
                                        email.toLowerCase().contains(searchQuery.toLowerCase()))) {
                                        continue;
                                    }
                                    anyUser = true;
                    %>
                    <tr class="hover:bg-blue-50 transition">
                        <td class="px-6 py-4 whitespace-nowrap text-gray-800 font-medium"><%= parts[1] %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-gray-700"><%= parts[2] %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="inline-block px-3 py-1 rounded-full text-xs font-semibold
                                <%= "Admin".equalsIgnoreCase(parts[4]) ? "bg-blue-200 text-blue-800" : "bg-green-100 text-green-700" %>">
                                <%= parts[4] %>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-normal text-gray-600">
                            <% if("Regular".equalsIgnoreCase(parts[4]) && parts.length >= 9) { %>
                                <span class="block"><span class="font-semibold">Address:</span> <%= parts[5] %>, <%= parts[6] %>, <%= parts[7] %></span>
                                <span class="block"><span class="font-semibold">Contact:</span> <%= parts[8] %></span>
                            <% } else { %>
                                <span class="italic text-blue-500">Admin User</span>
                            <% } %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <!-- Edit button removed as requested -->
                            <a href="delete-user?id=<%= parts[0] %>"
                               class="text-red-500 hover:underline font-semibold"
                               onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                        </td>
                    </tr>
                    <%
                                }
                            }
                            if (!anyUser) {
                    %>
                    <tr>
                        <td colspan="5" class="text-center py-6 text-gray-400">No users found.</td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="5" class="text-center py-6 text-red-500">Error reading users</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
