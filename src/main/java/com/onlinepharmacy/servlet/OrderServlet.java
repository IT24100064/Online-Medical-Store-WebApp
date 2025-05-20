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

        // Get the absolute path to the file
        String realPath = getServletContext().getRealPath(ORDERS_FILE);
        System.out.println("Writing to file: " + realPath);

        File file = new File(realPath);

        // Ensure parent directory exists
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            boolean dirCreated = parentDir.mkdirs();
            if (!dirCreated) {
                throw new ServletException("Failed to create directory: " + parentDir.getAbsolutePath());
            }
        }

        // Use simpler approach without file locking to avoid ClosedChannelException
        try (FileWriter fw = new FileWriter(file, true);
             BufferedWriter bw = new BufferedWriter(fw)) {

            String orderStr = formatOrder(order);
            System.out.println("Writing new order: " + orderStr);
            bw.write(orderStr);
            bw.newLine();

            // Ensure data is written to disk
            bw.flush();
            System.out.println("Order saved successfully");

        } catch (IOException e) {
            System.err.println("Error saving order: " + e.getMessage());
            e.printStackTrace();
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
            int num = 1000 + random.nextInt(9000);
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

        // Ensure parent directory exists
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }

        // If file doesn't exist, create an empty file
        if (!file.exists()) {
            file.createNewFile();
            return orders;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Skip empty lines
                if (line.trim().isEmpty()) {
                    continue;
                }

                Order order = parseOrder(line);
                if (order != null) {
                    orders.add(order);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading orders file: " + e.getMessage());
            e.printStackTrace();
            // Create a new file if there was an error reading
            file.createNewFile();
        }

        return orders;
    }

    private Order parseOrder(String line) {
        if (line == null || line.trim().isEmpty()) {
            return null;
        }

        try {
            String[] parts = line.split(DELIMITER);
            if (parts.length < 8) {
                System.err.println("Invalid order format, expected at least 8 parts but got: " + parts.length);
                return null;
            }

            String orderId = parts[0].trim();
            String customerName = parts[1].trim();
            String contact = parts[2].trim();
            String address = parts[3].trim();

            int age;
            try {
                age = Integer.parseInt(parts[4].trim());
            } catch (NumberFormatException e) {
                System.err.println("Invalid age format: " + parts[4]);
                return null;
            }

            long orderDateMillis;
            try {
                orderDateMillis = Long.parseLong(parts[5].trim());
            } catch (NumberFormatException e) {
                System.err.println("Invalid date format: " + parts[5]);
                return null;
            }

            String status = parts[6].trim();
            String medsStr = parts[7].trim();

            List<Medicine> medicines = new ArrayList<>();
            if (!medsStr.isEmpty()) {
                String[] medsArr = medsStr.split(",");
                for (String med : medsArr) {
                    String[] medParts = med.split(":");
                    if (medParts.length == 2) {
                        String medName = medParts[0].trim();
                        try {
                            int qty = Integer.parseInt(medParts[1].trim());
                            medicines.add(new Medicine(medName, qty));
                        } catch (NumberFormatException e) {
                            System.err.println("Invalid quantity format: " + medParts[1]);
                            // Continue processing other medicines
                        }
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
            System.err.println("Error parsing order: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    private String formatOrder(Order order) {
        // Validate order data
        if (order == null || order.getOrderId() == null || order.getCustomerName() == null ||
            order.getContact() == null || order.getAddress() == null ||
            order.getOrderDate() == null || order.getStatus() == null) {
            throw new IllegalArgumentException("Order data is incomplete");
        }

        // Format medicines
        StringBuilder medsBuilder = new StringBuilder();
        List<Medicine> meds = order.getMedicines();
        if (meds != null && !meds.isEmpty()) {
            for (int i = 0; i < meds.size(); i++) {
                Medicine m = meds.get(i);
                if (m != null && m.getName() != null) {
                    medsBuilder.append(m.getName().trim()).append(":").append(m.getQuantity());
                    if (i < meds.size() - 1) {
                        medsBuilder.append(",");
                    }
                }
            }
        }

        // Sanitize data to prevent delimiter conflicts
        String orderId = sanitize(order.getOrderId());
        String customerName = sanitize(order.getCustomerName());
        String contact = sanitize(order.getContact());
        String address = sanitize(order.getAddress());
        String status = sanitize(order.getStatus());

        // Build the formatted string
        return orderId + DELIMITER_WRITE +
                customerName + DELIMITER_WRITE +
                contact + DELIMITER_WRITE +
                address + DELIMITER_WRITE +
                order.getAge() + DELIMITER_WRITE +
                order.getOrderDate().getTime() + DELIMITER_WRITE +
                status + DELIMITER_WRITE +
                medsBuilder.toString();
    }

    // Helper method to sanitize data and prevent delimiter conflicts
    private String sanitize(String input) {
        if (input == null) {
            return "";
        }
        // Replace pipe character with a space to avoid delimiter conflicts
        return input.trim().replace("|", " ");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/placeOrder.jsp");
    }
}
