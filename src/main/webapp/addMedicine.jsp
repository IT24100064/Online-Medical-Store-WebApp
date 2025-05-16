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
            // Uppercase and max 7 chars
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
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen flex items-center justify-center">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-2xl p-8 fade-in">
        <h2 class="text-3xl font-extrabold text-blue-800 mb-6 text-center tracking-wide">Add Medicine</h2>
        <form method="post" action="addMedicine" class="space-y-6" autocomplete="off">
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded mb-4">${error}</div>
            </c:if>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">ID (MC12345 format)</label>
                    <input type="text" name="id" maxlength="7"
                           pattern="MC\d{5}"
                           title="Must be exactly 7 characters: MC followed by 5 digits (e.g. MC12345)"
                           required
                           oninput="enforceIdFormat(this)"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.id}"/>
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Name</label>
                    <input type="text" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.name}"/>
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Price (LKR)</label>
                    <input type="number" step="0.01" min="0.01" name="price" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.price}"/>
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Quantity</label>
                    <input type="number" min="1" name="quantity" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.quantity}"/>
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Category</label>
                    <select name="category" id="category" onchange="showFields()" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm">
                        <option value="">--Select--</option>
                        <option value="generic" ${param.category == 'generic' ? 'selected' : ''}>Generic</option>
                        <option value="branded" ${param.category == 'branded' ? 'selected' : ''}>Branded</option>
                        <option value="other" ${param.category == 'other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>

                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Manufacturing Date</label>
                    <input type="date" name="manufacturingDate" max="<%= today %>" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.manufacturingDate}"/>
                    <small class="text-gray-500">Must be today or in the past</small>
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Expiry Date</label>
                    <input type="date" name="expiryDate" min="<%= today %>" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.expiryDate}"/>
                    <small class="text-gray-500">Must be after manufacturing date</small>
                </div>
            </div>
            <!-- Dynamic Fields -->
            <div id="genericFields" style="display:none;">
                <div class="mt-4 bg-blue-50 border-l-4 border-blue-400 p-4 rounded-lg">
                    <h4 class="font-semibold text-blue-700 mb-2">Generic Medicine Fields</h4>
                    <label class="block text-gray-700 mb-1">Salt Composition</label>
                    <input type="text" name="saltComposition"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm"
                           value="${param.saltComposition}"/>
                </div>
            </div>
            <div id="brandedFields" style="display:none;">
                <div class="mt-4 bg-blue-50 border-l-4 border-blue-400 p-4 rounded-lg">
                    <h4 class="font-semibold text-blue-700 mb-2">Branded Medicine Fields</h4>
                    <label class="block text-gray-700 mb-1">Brand Name</label>
                    <input type="text" name="brandName"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm mb-3"
                           value="${param.brandName}"/>
                    <label class="block text-gray-700 mb-1">Prescription Required</label>
                    <select name="prescriptionRequired"
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 bg-white shadow-sm">
                        <option value="false" ${param.prescriptionRequired == 'false' ? 'selected' : ''}>No</option>
                        <option value="true" ${param.prescriptionRequired == 'true' ? 'selected' : ''}>Yes</option>
                    </select>
                </div>
            </div>
            <div class="flex justify-between items-center mt-8">
                <button type="submit"
                    class="bg-blue-700 hover:bg-blue-800 text-white font-bold py-2 px-8 rounded-lg shadow transition duration-200">
                    Add Medicine
                </button>
                <a href="viewMedicines"
                   class="text-blue-700 hover:underline font-semibold transition">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
