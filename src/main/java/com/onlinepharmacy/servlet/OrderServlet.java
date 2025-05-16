package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Medicine;
import com.onlinepharmacy.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private static final String ORDERS_FILE = "/WEB-INF/data/order.txt";
    private static final String DELIMITER = "\\|";
    private static final String DELIMITER_WRITE = "|";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = request.getParameter("name");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String ageStr = request.getParameter("age");

        if (customerName == null || contact == null || address == null || ageStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required.");
            return;
        }

        // Server-side validation: contact must be exactly 10 digits
        if (!contact.matches("\\d{10}")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int age;
        try {
            age = Integer.parseInt(ageStr);
            if (age < 18) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Age must be 18 or older.");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid age.");
            return;
        }

        String[] medNames = request.getParameterValues("medicine");
        String[] quantities = request.getParameterValues("quantity");

        if (medNames == null || quantities == null || medNames.length != quantities.length) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Medicines and quantities are required.");
            return;
        }

        List<Medicine> medicines = new ArrayList<>();
        for (int i = 0; i < medNames.length; i++) {
            String medName = medNames[i];
            int qty;
            try {
                qty = Integer.parseInt(quantities[i]);
                if (qty < 1) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity must be positive.");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity.");
                return;
            }
            medicines.add(new Medicine(medName, qty));
        }

        List<Order> existingOrders = readOrdersFromFile();

        Order order = new Order();
        order.setOrderId(generateUnique4DigitOrderId(existingOrders));
        order.setCustomerName(customerName);
        order.setContact(contact);
        order.setAddress(address);
        order.setAge(age);
        order.setMedicines(medicines);
        order.setOrderDate(new Date());
        order.setStatus("PENDING");

        File file = new File(getServletContext().getRealPath(ORDERS_FILE));
        file.getParentFile().mkdirs();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, true))) {
            bw.write(formatOrder(order));
            bw.newLine();
        } catch (IOException e) {
            throw new ServletException("Error saving order", e);
        }

        HttpSession session = request.getSession();
        session.setAttribute("customerName", customerName);

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private String generateUnique4DigitOrderId(List<Order> existingOrders) {
        Random random = new Random();
        Set<String> existingIds = new HashSet<>();
        for (Order o : existingOrders) {
            existingIds.add(o.getOrderId());
        }

        String newId;
        int attempts = 0;
        do {
            int num = 1000 + random.nextInt(9000); // 1000-9999
            newId = String.valueOf(num);
            attempts++;
            if (attempts > 10000) {
                throw new RuntimeException("Unable to generate unique order ID");
            }
        } while (existingIds.contains(newId));

        return newId;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/placeOrder.jsp");
    }
}
