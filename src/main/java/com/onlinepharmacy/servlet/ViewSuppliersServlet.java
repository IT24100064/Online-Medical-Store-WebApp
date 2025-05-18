package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Supplier;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class ViewSuppliersServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/suppliers.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Supplier> suppliers = loadSuppliers(request);
            String searchQuery = request.getParameter("search");

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                suppliers = searchSuppliers(suppliers, searchQuery.trim());
            }

            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("/viewSuppliers.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading suppliers: " + e.getMessage(), e);
        }
    }

    private List<Supplier> loadSuppliers(HttpServletRequest request) throws IOException {
        List<Supplier> suppliers = new ArrayList<>();
        String realPath = request.getServletContext().getRealPath(FILE_PATH);
        System.out.println("[DEBUG] Suppliers file path: " + realPath);

        File file = new File(realPath);
        if (!file.exists()) {
            System.err.println("[ERROR] Suppliers file not found at: " + realPath);
            return suppliers;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Supplier supplier = Supplier.fromCSV(line);
                    if (supplier != null) {
                        suppliers.add(supplier);
                    }
                } catch (Exception e) {
                    System.err.println("[ERROR] Failed to parse line: " + line);
                    e.printStackTrace();
                }
            }
        }
        return suppliers;
    }

    private List<Supplier> searchSuppliers(List<Supplier> suppliers, String query) {
        List<Supplier> results = new ArrayList<>();
        String lowerQuery = query.toLowerCase();

        for (Supplier s : suppliers) {
            if (s.getName().toLowerCase().contains(lowerQuery) ||
                    s.getEmail().toLowerCase().contains(lowerQuery) ||
                    s.getCompanyName().toLowerCase().contains(lowerQuery)) {
                results.add(s);
            }
        }
        return results;
    }
}
