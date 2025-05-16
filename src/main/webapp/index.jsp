<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>What Our Customers Say - Online Pharmacy</title>
    <script src="https://cdn.tailwindcss.com"></script>
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

  <!-- Main Container -->
  <main class="flex-1 flex items-center justify-center py-12 relative">
    <div class="bg-white rounded-3xl shadow-2xl max-w-5xl w-full flex p-12 relative overflow-hidden">
      <!-- Decorative Gradient Blobs -->
      <div class="absolute -top-8 -left-8 w-44 h-44 bg-gradient-to-br from-blue-400 to-blue-200 opacity-20 rounded-full blur-2xl z-0"></div>
      <div class="absolute -bottom-10 -right-10 w-60 h-60 bg-gradient-to-br from-blue-300 to-pink-200 opacity-20 rounded-full blur-3xl z-0"></div>

      <!-- Left Section -->
      <div class="w-1/2 flex flex-col justify-center pr-8 z-10">
        <h2 class="text-4xl font-extrabold mb-4 text-blue-700 drop-shadow">What Our<br>Customers Say</h2>
        <p class="text-gray-500 mb-8 text-lg">
          We provide the best medicines for your health and wellness.<br>
          Your feedback and reviews help us improve our pharmacy services!
        </p>
        <div class="flex space-x-4">
          <button onclick="location.href='viewReviews';"
                  class="bg-gradient-to-r from-pink-500 to-orange-400 text-white px-6 py-2 rounded-lg font-semibold shadow hover:from-pink-600 hover:to-orange-500 transition">
            View More
          </button>
          <button onclick="location.href='submitReview.jsp';"
                  class="bg-gradient-to-r from-green-500 to-blue-400 text-white px-6 py-2 rounded-lg font-semibold shadow hover:from-green-600 hover:to-blue-500 transition">
            Add Review
          </button>
        </div>
      </div>

      <!-- Right Section: Reviews -->
      <div class="w-1/2 flex flex-col space-y-6 z-10">
        <!-- Review Card 1 -->
        <div class="flex items-center bg-gradient-to-r from-blue-50 to-blue-100 rounded-xl shadow-md p-5 gap-4">
          <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Pasindu Mendis"
               class="w-14 h-14 rounded-full border-2 border-blue-300 shadow">
          <div>
            <div class="font-semibold text-blue-700">Pasindu Mendis</div>
            <div class="text-gray-500 text-sm">
              Paracetamol was excellent for my headaches. Fast delivery and genuine medicine!
            </div>
          </div>
          <span class="ml-auto text-blue-300 text-3xl">&rdquo;</span>
        </div>
        <!-- Review Card 2 (Highlighted) -->
        <div class="flex items-center bg-white border-l-4 border-blue-500 rounded-xl shadow-lg p-5 gap-4 relative">
          <img src="https://randomuser.me/api/portraits/men/65.jpg" alt="Malith Dinujaya"
               class="w-14 h-14 rounded-full border-2 border-blue-300 shadow">
          <div>
            <div class="font-semibold text-blue-700">Malith Dinujaya</div>
            <div class="text-gray-500 text-sm">
              Aspirin helped but had some side effects. Customer support was responsive and helpful.
            </div>
          </div>
          <span class="ml-auto text-blue-400 text-3xl">&rdquo;&rdquo;</span>
          <span class="absolute left-0 top-0 h-full w-1 bg-blue-500 rounded-l"></span>
        </div>
        <!-- Review Card 3 -->
        <div class="flex items-center bg-gradient-to-r from-blue-50 to-blue-100 rounded-xl shadow-md p-5 gap-4">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Anushka Kumari"
               class="w-14 h-14 rounded-full border-2 border-blue-300 shadow">
          <div>
            <div class="font-semibold text-blue-700">Anushka Kumari</div>
            <div class="text-gray-500 text-sm">
              Great selection of medicines and easy ordering process. Will order again!
            </div>
          </div>
          <span class="ml-auto text-blue-300 text-3xl">&rdquo;</span>
        </div>
      </div>


    </div>
    <!-- Floating Admin Panel Button -->
      <a href="adminPanel.jsp"
         class="fixed md:absolute bottom-10 right-10 z-20 flex items-center gap-2 bg-gradient-to-r from-blue-600 to-blue-400 hover:from-blue-700 hover:to-blue-500 text-white font-bold px-6 py-3 rounded-2xl shadow-xl transition-all duration-200 ring-2 ring-white ring-opacity-40 focus:outline-none focus:ring-4 focus:ring-blue-300">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M3 13h2v-2H3v2zm0 4h2v-2H3v2zm0-8h2V7H3v2zm4 4h14v-2H7v2zm0 4h14v-2H7v2zm0-8v2h14V7H7z"/>
        </svg>
        Admin Panel
      </a>
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