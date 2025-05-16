package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.*;
import java.util.*;
import java.util.regex.Pattern;

public class AdminCreateServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/admins.txt";
    private static final Pattern EMPLOYEE_ID_REGEX =
            Pattern.compile("^ID\\d{5}$");
    private static final Pattern EMAIL_REGEX =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern PASSWORD_REGEX =
            Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,20}$");
    // --- ALL VALID PERMISSIONS (must match JSP) ---
    private static final Set<String> VALID_PERMISSIONS =
            Set.of("MANAGE_USERS", "VIEW_LOGS", "MANAGE_INVENTORY", "VIEW_REPORTS", "ADMISSION");

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, ServletException {

        Map<String, String> errors = new HashMap<>();
        List<String> preservedPermissions = new ArrayList<>();

        // Get and validate parameters
        String employeeId = validateEmployeeId(req.getParameter("employeeId"), errors, req);
        String username = validateUsername(req.getParameter("username"), errors);
        String password = validatePassword(req.getParameter("password"), errors);
        String email = validateEmail(req.getParameter("email"), errors);
        String[] permissions = validatePermissions(req, errors, preservedPermissions);

        if (!errors.isEmpty()) {
            preserveFormData(req, employeeId, username, email, preservedPermissions);
            req.setAttribute("errors", errors);

            // Also set allPermissions for JSP if not set
            List<String> allPermissions = new ArrayList<>(VALID_PERMISSIONS);
            req.setAttribute("allPermissions", allPermissions);

            req.getRequestDispatcher("/adminCreate.jsp").forward(req, resp);
            return;
        }

        AdminUser admin = new AdminUser(employeeId, username, password, email);
        if (permissions != null) {
            for (String permission : permissions) {
                admin.addPermission(permission);
            }
        }

        admin.logActivity("Admin account created");

        String path = getServletContext().getRealPath(FILE_PATH);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
            writer.write(admin.toCSV());
            writer.newLine();
        } catch (IOException e) {
            errors.put("system", "Error saving admin data. Please try again.");
            req.setAttribute("errors", errors);

            // Also set allPermissions for JSP if not set
            List<String> allPermissions = new ArrayList<>(VALID_PERMISSIONS);
            req.setAttribute("allPermissions", allPermissions);

            req.getRequestDispatcher("/adminCreate.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect("adminList");
    }

    private String validateEmployeeId(String empId, Map<String, String> errors, HttpServletRequest req) {
        if (empId == null || empId.trim().isEmpty()) {
            errors.put("employeeId", "Employee ID cannot be empty");
            return empId;
        }

        String cleaned = empId.trim();

        if (!EMPLOYEE_ID_REGEX.matcher(cleaned).matches()) {
            errors.put("employeeId", "Format must be ID followed by 5 digits (e.g. ID12345)");
            return cleaned;
        }

        if (isEmployeeIdExists(cleaned, req)) {
            errors.put("employeeId", "ID already exists in system");
        }

        return cleaned;
    }

    private boolean isEmployeeIdExists(String empId, HttpServletRequest req) {
        try {
            String path = getServletContext().getRealPath(FILE_PATH);
            File file = new File(path);
            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
                    return reader.lines()
                            .map(AdminUser::fromCSV)
                            .anyMatch(admin -> admin.getEmployeeId().equals(empId));
                }
            }
        } catch (IOException e) {
            System.err.println("Error checking employee ID: " + e.getMessage());
        }
        return false;
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

    private String[] validatePermissions(HttpServletRequest req,
                                         Map<String, String> errors,
                                         List<String> preserved) {
        String[] permissions = req.getParameterValues("permissions");
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

    private void preserveFormData(HttpServletRequest req, String empId,
                                  String username, String email,
                                  List<String> permissions) {
        req.setAttribute("preservedEmployeeId", empId);
        req.setAttribute("preservedUsername", username);
        req.setAttribute("preservedEmail", email);
        req.setAttribute("preservedPermissions", permissions);
    }
}
