<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>PharmaCare - Online Pharmacy System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-100 via-white to-blue-200 min-h-screen flex flex-col">

  <!-- Header with Login/Register -->
  <header class="flex items-center justify-between px-10 py-6 bg-white/80 shadow-md rounded-b-3xl">
    <div class="flex items-center gap-4">
      <img src="https://img.icons8.com/color/48/000000/pill.png" alt="PharmaCare Logo" class="w-10 h-10">
      <span class="text-2xl font-bold text-blue-700 tracking-wide">PharmaCare</span>
    </div>
    <div class="flex gap-3">
      <a href="register.jsp" class="bg-blue-600 text-white px-5 py-2 rounded-full font-semibold shadow hover:bg-blue-700 transition">
        Join Now &rarr;
      </a>
      <a href="login.jsp" class="bg-green-600 text-white px-5 py-2 rounded-full font-semibold shadow hover:bg-green-700 transition">
        Member Login
      </a>
    </div>
  </header>

  <!-- Main Hero Section -->
  <main class="flex-1 flex items-center justify-center">
    <div class="max-w-5xl w-full flex flex-col md:flex-row items-center gap-10 px-8 py-12">
      <!-- Left: Text Content -->
      <div class="flex-1">
        <h1 class="text-4xl md:text-5xl font-bold mb-4">
          <span class="text-blue-600">Your Trusted Pharmacy</span><br>
          <span class="text-gray-800">Online, Fast & Reliable</span>
        </h1>
        <p class="text-lg text-gray-600 mb-6">
          We deliver <span class="font-semibold text-blue-700">health, happiness, and savings</span> right to your door.<br>
          <span class="text-blue-500">"Medicines at your doorstep. Caring for you, always."</span>
        </p>
        <div class="flex gap-4 mb-6">
          <a href="register.jsp" class="bg-blue-600 text-white font-semibold px-6 py-3 rounded-full shadow hover:bg-blue-700 transition">
            Get Started
          </a>
          <a href="login.jsp" class="bg-white border border-blue-600 text-blue-600 font-semibold px-6 py-3 rounded-full shadow hover:bg-blue-50 transition">
            Already a Member?
          </a>
        </div>
        <div class="flex items-center gap-3 mt-2">
          <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="User" class="w-8 h-8 rounded-full border-2 border-blue-500">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="User" class="w-8 h-8 rounded-full border-2 border-blue-500">
          <img src="https://randomuser.me/api/portraits/men/54.jpg" alt="User" class="w-8 h-8 rounded-full border-2 border-blue-500">
          <span class="text-gray-500 text-sm ml-2">20,000+ happy customers</span>
        </div>
      </div>
      <!-- Right: Illustration (Placeholder) -->
      <div class="flex-1 flex justify-center">
        <div class="relative">
          <img src="https://img.icons8.com/fluency/96/medicine.png" alt="Online Pharmacy" class="w-72 drop-shadow-2xl rounded-2xl">
          <div class="absolute top-4 left-4 bg-white/90 px-4 py-2 rounded-xl shadow text-blue-700 font-semibold text-sm">
            Dedicated to your health
          </div>
          <div class="absolute bottom-4 right-4 bg-blue-600/90 px-4 py-2 rounded-xl shadow text-white font-semibold text-sm">
            24/7 Online Support
          </div>
        </div>
      </div>
    </div>
  </main>

  <!-- Footer -->
  <footer class="bg-white/80 border-t">
    <div class="max-w-7xl mx-auto px-4 py-8 flex flex-col md:flex-row items-center justify-between">
      <span class="text-sm text-gray-500">&copy; 2025 PharmaCare. All rights reserved.</span>
      <ul class="flex space-x-6 mt-4 md:mt-0 text-sm text-gray-500">
        <li><a href="#" class="hover:underline">Privacy Policy</a></li>
        <li><a href="#" class="hover:underline">Terms</a></li>
        <li><a href="#" class="hover:underline">Contact</a></li>
      </ul>
    </div>
  </footer>

</body>
</html>