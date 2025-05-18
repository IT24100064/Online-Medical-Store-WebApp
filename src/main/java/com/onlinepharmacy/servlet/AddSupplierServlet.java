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
                
}
