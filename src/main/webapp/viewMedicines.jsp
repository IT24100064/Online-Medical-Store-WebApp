<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>All Medicines</title>
</head>
<body>
    <h2>Medicine List</h2>
    <a href="addMedicine">Add New Medicine</a>
    <form action="viewMedicines" method="get" style="display:inline;">
        <input type="hidden" name="sortBy" value="price">
        <input type="submit" value="Sort by Price">
    </form>
    <br><br>
    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Quantity</th>
            <th>Category</th><th>Manufacturer</th><th>Expiry Date</th>
            <th>Salt Composition</th><th>Brand Name</th><th>Prescription Required</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="med" items="${medicines}">
            <c:if test="${not empty med.id}">
            <tr>
                <td>${not empty med.id ? med.id : 'N/A'}</td>
                <td>${not empty med.name ? med.name : 'N/A'}</td>
                <td>${med.price > 0 ? med.price : 'N/A'}</td>
                <td>${med.quantity > 0 ? med.quantity : 'N/A'}</td>
                <td>
                    <c:choose>
                        <c:when test="${med['class'].simpleName eq 'GenericMedicine'}">Generic</c:when>
                        <c:when test="${med['class'].simpleName eq 'BrandedMedicine'}">Branded</c:when>
                        <c:otherwise>${not empty med.category ? med.category : 'N/A'}</c:otherwise>
                    </c:choose>
                </td>
                <td>${not empty med.manufacturer ? med.manufacturer : 'N/A'}</td>
                <td>${not empty med.expiryDate ? med.expiryDate : 'N/A'}</td>
                <td>
                    <c:if test="${med['class'].simpleName eq 'GenericMedicine'}">
                        ${not empty med.saltComposition ? med.saltComposition : 'N/A'}
                    </c:if>
                </td>
                <td>
                    <c:if test="${med['class'].simpleName eq 'BrandedMedicine'}">
                        ${not empty med.brandName ? med.brandName : 'N/A'}
                    </c:if>
                </td>
                <td>
                    <c:if test="${med['class'].simpleName eq 'BrandedMedicine'}">
                        <c:choose>
                            <c:when test="${med.prescriptionRequired}">Yes</c:when>
                            <c:otherwise>No</c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
                <td>
                    <a href="editMedicine?id=${med.id}">Edit</a> |
                    <a href="deleteMedicine?id=${med.id}" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            </c:if>
        </c:forEach>
    </table>
</body>
</html>
