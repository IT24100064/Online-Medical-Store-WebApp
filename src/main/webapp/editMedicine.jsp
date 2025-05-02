<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Medicine</title>
    <script>
        function showFields() {
            var category = document.getElementById("category").value;
            document.getElementById("genericFields").style.display = (category === "generic") ? "block" : "none";
            document.getElementById("brandedFields").style.display = (category === "branded") ? "block" : "none";
        }
        window.onload = showFields;
    </script>
</head>
<body>
    <h2>Edit Medicine</h2>
    <form method="post" action="editMedicine">
        <c:if test="${not empty error}">
            <div style="color:red;">${error}</div>
        </c:if>
        <input type="hidden" name="id" value="${medicine.id}" />
        <table>
            <tr><td>Name:</td><td><input type="text" name="name" value="${medicine.name}" required></td></tr>
            <tr><td>Price:</td><td><input type="number" step="0.01" name="price" value="${medicine.price}" required></td></tr>
            <tr><td>Quantity:</td><td><input type="number" name="quantity" value="${medicine.quantity}" required></td></tr>
            <tr>
                <td>Category:</td>
                <td>
                    <select name="category" id="category" onchange="showFields()" required>
                        <option value="generic" <c:if test="${medicine.category eq 'generic'}">selected</c:if>>Generic</option>
                        <option value="branded" <c:if test="${medicine.category eq 'branded'}">selected</c:if>>Branded</option>
                        <option value="other" <c:if test="${medicine.category eq 'other'}">selected</c:if>>Other</option>
                    </select>
                </td>
            </tr>
            <tr><td>Manufacturer:</td><td><input type="text" name="manufacturer" value="${medicine.manufacturer}" required></td></tr>
            <tr><td>Expiry Date:</td><td><input type="date" name="expiryDate" value="${medicine.expiryDate}" required></td></tr>
        </table>

        <div id="genericFields" style="display:none;">
            <h4>Generic Medicine Fields</h4>
            <c:if test="${medicine.category eq 'generic'}">
                <label>Salt Composition: <input type="text" name="saltComposition" value="${medicine.saltComposition}"></label>
            </c:if>
        </div>
        <div id="brandedFields" style="display:none;">
            <h4>Branded Medicine Fields</h4>
            <c:if test="${medicine.category eq 'branded'}">
                <label>Brand Name: <input type="text" name="brandName" value="${medicine.brandName}"></label><br>
                <label>Prescription Required:
                    <select name="prescriptionRequired">
                        <option value="false" <c:if test="${not medicine.prescriptionRequired}">selected</c:if>>No</option>
                        <option value="true" <c:if test="${medicine.prescriptionRequired}">selected</c:if>>Yes</option>
                    </select>
                </label>
            </c:if>
        </div>
        <br>
        <input type="submit" value="Update Medicine">
        <a href="viewMedicines">Cancel</a>
    </form>
</body>
</html>
