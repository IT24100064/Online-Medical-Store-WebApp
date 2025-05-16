<%@ page import="java.util.List" %>
<%@ page import="com.onlinepharmacy.model.Order" %>
<%@ page import="com.onlinepharmacy.model.Medicine" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PharmAssist Admin - Manage Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-teal-100 via-blue-100 to-indigo-100 min-h-screen p-6">
<div class="flex min-h-screen">

    <!-- Mobile Sidebar Toggle Button -->
    <div class="lg:hidden flex justify-between items-center mb-4 px-4 w-full">
        <div class="text-blue-500 font-bold text-xl">Offistant - Pharmacy Admin</div>
        <button onclick="document.getElementById('sidebar').classList.toggle('hidden')" class="text-blue-500 focus:outline-none">
            ☰
        </button>
    </div>

    <!-- Layout Wrapper -->
    <div class="flex flex-col lg:flex-row w-full">
        <!-- Sidebar -->
        <div id="sidebar" class="w-full lg:w-64 bg-white/70 backdrop-blur-lg rounded-2xl shadow-lg p-6 mb-4 lg:mb-0 lg:mr-6 lg:block hidden">
            <div class="text-blue-500 font-bold text-xl mb-8 hidden lg:block">Offistant - Pharmacy Admin</div>
            <div class="space-y-4">
                <a href="<%= request.getContextPath() %>/index.jsp" class="flex items-center text-gray-600 py-2 px-4 rounded hover:bg-blue-50 transition">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                    Dashboard
                </a>
                <a href="<%= request.getContextPath() %>/admin/orders" class="flex items-center text-blue-500 bg-blue-50 py-2 px-4 rounded font-medium transition">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                    Orders
                </a>
                <a href="<%= request.getContextPath() %>/admin/customers" class="flex items-center text-gray-600 py-2 px-4 rounded hover:bg-blue-50 transition">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 14a4 4 0 01-8 0M12 14v2a4 4 0 01-4 4h8a4 4 0 01-4-4v-2" />
                    </svg>
                    Customers
                </a>
                <a href="<%= request.getContextPath() %>/admin/reports" class="flex items-center text-gray-600 py-2 px-4 rounded hover:bg-blue-50 transition">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-6h2V9h2v2h2v6m4 0H5" />
                    </svg>
                    Reports
                </a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="flex-1">
            <div class="bg-white/80 backdrop-blur-lg rounded-2xl shadow-xl p-8">
                <h1 class="text-2xl font-semibold text-indigo-700 mb-2">Order Management</h1>
                <p class="text-gray-600 mb-6">Track and manage customer orders placed via the online pharmacy system.</p>

                <%
                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                    if (orders == null || orders.isEmpty()) {
                %>
                <div class="text-center py-20 text-gray-500 text-lg">
                    No orders found at the moment. Stay tuned!
                </div>
                <%
                } else {
                    String editableOrderId = null;
                    for (Order o : orders) {
                        String status = o.getStatus().toUpperCase();
                        if (!status.equals("COMPLETED") && !status.equals("CANCELED")) {
                            editableOrderId = o.getOrderId();
                            break;
                        }
                    }
                %>
                <div class="overflow-x-auto rounded-lg border border-gray-200">
                    <table class="w-full bg-white rounded-lg text-sm">
                        <thead class="bg-indigo-50 text-indigo-700">
                        <tr>
                            <th class="p-3 text-left">Order ID</th>
                            <th class="p-3 text-left">Customer</th>
                            <th class="p-3 text-left">Contact</th>
                            <th class="p-3 text-left">Age</th>
                            <th class="p-3 text-left">Medicines</th>
                            <th class="p-3 text-left">Status</th>
                            <th class="p-3 text-left">Date</th>
                            <th class="p-3 text-left">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                        <%
                            for (Order order : orders) {
                        %>
                        <tr class="hover:bg-gray-50 transition">
                            <td class="p-3 font-medium text-gray-700"><%= order.getOrderId() %></td>
                            <td class="p-3 flex items-center gap-2">
                                <div class="bg-indigo-100 h-8 w-8 rounded-full flex items-center justify-center text-indigo-700 font-bold">
                                    <%= order.getCustomerName().substring(0, 1).toUpperCase() %>
                                </div>
                                <span class="text-gray-700"><%= order.getCustomerName() %></span>
                            </td>
                            <td class="p-3 text-gray-600"><%= order.getContact() %></td>
                            <td class="p-3 text-gray-600"><%= order.getAge() %></td>
                            <td class="p-3 text-gray-700">
                                <%
                                    for (Medicine med : order.getMedicines()) {
                                %>
                                <span class="inline-block bg-blue-50 text-blue-700 px-2 py-1 rounded-full text-xs font-semibold mr-1 mb-1">
                                            <%= med.getName() %> (x<%= med.getQuantity() %>)
                                        </span>
                                <%
                                    }
                                %>
                            </td>
                            <td class="p-3">
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold
                                            <% if ("COMPLETED".equalsIgnoreCase(order.getStatus())) { %>bg-green-100 text-green-700
                                            <% } else if ("CANCELED".equalsIgnoreCase(order.getStatus())) { %>bg-red-100 text-red-700
                                            <% } else if ("PROCESSING".equalsIgnoreCase(order.getStatus()) || "CONFIRMED".equalsIgnoreCase(order.getStatus())) { %>bg-yellow-100 text-yellow-700
                                            <% } else if ("OUTFORDELIVERY".equalsIgnoreCase(order.getStatus()) || "HANDOVER".equalsIgnoreCase(order.getStatus())) { %>bg-purple-100 text-purple-700
                                            <% } else { %>bg-gray-100 text-gray-600
                                            <% } %>">
                                            <%= order.getStatus() %>
                                        </span>
                            </td>
                            <td class="p-3 text-gray-600"><%= order.getOrderDate() %></td>
                            <td class="p-3 space-y-2">
                                <% if (order.getOrderId().equals(editableOrderId)) { %>
                                <form action="<%= request.getContextPath() %>/admin/orders" method="post" class="flex items-center gap-1">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <select name="status" class="border rounded-l px-2 py-1 text-sm">
                                        <option value="PENDING" <%= "PENDING".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Pending</option>
                                        <option value="CONFIRMED" <%= "CONFIRMED".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                        <option value="PROCESSING" <%= "PROCESSING".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Processing</option>
                                        <option value="HANDOVER" <%= "HANDOVER".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Handover</option>
                                        <option value="OUTFORDELIVERY" <%= "OUTFORDELIVERY".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Out For Delivery</option>
                                        <option value="COMPLETED" <%= "COMPLETED".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Completed</option>
                                        <option value="CANCELED" <%= "CANCELED".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Canceled</option>
                                    </select>
                                    <button type="submit" class="bg-blue-500 text-white px-2 py-1 text-sm rounded-r hover:bg-blue-600">Update</button>
                                </form>
                                <% } else { %>
                                <span class="text-gray-400 text-xs">Read-only</span>
                                <% } %>
                                <form action="<%= request.getContextPath() %>/admin/orders" method="post" onsubmit="return confirm('Delete this order?');">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="bg-red-500 text-white px-2 py-1 text-xs rounded hover:bg-red-600">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<!-- Floating Action Button -->
<div class="fixed bottom-6 right-6 group">
    <button title="Add New Order"
            class="w-14 h-14 rounded-full bg-indigo-600 text-white shadow-xl flex items-center justify-center hover:bg-indigo-700 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 group-hover:scale-110 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
        </svg>
    </button>
</div>
</body>
</html>
