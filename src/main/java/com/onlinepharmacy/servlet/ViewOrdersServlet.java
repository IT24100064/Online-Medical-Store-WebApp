package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Medicine;
import com.onlinepharmacy.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/viewOrders")
public class ViewOrdersServlet extends HttpServlet {

    private static final String ORDERS_FILE = "/WEB-INF/data/order.txt";
    private static final String DELIMITER = "\\|";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = (String) request.getSession().getAttribute("customerName");
        if (customerName == null) {
            response.sendRedirect("placeOrder.jsp");
            return;
        }

        List<Order> allOrders = readOrdersFromFile();
        List<Order> customerOrders = new ArrayList<>();

        for (Order order : allOrders) {
            if (order.getCustomerName().equalsIgnoreCase(customerName)) {
                customerOrders.add(order);
            }
        }

        request.setAttribute("orders", customerOrders);
        request.getRequestDispatcher("viewOrders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");

        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID required.");
            return;
        }

        if ("delete".equalsIgnoreCase(action)) {
            List<Order> orders = readOrdersFromFile();
            boolean removed = orders.removeIf(o -> o.getOrderId().equals(orderId));
            if (removed) {
                writeOrdersToFile(orders);
            }
            response.sendRedirect(request.getContextPath() + "/viewOrders");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }

    private List<Order> readOrdersFromFile() throws IOException {
        List<Order> orders = new ArrayList<>();
        File file = new File(getServletContext().getRealPath(ORDERS_FILE));
        if (!file.exists()) {
            return orders;
        }
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                Order order = parseOrder(line);
                if (order != null) {
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    private void writeOrdersToFile(List<Order> orders) throws IOException {
        File file = new File(getServletContext().getRealPath(ORDERS_FILE));
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, false))) {
            for (Order order : orders) {
                bw.write(formatOrder(order));
                bw.newLine();
            }
        }
    }

    private Order parseOrder(String line) {
        try {
            String[] parts = line.split(DELIMITER);
            if (parts.length < 8) return null;

            String orderId = parts[0];
            String customerName = parts[1];
            String contact = parts[2];
            String address = parts[3];
            int age = Integer.parseInt(parts[4]);
            long orderDateMillis = Long.parseLong(parts[5]);
            String status = parts[6];
            String medsStr = parts[7];

            List<Medicine> medicines = new ArrayList<>();
            if (!medsStr.trim().isEmpty()) {
                String[] medsArr = medsStr.split(",");
                for (String med : medsArr) {
                    String[] medParts = med.split(":");
                    if (medParts.length == 2) {
                        String medName = medParts[0];
                        int qty = Integer.parseInt(medParts[1]);
                        medicines.add(new Medicine(medName, qty));
                    }
                }
            }

            Order order = new Order();
            order.setOrderId(orderId);
            order.setCustomerName(customerName);
            order.setContact(contact);
            order.setAddress(address);
            order.setAge(age);
            order.setOrderDate(new Date(orderDateMillis));
            order.setStatus(status);
            order.setMedicines(medicines);

            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private String formatOrder(Order order) {
        StringBuilder medsBuilder = new StringBuilder();
        List<Medicine> meds = order.getMedicines();
        for (int i = 0; i < meds.size(); i++) {
            Medicine m = meds.get(i);
            medsBuilder.append(m.getName()).append(":").append(m.getQuantity());
            if (i < meds.size() - 1) {
                medsBuilder.append(",");
            }
        }

        return order.getOrderId() + "|" +
                order.getCustomerName() + "|" +
                order.getContact() + "|" +
                order.getAddress() + "|" +
                order.getAge() + "|" +
                order.getOrderDate().getTime() + "|" +
                order.getStatus() + "|" +
                medsBuilder.toString();
    }
}
