<%@ page import="java.io.*, java.util.*, com.onlinepharmacy.model.Review" %>

<%
    String filePath = application.getRealPath("/WEB-INF/data/reviews.txt");
    List<Review> reviews = new ArrayList<>();

    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        while ((line = reader.readLine()) != null) {
            Review review = Review.fromCSVString(line);
            if (review != null) {
                reviews.add(review);
            }
        }
    } catch (Exception e) {
        out.println("<p class='text-red-500 font-semibold'>Error loading reviews.</p>");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Review Moderation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(120deg, #e0f2fe 0%, #f0f9ff 100%);
        }
        .glass {
            background: rgba(255,255,255,0.75);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .sidebar-glass {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }
    </style>
</head>
<body class="min-h-screen flex bg-sky-50">

    <!-- Sidebar -->
    <aside class="sidebar-glass w-64 min-h-screen px-6 py-8 flex flex-col shadow-xl">
        <div class="mb-10">
            <h1 class="text-3xl font-bold text-blue-800">PharmaAdmin</h1>
            <p class="text-sm text-blue-500">Moderation Panel</p>
        </div>
        <nav class="flex-1 space-y-2 text-blue-600">
            <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-100 transition font-semibold bg-blue-50">
                <svg class="w-5 h-5 mr-3 text-blue-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M19 11H5M19 11a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
                </svg>
                Reviews
            </a>
            <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-100 transition">
                <svg class="w-5 h-5 mr-3 text-blue-300" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <circle cx="12" cy="7" r="4"/><path d="M5.5 21a7.5 7.5 0 0113 0"/>
                </svg>
                Users
            </a>
            <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-100 transition">
                <svg class="w-5 h-5 mr-3 text-blue-300" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M12 8v4l3 3"/>
                    <circle cx="12" cy="12" r="10"/>
                </svg>
                Settings
            </a>
        </nav>
        <div class="mt-10 flex items-center gap-3 p-3 rounded-lg bg-blue-50">
            <img src="https://randomuser.me/api/portraits/men/32.jpg" class="w-10 h-10 rounded-full border-2 border-blue-200" alt="Admin"/>
            <div>
                <div class="font-semibold text-blue-700 text-sm">Admin Name</div>
                <div class="text-xs text-blue-400">View profile</div>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 px-8 py-8">
        <div class="max-w-6xl mx-auto">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold text-blue-800">Review Moderation</h1>
                <div class="bg-blue-100 text-blue-700 px-4 py-2 rounded-full font-medium text-sm shadow">
                    Total Reviews: <%= reviews.size() %>
                </div>
            </div>
            <div class="glass p-6 overflow-x-auto">
                <table class="min-w-full text-sm text-left">
                    <thead>
                        <tr class="bg-blue-100 text-blue-800 uppercase text-xs">
                            <th class="px-4 py-3">ID</th>
                            <th class="px-4 py-3">Medicine</th>
                            <th class="px-4 py-3">Customer</th>
                            <th class="px-4 py-3 text-center">Rating</th>
                            <th class="px-4 py-3">Comment</th>
                            <th class="px-4 py-3 text-center">Status</th>
                            <th class="px-4 py-3 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Review review : reviews) { %>
                        <tr class="border-b hover:bg-blue-50 transition">
                            <td class="px-4 py-3 font-semibold text-blue-500"><%= review.getReviewId() %></td>
                            <td class="px-4 py-3 text-blue-900"><%= review.getMedicineName() %></td>
                            <td class="px-4 py-3 text-blue-800"><%= review.getCustomerName() %></td>
                            <td class="px-4 py-3 text-center">
                                <span class="bg-blue-200 text-blue-900 font-semibold px-3 py-1 rounded-lg shadow"><%= review.getRating() %></span>
                            </td>
                            <td class="px-4 py-3 text-blue-700 max-w-md truncate"><%= review.getComment() %></td>
                            <td class="px-4 py-3 text-center">
                                <span class="px-3 py-1 rounded-full text-xs font-bold
                                    <%= "approved".equalsIgnoreCase(review.getStatus()) ? "bg-green-100 text-green-700" :
                                        "rejected".equalsIgnoreCase(review.getStatus()) ? "bg-red-100 text-red-700" :
                                        "bg-yellow-100 text-yellow-700" %>">
                                    <%= review.getStatus() %>
                                </span>
                            </td>
                            <td class="px-4 py-3 text-center">
                                <form action="moderateReview" method="post" class="inline-flex space-x-2">
                                    <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                                    <button type="submit" name="action" value="approve"
                                        class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded-lg text-xs font-semibold transition shadow">
                                        Approve
                                    </button>
                                    <button type="submit" name="action" value="reject"
                                        class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg text-xs font-semibold transition shadow">
                                        Reject
                                    </button>
                                    <button type="submit" name="action" value="delete"
                                        class="bg-gray-200 hover:bg-gray-300 text-blue-700 px-3 py-1 rounded-lg text-xs font-semibold transition shadow">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

        <div class="mt-10 text-center">
            <a href="index.jsp" class="inline-block bg-blue-100 hover:bg-blue-200 text-blue-700 font-semibold px-6 py-2 rounded-xl shadow transition">Back to Home</a>
        </div>
            </div>
        </div>
    </main>
</body>
</html>