<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Supplier | PharmaCare Admin</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
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
    </nav>
</header>

<main class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-2xl mx-auto p-6">
        <div class="bg-white shadow-xl rounded-2xl p-8">
            <div class="mb-8 text-center">
                <h2 class="text-3xl font-extrabold text-blue-800 mb-2">Edit Supplier</h2>
                <p class="text-blue-600 text-sm">Update the details for this supplier.</p>
            </div>

            <c:if test="${not empty errors.general}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 text-center">${errors.general}</div>
            </c:if>

            <form action="editSupplier" method="post" class="space-y-6">
                <!-- Supplier ID (read-only) -->
                <div>
                    <label class="block text-blue-900 font-medium mb-1" for="id">Supplier ID</label>
                    <input type="text" id="id" name="id" readonly
                        value="${supplier.id}"
                        class="bg-gray-100 w-full px-4 py-2 border border-blue-200 rounded-lg text-gray-500 cursor-not-allowed">
                </div>
                <!-- Name & Company Name -->
                <div class="md:flex md:space-x-4">
                    <div class="md:w-1/2 mb-4 md:mb-0">
                        <label class="block text-blue-900 font-medium mb-1" for="name">Name<span class="text-red-500">*</span></label>
                        <input type="text" id="name" name="name" required minlength="2" maxlength="50"
                            value="${supplier.name}"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <c:if test="${not empty errors.name}">
                            <span class="text-red-600 text-sm">${errors.name}</span>
                        </c:if>
                    </div>
                    <div class="md:w-1/2">
                        <label class="block text-blue-900 font-medium mb-1" for="companyName">Company Name<span class="text-red-500">*</span></label>
                        <input type="text" id="companyName" name="companyName" required minlength="2" maxlength="50"
                            value="${supplier.companyName}"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <c:if test="${not empty errors.companyName}">
                            <span class="text-red-600 text-sm">${errors.companyName}</span>
                        </c:if>
                    </div>
                </div>
                <!-- Email & Phone -->
                <div class="md:flex md:space-x-4">
                    <div class="md:w-1/2 mb-4 md:mb-0">
                        <label class="block text-blue-900 font-medium mb-1" for="email">Email<span class="text-red-500">*</span></label>
                        <input type="email" id="email" name="email" required
                            value="${supplier.email}"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <c:if test="${not empty errors.email}">
                            <span class="text-red-600 text-sm">${errors.email}</span>
                        </c:if>
                    </div>
                    <div class="md:w-1/2">
                        <label class="block text-blue-900 font-medium mb-1" for="phone">Phone<span class="text-red-500">*</span></label>
                        <input type="tel" id="phone" name="phone" required maxlength="10" pattern="\d{10}"
                            value="${supplier.phone}"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <c:if test="${not empty errors.phone}">
                            <span class="text-red-600 text-sm">${errors.phone}</span>
                        </c:if>
                    </div>
                </div>
                <!-- Address -->
                <div>
                    <label class="block text-blue-900 font-medium mb-1" for="address">Address<span class="text-red-500">*</span></label>
                    <textarea id="address" name="address" required rows="2" minlength="5" maxlength="100"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">${supplier.address}</textarea>
                    <c:if test="${not empty errors.address}">
                        <span class="text-red-600 text-sm">${errors.address}</span>
                    </c:if>
                </div>
                <!-- Supplier Type -->
                <div class="md:flex md:space-x-4">
                    <div class="md:w-1/2 mb-4 md:mb-0">
                        <label class="block text-blue-900 font-medium mb-1" for="supplierType">Supplier Type<span class="text-red-500">*</span></label>
                        <select name="type" id="supplierType" required
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                            <option value="">Select Type</option>
                            <option value="local" <c:if test="${supplier.getClass().simpleName == 'LocalSupplier'}">selected</c:if>>Local</option>
                            <option value="international" <c:if test="${supplier.getClass().simpleName == 'InternationalSupplier'}">selected</c:if>>International</option>
                            <option value="standard" <c:if test="${supplier.getClass().simpleName == 'Supplier'}">selected</c:if>>Standard</option>
                        </select>
                        <c:if test="${not empty errors.type}">
                            <span class="text-red-600 text-sm">${errors.type}</span>
                        </c:if>
                    </div>
                    <!-- Local Supplier Fields -->
                    <div class="md:w-1/2 dynamic-field" id="localFields" style="display: none;">
                        <c:if test="${supplier.getClass().simpleName == 'LocalSupplier'}">
                            <label class="block text-blue-900 font-medium mb-1" for="taxId">Tax ID<span class="text-red-500">*</span></label>
                            <input type="text" id="taxId" name="taxId"
                                value="${supplier.taxId}"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                            <c:if test="${not empty errors.taxId}">
                                <span class="text-red-600 text-sm">${errors.taxId}</span>
                            </c:if>
                        </c:if>
                    </div>
                    <!-- International Supplier Fields -->
                    <div class="md:w-1/2 dynamic-field" id="internationalFields" style="display: none;">
                        <c:if test="${supplier.getClass().simpleName == 'InternationalSupplier'}">
                            <label class="block text-blue-900 font-medium mb-1" for="importDuty">Import Duty<span class="text-red-500">*</span></label>
                            <input type="text" id="importDuty" name="importDuty"
                                value="${supplier.importDuty}"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                            <c:if test="${not empty errors.importDuty}">
                                <span class="text-red-600 text-sm">${errors.importDuty}</span>
                            </c:if>
                            <label class="block text-blue-900 font-medium mb-1 mt-2" for="country">Country<span class="text-red-500">*</span></label>
                            <input type="text" id="country" name="country"
                                value="${supplier.country}"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                            <c:if test="${not empty errors.country}">
                                <span class="text-red-600 text-sm">${errors.country}</span>
                            </c:if>
                        </c:if>
                    </div>
                </div>
                <!-- Actions -->
                <div class="flex flex-col sm:flex-row gap-3 pt-2">
                    <button type="submit"
                        class="w-full sm:w-auto bg-blue-700 text-white px-6 py-2 rounded-lg font-bold shadow hover:bg-blue-800 transition">
                        Update Supplier
                    </button>
                    <a href="viewSuppliers"
                        class="w-full sm:w-auto bg-gray-200 text-blue-800 px-6 py-2 rounded-lg font-bold shadow hover:bg-gray-300 transition text-center">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</main>

<script>
    function showFields() {
        const type = document.getElementById('supplierType').value;
        document.getElementById('localFields').style.display = (type === 'local') ? 'block' : 'none';
        document.getElementById('internationalFields').style.display = (type === 'international') ? 'block' : 'none';
    }
    document.getElementById('supplierType').addEventListener('change', showFields);
    // Show correct fields on page load
    showFields();
</script>
</body>
</html>
