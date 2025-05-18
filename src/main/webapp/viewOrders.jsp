<%@ page import="java.util.List" %>
<%@ page import="com.onlinepharmacy.model.Order" %>
<%@ page import="com.onlinepharmacy.model.Medicine" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Your Orders</title>
</head>
<body>
<h2>Your Orders</h2>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null || orders.isEmpty()) {
%>
    <p>No orders found.</p>
<%
    } else {
%>
<table border="1" cellpadding="5" cellspacing="0">
    <thead>
    <tr>
        <th>Order ID</th>
        <th>Medicines</th>
        <th>Status</th>
        <th>Order Date</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (Order order : orders) {
    %>
    <tr>
        <td><%= order.getOrderId() %></td>
        <td>
            <%
                for (Medicine med : order.getMedicines()) {
                    out.print(med.getName() + " (Qty: " + med.getQuantity() + ")<br>");
                }
            %>
        </td>
        <td><%= order.getStatus() %></td>
        <td><%= order.getOrderDate() %></td>
        <td>
            <form action="viewOrders" method="post" onsubmit="return confirm('Are you sure you want to delete this order?');">
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>"/>
                <input type="hidden" name="action" value="delete"/>
                <input type="submit" value="Delete"/>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
    }
%>

<br><a href="placeOrder.jsp">Place New Order</a>
</body>
</html>
