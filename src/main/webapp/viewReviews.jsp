<%@ page import="java.util.*, com.onlinepharmacy.model.Review" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Reviews</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
      .star {
        color: #fbbf24;
        font-size: 1.25rem;
        margin-right: 2px;
      }
      .star-empty {
        color: #e5e7eb;
        font-size: 1.25rem;
        margin-right: 2px;
      }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100 min-h-screen flex flex-col">

 <!-- Header -->
  <header class="w-full py-6 px-8 flex justify-between items-center bg-white shadow">
    <div>
      <span class="text-2xl font-extrabold tracking-widest text-blue-700">PHARMACARE</span>
    </div>
    <nav class="space-x-8 text-sm">
      <a href="#" class="text-gray-700 hover:text-blue-700 transition">Shop</a>
      <a href="#" class="text-gray-700 hover:text-blue-700 transition">About</a>
      <a href="#" class="text-gray-700 hover:text-blue-700 transition">Blog</a>
      <a href="#" class="text-gray-700 hover:text-blue-700 transition">Contact</a>
    </nav>
  </header>
  <main class="bg-gradient-to-br from-blue-50 to-white min-h-screen py-10 px-4">
    <div class="max-w-3xl mx-auto">
        <h1 class="text-4xl font-extrabold text-blue-700 mb-6 text-center">Approved Reviews</h1>
        <%
            List<Review> reviews = (List<Review>) request.getAttribute("reviews");
            int[] ratingCounts = new int[5]; // Index 0 for 1 star, ..., 4 for 5 stars
            int totalReviews = 0;
            double avgRating = 0.0;

            if (reviews != null && !reviews.isEmpty()) {
                for (Review review : reviews) {
                    int r = review.getRating();
                    if (r >= 1 && r <= 5) {
                        ratingCounts[r - 1]++;
                        avgRating += r;
                        totalReviews++;
                    }
                }
                if (totalReviews > 0) avgRating /= totalReviews;
            }
        %>

        <!-- Rating Bar Summary -->
        <div class="bg-white rounded-2xl shadow-lg p-6 mb-10">
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center">
                    <span class="text-2xl font-bold text-yellow-500 mr-2">
                        <%= totalReviews > 0 ? String.format("%.1f", avgRating) : "-" %>
                    </span>
                    <span>
                        <% for (int i = 1; i <= 5; i++) { %>
                            <span class="<%= avgRating >= i ? "star" : "star-empty" %>">&#9733;</span>
                        <% } %>
                    </span>
                    <span class="ml-3 text-gray-500 text-sm">
                        (<%= totalReviews %> reviews)
                    </span>
                </div>
            </div>
            <div>
                <% for (int i = 5; i >= 1; i--) {
                    int count = ratingCounts[i - 1];
                    double percent = totalReviews > 0 ? (count * 100.0 / totalReviews) : 0;
                %>
                <div class="flex items-center mb-2">
                    <span class="w-10 text-sm text-gray-600 font-medium"><%= i %> <span class="text-yellow-400">&#9733;</span></span>
                    <div class="flex-1 mx-2 h-3 rounded bg-gray-200 overflow-hidden">
                        <div class="h-3 rounded bg-yellow-400 transition-all" style="width:<%= percent %>%"></div>
                    </div>
                    <span class="w-8 text-right text-gray-500 text-xs"><%= count %></span>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Reviews List -->
        <div class="space-y-6">
        <%
            if (reviews == null || reviews.isEmpty()) {
        %>
            <div class="text-center text-gray-500">No approved reviews yet.</div>
        <%
            } else {
                for (Review review : reviews) {
        %>
            <div class="bg-white rounded-2xl shadow-lg p-6 relative">
                <div class="flex items-center mb-2">
                    <span class="text-lg font-bold text-blue-700 mr-2"><%= review.getMedicineName() %></span>
                    <!-- Star display -->
                    <span>
                        <% for (int s = 1; s <= 5; s++) { %>
                            <span class="<%= review.getRating() >= s ? "star" : "star-empty" %>">&#9733;</span>
                        <% } %>
                    </span>
                    <span class="ml-2 text-gray-400 text-xs"><%= review.getRating() %> / 5</span>
                </div>
                <div class="text-gray-700 italic mb-3">
                    “<%= review.getComment() %>”
                </div>
                <div class="flex space-x-3">
                    <!-- Edit button -->
                    <form action="editReview.jsp" method="get">
                        <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                        <input type="hidden" name="medicineName" value="<%= review.getMedicineName() %>">
                        <input type="hidden" name="rating" value="<%= review.getRating() %>">
                        <input type="hidden" name="comment" value="<%= review.getComment() %>">
                        <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white px-4 py-1 rounded-lg font-semibold shadow transition">Edit</button>
                    </form>
                    <!-- Delete button -->
                    <form action="deleteReview" method="post" onsubmit="return confirm('Are you sure you want to delete this review?')">
                        <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                        <button type="submit" class="bg-red-500 hover:bg-red-700 text-white px-4 py-1 rounded-lg font-semibold shadow transition">Delete</button>
                    </form>
                </div>
            </div>
        <%
                }
            }
        %>
        </div>

        <div class="mt-10 text-center">
            <a href="index.jsp" class="inline-block bg-blue-100 hover:bg-blue-200 text-blue-700 font-semibold px-6 py-2 rounded-xl shadow transition">Back to Home</a>
        </div>
    </div>
    </main>
     <!-- Footer -->
  <footer class="bg-blue-700 text-white pt-10 mt-10 rounded-t-3xl shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8 pb-8">
        <!-- Information -->
        <div>
          <h3 class="text-lg font-bold mb-4">Information</h3>
          <ul class="space-y-2">
            <li><a href="#" class="hover:underline">About Us</a></li>
            <li><a href="#" class="hover:underline">Delivery</a></li>
            <li><a href="#" class="hover:underline">Privacy Policy</a></li>
            <li><a href="#" class="hover:underline">Terms &amp; Conditions</a></li>
            <li><a href="#" class="hover:underline">App Deletion</a></li>
          </ul>
        </div>
        <!-- Marketplace -->
        <div>
          <h3 class="text-lg font-bold mb-4">Marketplace</h3>
          <ul class="space-y-2">
            <li><a href="#" class="hover:underline">Partner Pharmacies</a></li>
            <li><a href="#" class="hover:underline">Seller Login</a></li>
          </ul>
        </div>
        <!-- Reach Us -->
        <div>
          <h3 class="text-lg font-bold mb-4">Reach Us</h3>
          <ul class="space-y-2">
            <li><a href="#" class="hover:underline">Contact Us</a></li>
            <li><a href="#" class="hover:underline">Site Map</a></li>
            <li><a href="#" class="hover:underline">Brands</a></li>
          </ul>
        </div>
        <!-- Newsletter -->
        <div>
          <h3 class="text-lg font-bold mb-4">Newsletter</h3>
          <p class="mb-3 text-sm">Don't miss any updates or promotions by signing up to our newsletter.</p>
          <form class="flex mb-2">
            <input type="email" placeholder="Your email" class="w-full px-3 py-2 rounded-l bg-white text-gray-700 focus:outline-none" />
            <button type="submit" class="bg-blue-800 px-4 py-2 rounded-r text-white font-semibold hover:bg-blue-900">SEND</button>
          </form>
          <div class="flex items-center mb-2">
            <input type="checkbox" id="policy" class="mr-2 accent-blue-800" />
            <label for="policy" class="text-xs">I have read and agree to the <a href="#" class="underline">Privacy Policy</a></label>
          </div>
          <div class="mt-3">
            <span class="font-semibold">Follow us:</span>
            <div class="flex space-x-3 mt-2">
              <!-- Social Icons -->
              <a href="#" class="text-blue-300 hover:text-white">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 4.6c-.9.4-1.9.7-2.9.8a5.1 5.1 0 0 0 2.2-2.8c-1 .6-2 .9-3.1 1.2A5.1 5.1 0 0 0 16.7 3c-2.8 0-5.1 2.3-5.1 5.1 0 .4 0 .8.1 1.2C7.7 9.1 4.1 7.3 1.7 4.6c-.4.7-.6 1.6-.6 2.5 0 1.8.9 3.3 2.2 4.2-.8 0-1.5-.2-2.2-.6v.1c0 2.5 1.8 4.5 4.2 5-.4.1-.8.2-1.2.2-.3 0-.6 0-.9-.1.6 1.9 2.4 3.3 4.5 3.3A10.3 10.3 0 0 1 0 21.5c2.3 1.5 5.1 2.4 8.1 2.4 9.7 0 15-8 15-15v-.7c1-.7 1.9-1.6 2.6-2.6z"/>
                </svg>
              </a>
              <a href="#" class="text-blue-300 hover:text-white">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 2.2c3.2 0 3.6 0 4.9.1 1.2.1 2 .2 2.5.4.6.2 1 .5 1.4 1 .4.4.7.8 1 1.4.2.5.3 1.3.4 2.5.1 1.3.1 1.7.1 4.9s0 3.6-.1 4.9c-.1 1.2-.2 2-.4 2.5-.2.6-.5 1-1 1.4-.4.4-.8.7-1.4 1-.5.2-1.3.3-2.5.4-1.3.1-1.7.1-4.9.1s-3.6 0-4.9-.1c-1.2-.1-2-.2-2.5-.4-.6-.2-1-.5-1.4-1-.4-.4-.7-.8-1-1.4-.2-.5-.3-1.3-.4-2.5C2.2 15.6 2.2 15.2 2.2 12s0-3.6.1-4.9c.1-1.2.2-2 .4-2.5.2-.6.5-1 1-1.4.4-.4.8-.7 1.4-1 .5-.2 1.3-.3 2.5-.4C8.4 2.2 8.8 2.2 12 2.2z"/>
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </footer>
</body>
</html>