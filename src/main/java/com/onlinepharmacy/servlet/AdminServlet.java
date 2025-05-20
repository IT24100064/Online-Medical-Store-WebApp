package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Medicine;
import com.onlinepharmacy.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/admin/orders")
public class AdminServlet extends HttpServlet {

    private static final String ORDERS_FILE = "/WEB-INF/data/order.txt";
    private static final String DELIMITER = "\\|";
    private static final String DELIMITER_WRITE = "|";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orders = readOrdersFromFile();
        orders.sort(Comparator.comparing(Order::getOrderDate));
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/adminOrders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String action = request.getParameter("action"); // may be null
        String newStatus = request.getParameter("status");

        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID required.");
            return;
        }

        List<Order> orders = readOrdersFromFile();
        orders.sort(Comparator.comparing(Order::getOrderDate)); // Sort oldest first

        if ("delete".equalsIgnoreCase(action)) {
            boolean removed = orders.removeIf(o -> o.getOrderId().equals(orderId));
            if (removed) {
                writeOrdersToFile(orders);
            }
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        if (newStatus == null || newStatus.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Status required.");
            return;
        }

        // Find first order NOT completed or canceled (eligible for update)
        Order firstActiveOrder = null;
        for (Order o : orders) {
            String status = o.getStatus().toUpperCase();
            if (!status.equals("COMPLETED") && !status.equals("CANCELED")) {
                firstActiveOrder = o;
                break;
            }
        }

        if (firstActiveOrder == null) {
            // No active orders to update
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        // Only allow update if the orderId matches the first active order
        if (!firstActiveOrder.getOrderId().equals(orderId)) {
            // Trying to update out-of-turn order - ignore or show error
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        String currentStatus = firstActiveOrder.getStatus().toUpperCase();
        newStatus = newStatus.toUpperCase();

        if (!isValidTransition(currentStatus, newStatus)) {
            // Invalid status transition, ignore or handle error
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        // Perform update
        firstActiveOrder.setStatus(newStatus);
        writeOrdersToFile(orders);

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private boolean isValidTransition(String currentStatus, String newStatus) {
        Map<String, List<String>> allowedTransitions = new HashMap<>();
        allowedTransitions.put("PENDING", Arrays.asList("CONFIRMED", "CANCELED"));
        allowedTransitions.put("CONFIRMED", Arrays.asList("PROCESSING", "CANCELED"));
        allowedTransitions.put("PROCESSING", Arrays.asList("HANDOVER", "CANCELED"));
        allowedTransitions.put("HANDOVER", Arrays.asList("OUTFORDELIVERY", "CANCELED"));
        allowedTransitions.put("OUTFORDELIVERY", Arrays.asList("COMPLETED", "CANCELED"));
        allowedTransitions.put("COMPLETED", Collections.emptyList());
        allowedTransitions.put("CANCELED", Collections.emptyList());

        return allowedTransitions.getOrDefault(currentStatus, Collections.emptyList()).contains(newStatus);
    }

    private List<Order> readOrdersFromFile() throws IOException {
        List<Order> orders = new ArrayList<>();
        File file = new File(getServletContext().getRealPath(ORDERS_FILE));
        if (!file.exists()) return orders;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                Order order = parseOrder(line);
                if (order != null) orders.add(order);
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

            Order order = new Order();
            order.setOrderId(parts[0]);
            order.setCustomerName(parts[1]);
            order.setContact(parts[2]);
            order.setAddress(parts[3]);
            order.setAge(Integer.parseInt(parts[4]));
            order.setOrderDate(new Date(Long.parseLong(parts[5])));
            order.setStatus(parts[6]);

            List<Medicine> medicines = new ArrayList<>();
            if (!parts[7].trim().isEmpty()) {
                String[] medsArr = parts[7].split(",");
                for (String med : medsArr) {
                    String[] medParts = med.split(":");
                    if (medParts.length == 2) {
                        medicines.add(new Medicine(medParts[0], Integer.parseInt(medParts[1])));
                    }
                }
            }
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
            if (i < meds.size() - 1) medsBuilder.append(",");
        }

        return order.getOrderId() + DELIMITER_WRITE
                + order.getCustomerName() + DELIMITER_WRITE
                + order.getContact() + DELIMITER_WRITE
                + order.getAddress() + DELIMITER_WRITE
                + order.getAge() + DELIMITER_WRITE
                + order.getOrderDate().getTime() + DELIMITER_WRITE
                + order.getStatus() + DELIMITER_WRITE
                + medsBuilder.toString();
    }
}
