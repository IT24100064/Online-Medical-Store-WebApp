package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Medicine;
import com.onlinepharmacy.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.util.Iterator;

@WebServlet("/viewOrders")
public class ViewOrdersServlet extends HttpServlet {

    private static final String ORDERS_FILE = "/WEB-INF/data/order.txt";
    private static final String DELIMITER = "\\|";
    private static final String DELIMITER_WRITE = "|";

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
            System.out.println("Deleting order with ID: " + orderId);

            List<Order> orders = readOrdersFromFile();

            // Print all order IDs before deletion for debugging
            System.out.println("Orders before deletion:");
            for (Order o : orders) {
                System.out.println("Order ID: " + o.getOrderId());
            }

            // Use iterator for safer removal
            Iterator<Order> iterator = orders.iterator();
            boolean removed = false;
            while (iterator.hasNext()) {
                Order o = iterator.next();
                if (o.getOrderId().equals(orderId)) {
                    iterator.remove();
                    removed = true;
                    System.out.println("Order removed: " + orderId);
                    break;
                }
            }

            // Print all order IDs after deletion for debugging
            System.out.println("Orders after deletion:");
            for (Order o : orders) {
                System.out.println("Order ID: " + o.getOrderId());
            }

            if (removed) {
                try {
                    writeOrdersToFile(orders);
                    System.out.println("Orders file updated successfully");
                } catch (Exception e) {
                    System.err.println("Error writing to file after deletion: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("No order found with ID: " + orderId);
            }

            response.sendRedirect(request.getContextPath() + "/viewOrders");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
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

    private void writeOrdersToFile(List<Order> orders) throws IOException {
        // Get the absolute path to the file
        String realPath = getServletContext().getRealPath(ORDERS_FILE);
        System.out.println("Writing to file: " + realPath);

        File file = new File(realPath);

        // Ensure parent directory exists
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            boolean dirCreated = parentDir.mkdirs();
            if (!dirCreated) {
                throw new IOException("Failed to create directory: " + parentDir.getAbsolutePath());
            }
        }

        // Use simpler approach without file locking to avoid ClosedChannelException
        try (FileWriter fw = new FileWriter(file, false);
             BufferedWriter bw = new BufferedWriter(fw)) {

            System.out.println("Writing " + orders.size() + " orders to file");

            // Clear the file first by truncating it
            fw.write("");
            fw.flush();

            // Write each order
            for (Order order : orders) {
                String orderStr = formatOrder(order);
                System.out.println("Writing order: " + orderStr);
                bw.write(orderStr);
                bw.newLine();
            }

            // Ensure data is written to disk
            bw.flush();
            System.out.println("File write completed successfully");

        } catch (IOException e) {
            System.err.println("Error writing orders file: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
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
}
