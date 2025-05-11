<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>PharmaCare Dashboard</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- ApexCharts for beautiful graphs -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen">
    <div class="flex min-h-screen">
        <!-- Sidebar Navigation -->
        <aside class="bg-blue-800 text-white w-64 flex flex-col py-8 px-4">
            <div class="mb-10 text-2xl font-bold tracking-wide text-center">PharmaCare Admin</div>
            <nav class="flex-1 space-y-2">
                <a href="dashboard.jsp" class="block py-2 px-4 rounded hover:bg-blue-700 bg-blue-700 font-semibold">Dashboard</a>
                <a href="addMedicine.jsp" class="block py-2 px-4 rounded hover:bg-blue-700">Add Medicine</a>
                <a href="viewMedicines" class="block py-2 px-4 rounded hover:bg-blue-700">Inventory</a>
            </nav>
            <div class="mt-auto text-sm text-blue-200 text-center">
                &copy; 2025 PharmaCare
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 p-8">
            <!-- Header -->
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-3xl font-extrabold text-blue-800">Inventory Overview</h1>
                <div class="flex gap-4">
                    <a href="addMedicine.jsp" class="bg-blue-700 text-white px-6 py-2 rounded-lg shadow hover:bg-blue-800 font-bold transition flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/>
                        </svg>
                        New Medicine
                    </a>
                </div>
            </div>

            <!-- Key Metrics Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-lg p-6 flex items-center gap-4 hover:shadow-xl transition">
                    <div class="p-4 bg-blue-100 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
                        </svg>
                    </div>
                    <div>
                        <div class="text-2xl font-bold text-gray-800">${totalProducts}</div>
                        <div class="text-gray-600">Total Products</div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6 flex items-center gap-4 hover:shadow-xl transition">
                    <div class="p-4 bg-green-100 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z"/>
                        </svg>
                    </div>
                    <div>
                        <div class="text-2xl font-bold text-gray-800">${totalCategories}</div>
                        <div class="text-gray-600">Categories</div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6 flex items-center gap-4 hover:shadow-xl transition">
                    <div class="p-4 bg-red-100 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <div>
                        <div class="text-2xl font-bold text-gray-800">${outOfStock}</div>
                        <div class="text-gray-600">Out of Stock</div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6 flex items-center gap-4 hover:shadow-xl transition">
                    <div class="p-4 bg-purple-100 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-purple-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                    <div>
                        <div class="text-2xl font-bold text-gray-800">Rs${totalValue}</div>
                        <div class="text-gray-600">Total Inventory Value</div>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-lg font-semibold mb-4">Sales Trends</h3>
                    <div id="salesChart"></div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-lg font-semibold mb-4">Category Distribution</h3>
                    <div id="categoryChart"></div>
                </div>
            </div>

            <!-- Quick Actions & Recent Activity -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-lg font-semibold mb-4">Quick Actions</h3>
                    <div class="space-y-3">
                        <a href="#" class="flex items-center gap-3 p-3 hover:bg-blue-50 rounded-lg transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"/>
                            </svg>
                            Generate Inventory Report
                        </a>
                        <!-- Add more quick actions -->
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6 lg:col-span-2">
                    <h3 class="text-lg font-semibold mb-4">Recent Activity</h3>
                    <div class="space-y-4">
                        <div class="flex items-center gap-4 p-3 bg-blue-50 rounded-lg">
                            <div class="h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-600" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                                    <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div>
                                <div class="font-medium">New medicine added</div>
                                <div class="text-sm text-gray-500">Paracetamol 500mg</div>
                            </div>
                        </div>
                        <!-- Add more activity items -->
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Sample ApexCharts configuration
        const salesChart = new ApexCharts(document.querySelector("#salesChart"), {
            series: [{
                name: 'Sales',
                data: [30, 40, 35, 50, 49, 60, 70]
            }],
            chart: { type: 'line', height: 300 },
            colors: ['#3B82F6'],
            xaxis: { categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'] }
        }).render();

        const categoryChart = new ApexCharts(document.querySelector("#categoryChart"), {
            series: [44, 55, 13, 43],
            labels: ['Generic', 'Branded', 'OTC', 'Prescription'],
            chart: { type: 'pie', height: 300 },
            colors: ['#3B82F6', '#10B981', '#F59E0B', '#8B5CF6']
        }).render();
    </script>
</body>
</html>
