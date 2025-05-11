<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Medicine | Admin Panel</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function showFields() {
            var category = document.getElementById("category").value;
            document.getElementById("genericFields").style.display = (category === "generic") ? "block" : "none";
            document.getElementById("brandedFields").style.display = (category === "branded") ? "block" : "none";
            document.querySelector("[name=saltComposition]").required = (category === "generic");
            document.querySelector("[name=brandName]").required = (category === "branded");
            document.querySelector("[name=prescriptionRequired]").required = (category === "branded");
        }
        function enforceIdFormat(input) {
            input.value = input.value.toUpperCase().replace(/[^A-Z0-9]/g, '').substring(0, 7);
        }
        window.onload = function() {
            const category = "${param.category}";
            if(category) {
                document.getElementById("category").value = category;
            }
            showFields();
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col" >
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
  <main class="bg-gradient-to-br from-blue-100 via-blue-200 to-blue-300 min-h-screen flex items-center justify-center">
    <div class="relative bg-white/90 rounded-3xl shadow-2xl w-full max-w-2xl p-0 overflow-hidden fade-in">
        <!-- Gradient Header with Illustration -->
        <div class="bg-gradient-to-r from-blue-600 to-blue-400 px-8 py-6 flex items-center gap-6">

            <div>
                <h2 class="text-3xl font-extrabold text-white mb-1 tracking-wide">Add Medicine</h2>
                <p class="text-blue-100 text-sm">Fill in the details to add a new medicine to inventory.</p>
            </div>
        </div>
        <form method="post" action="addMedicine" class="space-y-6 px-8 py-8" autocomplete="off">
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded mb-4">${error}</div>
            </c:if>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Floating Label Input Example -->
                <div class="relative">
                    <input type="text" name="id" maxlength="7"
                        pattern="MC\d{5}"
                        title="Must be exactly 7 characters: MC followed by 5 digits (e.g. MC12345)"
                        required
                        oninput="enforceIdFormat(this)"
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                        placeholder="MC12345"
                        value="${param.id}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">ID (MC12345)</label>
                </div>
                <div class="relative">
                    <input type="text" name="name" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                        placeholder="Medicine Name"
                        value="${param.name}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">Name</label>
                </div>
                <div class="relative">
                    <input type="number" step="0.01" min="0.01" name="price" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                        placeholder="Price"
                        value="${param.price}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">Price (Rs)</label>
                </div>
                <div class="relative">
                    <input type="number" min="1" name="quantity" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                        placeholder="Quantity"
                        value="${param.quantity}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">Quantity</label>
                </div>
                <div class="relative">
                    <select name="category" id="category" onchange="showFields()" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm bg-white">
                        <option value="" disabled ${empty param.category ? 'selected' : ''}>--Select--</option>
                        <option value="generic" ${param.category == 'generic' ? 'selected' : ''}>Generic</option>
                        <option value="branded" ${param.category == 'branded' ? 'selected' : ''}>Branded</option>
                        <option value="other" ${param.category == 'other' ? 'selected' : ''}>Other</option>
                    </select>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-focus:top-2 peer-focus:text-xs font-semibold">Category</label>
                </div>
                <div class="relative">
                    <input type="text" name="manufacturer" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                        placeholder="Manufacturer"
                        value="${param.manufacturer}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">Manufacturer</label>
                </div>
                <div class="relative">
                    <input type="date" name="manufacturingDate" max="<%= today %>" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                        value="${param.manufacturingDate}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-focus:top-2 peer-focus:text-xs font-semibold">Manufacturing Date</label>
                    <small class="text-gray-400 block mt-1">Must be today or in the past</small>
                </div>
                <div class="relative">
                    <input type="date" name="expiryDate" min="<%= today %>" required
                        class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                        value="${param.expiryDate}"/>
                    <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-focus:top-2 peer-focus:text-xs font-semibold">Expiry Date</label>
                    <small class="text-gray-400 block mt-1">Must be after manufacturing date</small>
                </div>
            </div>
            <!-- Dynamic Fields -->
            <div id="genericFields" style="display:none;">
                <div class="mt-4 bg-blue-50 border-l-4 border-blue-400 p-4 rounded-lg">
                    <h4 class="font-semibold text-blue-700 mb-2">Generic Medicine Fields</h4>
                    <div class="relative">
                        <input type="text" name="saltComposition"
                            class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                            placeholder="Salt Composition"
                            value="${param.saltComposition}"/>
                        <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">Salt Composition</label>
                    </div>
                </div>
            </div>
            <div id="brandedFields" style="display:none;">
                <div class="mt-4 bg-blue-50 border-l-4 border-blue-400 p-4 rounded-lg">
                    <h4 class="font-semibold text-blue-700 mb-2">Branded Medicine Fields</h4>
                    <div class="relative mb-3">
                        <input type="text" name="brandName"
                            class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm placeholder-transparent"
                            placeholder="Brand Name"
                            value="${param.brandName}"/>
                        <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-placeholder-shown:top-4 peer-placeholder-shown:text-base peer-focus:top-2 peer-focus:text-xs font-semibold">Brand Name</label>
                    </div>
                    <div class="relative">
                        <select name="prescriptionRequired"
                            class="peer w-full px-4 pt-6 pb-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm">
                            <option value="false" ${param.prescriptionRequired == 'false' ? 'selected' : ''}>No</option>
                            <option value="true" ${param.prescriptionRequired == 'true' ? 'selected' : ''}>Yes</option>
                        </select>
                        <label class="absolute left-3 top-2 text-gray-500 text-xs transition-all peer-focus:top-2 peer-focus:text-xs font-semibold">Prescription Required</label>
                    </div>
                </div>
            </div>
            <div class="flex justify-between items-center mt-8">
                <button type="submit"
                    class="bg-gradient-to-r from-blue-700 to-blue-500 hover:from-blue-800 hover:to-blue-600 text-white font-bold py-2 px-8 rounded-lg shadow-lg transition duration-200 flex items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Add Medicine
                </button>
                <a href="index.jsp"
                   class="text-blue-700 hover:underline font-semibold transition">Cancel</a>
            </div>
        </form>
    </div>
    </main>
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
    <style>
        .fade-in { animation: fadeIn 0.7s; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(40px);} to { opacity: 1; transform: none;} }
        .animate-bounce-slow { animation: bounce 2s infinite; }
        @keyframes bounce {
            0%, 100% { transform: translateY(0);}
            50% { transform: translateY(-10px);}
        }
    </style>
</body>
</html>
