<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Medicine</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function showFields() {
            var category = document.getElementById("category").value;
            document.getElementById("genericFields").style.display = (category === "generic") ? "block" : "none";
            document.getElementById("brandedFields").style.display = (category === "branded") ? "block" : "none";
        }
        window.onload = showFields;
    </script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-lg">
        <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Edit Medicine</h2>
        <form method="post" action="editMedicine" class="space-y-4">
            <c:if test="${not empty error}">
                <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-4">${error}</div>
            </c:if>
            <input type="hidden" name="id" value="${medicine.id}" />

            <div>
                <label class="block text-gray-700 font-medium mb-1">Name</label>
                <input type="text" name="name" value="${medicine.name}" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Price</label>
                    <input type="number" step="0.01" name="price" value="${medicine.price}" required
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                </div>
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Quantity</label>
                    <input type="number" name="quantity" value="${medicine.quantity}" required
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                </div>
            </div>
            <div>
                <label class="block text-gray-700 font-medium mb-1">Category</label>
                <select name="category" id="category" onchange="showFields()" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                    <option value="generic" <c:if test="${medicine.category eq 'generic'}">selected</c:if>>Generic</option>
                    <option value="branded" <c:if test="${medicine.category eq 'branded'}">selected</c:if>>Branded</option>
                </select>
            </div>
            <div>
                <label class="block text-gray-700 font-medium mb-1">Manufacture Date</label>
                <input type="date" name="manufacturingDate" value="${medicine.manufacturer}" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>
            <div>
                <label class="block text-gray-700 font-medium mb-1">Expiry Date</label>
                <input type="date" name="expiryDate" value="${medicine.expiryDate}" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>

            <!-- Generic Fields -->
            <div id="genericFields" style="display:none;">
                <h4 class="text-lg font-semibold text-blue-700 mt-4 mb-2">Generic Medicine Fields</h4>
                <c:if test="${medicine.category eq 'generic'}">
                    <label class="block text-gray-700 font-medium mb-1">Salt Composition</label>
                    <input type="text" name="saltComposition" value="${medicine.saltComposition}"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                </c:if>
            </div>

            <!-- Branded Fields -->
            <div id="brandedFields" style="display:none;">
                <h4 class="text-lg font-semibold text-blue-700 mt-4 mb-2">Branded Medicine Fields</h4>
                <c:if test="${medicine.category eq 'branded'}">
                    <label class="block text-gray-700 font-medium mb-1">Brand Name</label>
                    <input type="text" name="brandName" value="${medicine.brandName}"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400 mb-2" />
                    <label class="block text-gray-700 font-medium mb-1">Prescription Required</label>
                    <select name="prescriptionRequired"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                        <option value="false" <c:if test="${not medicine.prescriptionRequired}">selected</c:if>>No</option>
                        <option value="true" <c:if test="${medicine.prescriptionRequired}">selected</c:if>>Yes</option>
                    </select>
                </c:if>
            </div>

            <div class="flex items-center justify-between mt-6">
                <input type="submit" value="Update Medicine"
                    class="bg-blue-600 text-white px-5 py-2 rounded hover:bg-blue-700 font-semibold cursor-pointer transition" />
                <a href="viewMedicines"
                    class="text-blue-600 hover:underline font-medium">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
