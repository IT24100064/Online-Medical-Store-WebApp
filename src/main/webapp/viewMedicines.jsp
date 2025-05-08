<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>All Medicines</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
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
  <main class="bg-gray-100 min-h-screen">
    <div class="max-w-7xl mx-auto py-10 px-4">
      <h2 class="text-3xl font-bold text-gray-800 mb-6">Medicine List</h2>
      <div class="flex flex-wrap items-center gap-4 mb-6">
        <a href="addMedicine.jsp" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 font-semibold shadow">
          Add New Medicine
        </a>
        <form action="viewMedicines" method="get" class="inline">
          <input type="hidden" name="sortBy" value="price">
          <input type="submit" value="Sort by Price"
            class="bg-gray-200 text-gray-800 px-4 py-2 rounded hover:bg-gray-300 font-semibold shadow cursor-pointer"/>
        </form>
      </div>
      <div class="bg-white shadow rounded-2xl">
        <table class="w-full table-auto">
          <thead class="bg-blue-50 sticky top-0 z-10">
            <tr>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">ID</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Name</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Price</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Quantity</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Category</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Manufacturer</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Expiry Date</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Salt Composition</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Brand Name</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Prescription</th>
              <th class="p-4 border-b font-semibold text-blue-900 text-sm tracking-wide text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="med" items="${medicines}">
              <c:if test="${not empty med.id}">
                <tr class="even:bg-gray-50 odd:bg-white hover:bg-blue-50 transition">
                  <td class="p-4 border-b font-mono text-blue-700 align-middle">${not empty med.id ? med.id : 'N/A'}</td>
                  <td class="p-4 border-b font-semibold align-middle">${not empty med.name ? med.name : 'N/A'}</td>
                  <td class="p-4 border-b text-green-700 font-bold align-middle">₹${med.price > 0 ? med.price : 'N/A'}</td>
                  <td class="p-4 border-b text-purple-700 font-bold align-middle">${med.quantity > 0 ? med.quantity : 'N/A'}</td>
                  <td class="p-4 border-b align-middle">
                    <c:choose>
                      <c:when test="${med['class'].simpleName eq 'GenericMedicine'}">
                        <span class="inline-block px-2 py-1 rounded bg-green-100 text-green-700 text-xs font-semibold">Generic</span>
                      </c:when>
                      <c:when test="${med['class'].simpleName eq 'BrandedMedicine'}">
                        <span class="inline-block px-2 py-1 rounded bg-yellow-100 text-yellow-700 text-xs font-semibold">Branded</span>
                      </c:when>
                      <c:otherwise>
                        <span class="inline-block px-2 py-1 rounded bg-gray-100 text-gray-700 text-xs font-semibold">${not empty med.category ? med.category : 'N/A'}</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="p-4 border-b align-middle">${not empty med.manufacturer ? med.manufacturer : 'N/A'}</td>
                  <td class="p-4 border-b align-middle">${not empty med.expiryDate ? med.expiryDate : 'N/A'}</td>
                  <td class="p-4 border-b align-middle">
                    <c:if test="${med['class'].simpleName eq 'GenericMedicine'}">
                      <span class="text-blue-600">${not empty med.saltComposition ? med.saltComposition : 'N/A'}</span>
                    </c:if>
                  </td>
                  <td class="p-4 border-b align-middle">
                    <c:if test="${med['class'].simpleName eq 'BrandedMedicine'}">
                      <span class="text-pink-600">${not empty med.brandName ? med.brandName : 'N/A'}</span>
                    </c:if>
                  </td>
                  <td class="p-4 border-b align-middle">
                    <c:if test="${med['class'].simpleName eq 'BrandedMedicine'}">
                      <c:choose>
                        <c:when test="${med.prescriptionRequired}">
                          <span class="inline-flex items-center px-2 py-1 rounded bg-red-100 text-red-700 text-xs font-semibold">Yes</span>
                        </c:when>
                        <c:otherwise>
                          <span class="inline-flex items-center px-2 py-1 rounded bg-green-100 text-green-700 text-xs font-semibold">No</span>
                        </c:otherwise>
                      </c:choose>
                    </c:if>
                  </td>
                  <td class="p-4 border-b align-middle whitespace-nowrap">
                    <a href="editMedicine?id=${med.id}"
                      class="inline-flex items-center bg-blue-50 text-blue-700 px-3 py-1 rounded hover:bg-blue-700 hover:text-white font-medium mr-2 transition shadow-sm">
                      <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536M9 11l6 6M3 21h18"/></svg>
                      Edit
                    </a>
                    <a href="deleteMedicine?id=${med.id}"
                      onclick="return confirm('Are you sure?')"
                      class="inline-flex items-center bg-red-50 text-red-700 px-3 py-1 rounded hover:bg-red-700 hover:text-white font-medium transition shadow-sm">
                      <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                      Delete
                    </a>
                  </td>
                </tr>
              </c:if>
            </c:forEach>
          </tbody>
        </table>
        <c:if test="${empty medicines}">
          <div class="flex flex-col items-center justify-center py-24">
            <svg class="w-16 h-16 text-blue-200 mb-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            <p class="text-xl text-gray-400">No medicines found.</p>
          </div>
        </c:if>
      </div>
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
</body>
</html>
