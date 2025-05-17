<%@ page import="com.onlinepharmacy.model.RegularUser" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col" >
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
<%
    RegularUser user = null;
    try {
        user = (RegularUser) session.getAttribute("currentUser");
    } catch (Exception e) { }
    if(user != null && "Regular".equals(user.getRole())) {
%>

 <main class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="flex bg-white rounded-2xl shadow-2xl overflow-hidden w-full max-w-4xl">
    <!-- Sidebar -->
    <div class="flex flex-col items-center py-10 px-4 bg-gradient-to-b from-blue-500 to-blue-300 min-w-[80px]">
        <!-- Active icon -->
        <div class="mb-4">
            <div class="bg-white rounded-xl p-3 shadow-lg">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 15c2.21 0 4.304.534 6.121 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
            </div>
        </div>
        <!-- Other icons -->
        <div class="flex flex-col gap-4 text-white text-2xl">
            <div class="bg-transparent rounded-full p-2 opacity-60 hover:opacity-100 cursor-pointer">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.657 1.343-3 3-3s3 1.343 3 3-1.343 3-3 3-3-1.343-3-3z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 11V7a5 5 0 00-10 0v4" />
                </svg>
            </div>
            <div class="bg-transparent rounded-full p-2 opacity-60 hover:opacity-100 cursor-pointer">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 20h.01" />
                </svg>
            </div>
            <div class="bg-transparent rounded-full p-2 opacity-60 hover:opacity-100 cursor-pointer">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                </svg>
            </div>
        </div>
    </div>
    <!-- Main Profile Section -->
    <div class="flex-1 px-12 py-12 flex flex-col">
        <h1 class="text-6xl font-extrabold mb-8 tracking-tight">Profile</h1>
        <div class="flex items-start gap-10">
            <div class="flex-1 space-y-6">
                <div>
                    <div class="text-xs text-gray-400 tracking-widest mb-1">USER NAME</div>
                    <div class="font-semibold text-lg text-gray-700 border-b border-gray-200 pb-1"><%= user.getUsername() %></div>
                </div>
                <div>
                    <div class="text-xs text-gray-400 tracking-widest mb-1">E-MAIL</div>
                    <div class="font-medium text-gray-700 border-b border-gray-200 pb-1"><%= user.getEmail() %></div>
                </div>
                <div>
                    <div class="text-xs text-gray-400 tracking-widest mb-1">ADDRESS</div>
                    <div class="font-medium text-gray-700 border-b border-gray-200 pb-1"><%= user.getAddress() %></div>
                </div>
                <div>
                    <div class="text-xs text-gray-400 tracking-widest mb-1">CONTACT</div>
                    <div class="font-medium text-gray-700 border-b border-gray-200 pb-1"><%= user.getContact() %></div>
                </div>
            </div>
            <div class="flex flex-col items-center">
                <div class="relative">
                    <!-- Default blue user image -->
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile" class="w-36 h-36 rounded-full object-cover border-4 border-white shadow-lg bg-blue-100">
                    <button class="absolute bottom-2 right-2 bg-white rounded-full p-2 shadow hover:bg-gray-100 border border-gray-200">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536M9 11l6 6M9 11l-6 6m6-6l6 6"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>
        <div class="mt-12 flex">
            <a href="update-profile.jsp" class="ml-auto px-10 py-3 rounded-lg text-white font-bold text-lg bg-gradient-to-r from-blue-500 to-blue-400 shadow hover:from-blue-600 hover:to-blue-500 transition">Edit Details</a>
        </div>
        <div class="mt-8">
            <a href="logout" class="text-blue-500 hover:underline font-medium">Logout</a>
        </div>
    </div>
</div>
</main>
<%
    } else {
%>
<div class="bg-white rounded-xl shadow-lg p-10 text-center text-red-500 font-semibold text-lg">
    You are not logged in as a regular user.
</div>
<%
    }
%>
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