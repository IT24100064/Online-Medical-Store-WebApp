package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.*;
import java.util.*;
import java.util.regex.Pattern;

public class AdminUpdateServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/admins.txt";
    private static final Pattern EMAIL_REGEX =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern PASSWORD_REGEX =
            Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,20}$");
    private static final Set<String> VALID_PERMISSIONS =
            Set.of("MANAGE_USERS", "VIEW_LOGS", "MANAGE_INVENTORY", "VIEW_REPORTS", "ADMISSION");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String employeeId = req.getParameter("employeeId");
        AdminUser admin = null;
        String path = getServletContext().getRealPath(FILE_PATH);

        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                AdminUser a = AdminUser.fromCSV(line);
                if (a.getEmployeeId().equals(employeeId)) {
                    admin = a;
                    break;
                }
            }
        }

        // Permissions list (must match VALID_PERMISSIONS)
        List<String> allPermissions = new ArrayList<>(VALID_PERMISSIONS);
        req.setAttribute("allPermissions", allPermissions);
        req.setAttribute("admin", admin);
        req.getRequestDispatcher("/adminUpdate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String employeeId = req.getParameter("employeeId"); // This remains unchanged
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String[] permissionsSelected = req.getParameterValues("permissions");

        Map<String, String> errors = new HashMap<>();
        List<String> preservedPermissions = new ArrayList<>();

        // Validate fields
        username = validateUsername(username, errors);
        password = validatePassword(password, errors);
        email = validateEmail(email, errors);
        permissionsSelected = validatePermissions(permissionsSelected, errors, preservedPermissions);

        // Find the admin to update
        List<AdminUser> admins = new ArrayList<>();
        AdminUser adminToUpdate = null;
        String path = getServletContext().getRealPath(FILE_PATH);

        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                AdminUser admin = AdminUser.fromCSV(line);
                if (admin.getEmployeeId().equals(employeeId)) {
                    adminToUpdate = admin;
                }
                admins.add(admin);
            }
        }

        if (!errors.isEmpty()) {
            // Set up preserved data for redisplay
            req.setAttribute("errors", errors);
            req.setAttribute("allPermissions", new ArrayList<>(VALID_PERMISSIONS));
            req.setAttribute("admin", adminToUpdate);
            req.setAttribute("preservedUsername", username);
            req.setAttribute("preservedEmail", email);
            req.setAttribute("preservedPermissions", preservedPermissions);
            req.getRequestDispatcher("/adminUpdate.jsp").forward(req, resp);
            return;
        }

        // Update the admin in the list
        for (AdminUser admin : admins) {
            if (admin.getEmployeeId().equals(employeeId)) {
                admin.setUsername(username);
                admin.setPassword(password);
                admin.setEmail(email);
                admin.setPermissions(new ArrayList<>(preservedPermissions));
                admin.logActivity("Profile updated");
            }
        }

        // Write back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, false))) {
            for (AdminUser admin : admins) {
                writer.write(admin.toCSV());
                writer.newLine();
            }
        }

        resp.sendRedirect("adminList");
    }

    private String validateUsername(String username, Map<String, String> errors) {
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Username required");
            return username;
        }
        String cleaned = username.trim();
        if (cleaned.length() < 4 || cleaned.length() > 15) {
            errors.put("username", "Must be 4-15 characters");
        }
        return cleaned;
    }

    private String validatePassword(String password, Map<String, String> errors) {
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password required");
            return password;
        }
        if (!PASSWORD_REGEX.matcher(password).matches()) {
            errors.put("password", "8-20 chars with uppercase, lowercase, and number");
        }
        return password.trim();
    }

    private String validateEmail(String email, Map<String, String> errors) {
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email required");
            return email;
        }
        String cleaned = email.trim();
        if (!EMAIL_REGEX.matcher(cleaned).matches()) {
            errors.put("email", "Invalid email format");
        }
        return cleaned;
    }

    private String[] validatePermissions(String[] permissions, Map<String, String> errors, List<String> preserved) {
        if (permissions == null || permissions.length == 0) {
            errors.put("permissions", "At least one permission must be selected.");
        } else {
            for (String p : permissions) {
                if (!VALID_PERMISSIONS.contains(p)) {
                    errors.put("permissions", "Invalid permission selected");
                    break;
                }
            }
            preserved.addAll(Arrays.asList(permissions));
        }
        return permissions;
    }
}
