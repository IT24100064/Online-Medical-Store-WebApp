<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Welcome | Online Pharmacy</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body {
      background: linear-gradient(to right, #eef2ff, #dbeafe);
      font-family: 'Inter', sans-serif;
    }
    .glass {
      background: rgba(255, 255, 255, 0.75);
      backdrop-filter: blur(20px) saturate(160%);
      -webkit-backdrop-filter: blur(20px) saturate(160%);
      border-radius: 1.5rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .glass:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 36px rgba(0, 0, 0, 0.08);
    }
    .nav-btn:hover {
      transform: scale(1.05);
      box-shadow: 0 6px 20px rgba(99, 102, 241, 0.3);
    }
  </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

  <!-- Header -->
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

  <!-- Hero Section -->
  <main class="w-full mt-16 px-4 flex flex-col items-center">
    <div class="text-center max-w-2xl">
      <span class="inline-flex items-center gap-2 bg-green-100 text-green-700 px-4 py-1 rounded-full text-sm font-medium mb-3">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path d="M5 13l4 4L19 7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        Trusted by 5,000+ users
      </span>
      <h2 class="text-5xl font-extrabold text-indigo-900 leading-tight mb-4">Welcome to Online Pharmacy</h2>
      <p class="text-lg text-gray-600 mb-6">Your trusted place for safe, fast, and reliable medicine delivery. Start your order or access admin controls below.</p>
      <a href="placeOrder.jsp" class="bg-indigo-600 hover:bg-indigo-700 text-white text-lg font-semibold px-8 py-3 rounded-full shadow-lg transition">Get Started</a>
    </div>

    <!-- Features Section -->
    <section class="w-full max-w-6xl mt-20 grid gap-8 grid-cols-1 md:grid-cols-3">
      <!-- Card 1 -->
      <div class="glass p-6 flex flex-col justify-between">
        <div>
          <span class="bg-purple-100 text-purple-700 text-xs px-3 py-1 rounded-full font-semibold inline-block mb-3">Order Medicine</span>
          <h3 class="text-lg font-bold text-indigo-700 mb-2">Easy Online Ordering</h3>
          <p class="text-gray-600 text-sm">Browse and place your orders from anywhere at any time, securely and conveniently.</p>
        </div>
        <a href="placeOrder.jsp" class="mt-4 bg-indigo-100 hover:bg-indigo-200 text-indigo-700 font-medium px-4 py-2 rounded-lg transition self-start">Place Order</a>
      </div>

      <!-- Card 2 -->
      <div class="glass p-6 text-center flex flex-col items-center">
        <img src="https://img.icons8.com/color/96/000000/pill.png" alt="Pharmacy" class="w-20 h-20 mb-4" />
        <h3 class="text-lg font-bold text-indigo-700 mb-2">Your Health, Our Priority</h3>
        <p class="text-gray-600 text-sm">Fast delivery of genuine medicines right to your doorstep. Safety and care guaranteed.</p>
      </div>

      <!-- Card 3 -->
      <div class="glass p-6 flex flex-col justify-between items-end">
        <div class="w-full text-right">
          <span class="bg-blue-100 text-blue-700 text-xs px-3 py-1 rounded-full font-semibold mb-3 inline-block">Admin</span>
          <h3 class="text-lg font-bold text-indigo-700 mb-2">Admin Panel</h3>
          <p class="text-gray-600 text-sm">Manage orders, track users, and review performance from the secure dashboard.</p>
        </div>
        <a href="admin/orders" class="mt-4 bg-indigo-600 hover:bg-indigo-700 text-white font-medium px-4 py-2 rounded-lg transition">Admin Panel</a>
      </div>
    </section>
  </main>
  <br>
  <br>
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
