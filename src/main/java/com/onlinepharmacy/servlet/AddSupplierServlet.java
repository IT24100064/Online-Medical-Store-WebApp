package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Supplier;
import com.onlinepharmacy.model.LocalSupplier;
import com.onlinepharmacy.model.InternationalSupplier;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class AddSupplierServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/suppliers.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> errors = new HashMap<>();

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String companyName = request.getParameter("companyName");
        String type = request.getParameter("type");

        // Validate required fields
        if (id == null || id.trim().isEmpty()) errors.put("id", "Supplier ID is required");
        if (name == null || name.trim().isEmpty()) errors.put("name", "Name is required");
        if (email == null || email.trim().isEmpty()) errors.put("email", "Email is required");
        if (phone == null || phone.trim().isEmpty()) errors.put("phone", "Phone is required");
        if (address == null || address.trim().isEmpty()) errors.put("address", "Address is required");
        if (companyName == null || companyName.trim().isEmpty()) errors.put("companyName", "Company Name is required");
        if (type == null || type.trim().isEmpty()) errors.put("type", "Supplier Type is required");

        // Check ID uniqueness
        if (errors.isEmpty() && !isIdUnique(id, request)) {
            errors.put("id", "Supplier ID already exists");
        }

        Supplier supplier = null;
        if (errors.isEmpty()) {
            if ("local".equals(type)) {
                String taxId = request.getParameter("taxId");
                if (taxId == null || taxId.trim().isEmpty()) {
                    errors.put("taxId", "Tax ID is required for Local Supplier");
                } else {
                    supplier = new LocalSupplier(id, name, email, phone, address, companyName, taxId);
                }
            } else if ("international".equals(type)) {
                String importDuty = request.getParameter("importDuty");
                String country = request.getParameter("country");
                if (importDuty == null || importDuty.trim().isEmpty()) {
                    errors.put("importDuty", "Import Duty is required for International Supplier");
                }
                if (country == null || country.trim().isEmpty()) {
                    errors.put("country", "Country is required for International Supplier");
                }
                if (errors.isEmpty()) {
                    supplier = new InternationalSupplier(id, name, email, phone, address, companyName, importDuty, country);
                }
            } else {
                supplier = new Supplier(id, name, email, phone, address, companyName);
            }
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/addSupplier.jsp").forward(request, response);
            return;
        }

        if (saveSupplier(supplier, request)) {
            response.sendRedirect("viewSuppliers");
        } else {
            errors.put("general", "Error saving supplier");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/addSupplier.jsp").forward(request, response);
        }
    }

    private boolean isIdUnique(String id, HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);
        if (!file.exists()) return true;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 2);
                if (parts.length > 0 && parts[0].equals(id)) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean saveSupplier(Supplier supplier, HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        try (PrintWriter writer = new PrintWriter(new FileWriter(file, true))) {
            writer.println(supplier.toCSV());
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
