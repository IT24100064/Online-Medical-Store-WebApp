<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Medicine Review</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
      /* Glassmorphism effect */
      .glass {
        background: rgba(255, 255, 255, 0.7);
        box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.18);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border-radius: 2rem;
        border: 1px solid rgba(255, 255, 255, 0.25);
      }
      /* Star animation */
      .star-rating label {
        transition: transform 0.2s, color 0.2s;
      }
      .star-rating label:hover,
      .star-rating label:hover ~ label,
      .star-rating input:focus + label,
      .star-rating input:checked ~ label {
        color: #f59e42 !important;
        transform: scale(1.15) rotate(-6deg);
        text-shadow: 0 2px 8px #fbbf24aa;
      }
      /* Animated button */
      .btn-animated {
        position: relative;
        overflow: hidden;
        transition: background 0.3s;
      }
      .btn-animated:before {
        content: '';
        position: absolute;
        left: -50%;
        top: 0;
        width: 200%;
        height: 100%;
        background: linear-gradient(90deg, #60a5fa33 0%, #2563eb33 100%);
        transform: skewX(-20deg);
        transition: left 0.3s;
        z-index: 0;
      }
      .btn-animated:hover:before {
        left: 0;
      }
      .btn-animated span {
        position: relative;
        z-index: 1;
      }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
  <header class="w-full py-6 px-8 flex justify-between items-center bg-white shadow">
    <div>
      <span class="text-xl font-semibold tracking-widest text-gray-700">PHARMACARE</span>
    </div>
    <nav class="space-x-8 text-sm">
      <a href="#" class="text-gray-700 hover:text-blue-700">Shop</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">About</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">Blog</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">Contact</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">
        <svg xmlns="http://www.w3.org/2000/svg" class="inline h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18M9 3v18M15 3v18"/>
        </svg>
      </a>
    </nav>
  </header>
  <main class="bg-gradient-to-br from-blue-100 via-blue-50 to-white min-h-screen flex items-center justify-center py-12 px-4">
<!-- Header -->
    <!-- Decorative floating blobs -->
    <div class="fixed top-0 left-0 w-56 h-56 bg-gradient-to-br from-blue-400 to-blue-100 opacity-30 rounded-full blur-3xl z-0 animate-pulse"></div>
    <div class="fixed bottom-0 right-0 w-40 h-40 bg-gradient-to-br from-indigo-200 to-blue-50 opacity-30 rounded-full blur-2xl z-0 animate-pulse"></div>

    <div class="glass max-w-2xl w-full p-10 relative shadow-2xl z-10">
        <!-- Sparkle icon -->
        <div class="absolute -top-10 left-1/2 -translate-x-1/2 flex items-center justify-center">
            <svg class="w-16 h-16 text-blue-400 drop-shadow-lg animate-bounce" fill="none" viewBox="0 0 64 64">
                <circle cx="32" cy="32" r="28" fill="#3b82f6" opacity="0.15"/>
                <path d="M32 12l4 12h12l-10 8 4 12-10-8-10 8 4-12-10-8h12z" fill="#3b82f6"/>
            </svg>
        </div>
        <h1 class="text-4xl font-extrabold text-blue-700 mb-8 text-center z-10 relative tracking-tight drop-shadow">Share Your Experience</h1>

        <c:if test="${not empty errors}">
            <div class="mb-6 bg-red-100 border border-red-300 text-red-700 rounded-lg p-4 z-10 relative animate-shake">
                <ul class="list-disc list-inside space-y-1">
                    <c:forEach items="${errors}" var="error">
                        <li>${error.value}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/submitReview" method="post" class="space-y-7 z-10 relative">
            <div>
                <label for="medicineName" class="block text-gray-700 font-semibold mb-1">Medicine Name</label>
                <input type="text" id="medicineName" name="medicineName" required minlength="2" maxlength="100"
                       value="${param.medicineName}"
                       class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-300 focus:border-blue-400 transition shadow-sm bg-white/80" />
                <c:if test="${not empty errors.medicineName}">
                    <span class="text-red-600 text-sm mt-1 block">${errors.medicineName}</span>
                </c:if>
            </div>

            <div>
                <label for="customerName" class="block text-gray-700 font-semibold mb-1">Your Name</label>
                <input type="text" id="customerName" name="customerName" required minlength="2" maxlength="50"
                       value="${param.customerName}"
                       class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-300 focus:border-blue-400 transition shadow-sm bg-white/80" />
                <c:if test="${not empty errors.customerName}">
                    <span class="text-red-600 text-sm mt-1 block">${errors.customerName}</span>
                </c:if>
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-1">Rating</label>
                <div class="star-rating flex flex-row-reverse justify-center items-center text-4xl space-x-reverse space-x-2 mb-1 select-none">
                    <c:forEach var="i" begin="1" end="5" step="1">
                        <input type="radio" id="star${i}" name="rating" value="${i}" class="hidden peer"
                          <c:if test="${param.rating == i}">checked</c:if> required />
                        <label for="star${i}" class="cursor-pointer text-gray-300 peer-checked:text-yellow-400 hover:text-yellow-500 transition">&#9733;</label>
                    </c:forEach>
                </div>
                <c:if test="${not empty errors.rating}">
                    <span class="text-red-600 text-sm mt-1 block">${errors.rating}</span>
                </c:if>
            </div>

            <div>
                <label for="comment" class="block text-gray-700 font-semibold mb-1">Comment</label>
                <textarea id="comment" name="comment" required minlength="5" maxlength="500"
                          class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-300 focus:border-blue-400 resize-y transition shadow-sm bg-white/80" rows="4">${param.comment}</textarea>
                <c:if test="${not empty errors.comment}">
                    <span class="text-red-600 text-sm mt-1 block">${errors.comment}</span>
                </c:if>
            </div>

            <div>
                <label for="orderId" class="block text-gray-700 font-semibold mb-1">Order ID <span class="text-gray-400 text-xs">(optional)</span></label>
                <input type="text" id="orderId" name="orderId" pattern="[A-Za-z0-9\\-]{0,20}" maxlength="20"
                       value="${param.orderId}"
                       class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-300 focus:border-blue-400 transition shadow-sm bg-white/80" />
                <c:if test="${not empty errors.orderId}">
                    <span class="text-red-600 text-sm mt-1 block">${errors.orderId}</span>
                </c:if>
            </div>

            <div class="text-center">
                <button type="submit" class="btn-animated bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-10 rounded-xl shadow-lg transition duration-200 text-lg tracking-wide">
                    <span>✨ Submit Review</span>
                </button>
            </div>
        </form>

        <div class="mt-8 text-center z-10 relative">
            <a href="viewReviews" class="inline-block text-blue-600 hover:text-blue-800 hover:underline font-semibold transition duration-150 px-4 py-2 rounded-lg bg-blue-50 hover:bg-blue-100 shadow-sm">
                👀 View All Reviews
            </a>
        </div>
    </div>
    </main>
       <!-- Footer -->
  <footer class="bg-blue-600 text-white pt-10">
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