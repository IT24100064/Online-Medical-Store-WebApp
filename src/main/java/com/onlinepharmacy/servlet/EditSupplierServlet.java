package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Supplier;
import com.onlinepharmacy.model.LocalSupplier;
import com.onlinepharmacy.model.InternationalSupplier;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditSupplierServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/suppliers.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("viewSuppliers");
            return;
        }
        Supplier supplier = findSupplierById(id, request);
        if (supplier == null) {
            response.sendRedirect("viewSuppliers");
            return;
        }
        request.setAttribute("supplier", supplier);
        request.getRequestDispatcher("/editSupplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String companyName = request.getParameter("companyName");
        String address = request.getParameter("address");
        String type = request.getParameter("type");
        Supplier original = findSupplierById(id, request);

        Supplier updated = null;
        if ("local".equals(type)) {
            String taxId = request.getParameter("taxId");
            updated = new LocalSupplier(id, name, email, phone, address, companyName, taxId);
        } else if ("international".equals(type)) {
            String importDuty = request.getParameter("importDuty");
            String country = request.getParameter("country");
            updated = new InternationalSupplier(id, name, email, phone, address, companyName, importDuty, country);
        } else {
            updated = new Supplier(id, name, email, phone, address, companyName);
        }

        updateSupplierInFile(original, updated, request);
        response.sendRedirect("viewSuppliers");
    }

    private Supplier findSupplierById(String id, HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);
        if (!file.exists()) return null;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Supplier s = Supplier.fromCSV(line);
                if (s != null && s.getId().equals(id)) return s;
            }
        }
        return null;
    }

    private void updateSupplierInFile(Supplier oldSupplier, Supplier newSupplier, HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);
        List<String> lines = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Supplier s = Supplier.fromCSV(line);
                if (s != null && s.getId().equals(oldSupplier.getId())) {
                    lines.add(newSupplier.toCSV());
                } else {
                    lines.add(line);
                }
            }
        }
        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            for (String l : lines) writer.println(l);
        }
    }
}
