package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import com.onlinepharmacy.model.RegularUser;
import com.onlinepharmacy.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class LoginServlet extends HttpServlet {
    private static final String FILE_NAME = "/WEB-INF/data/users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get and sanitize inputs
        String email = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String role = request.getParameter("role").trim();

        String filePath = getServletContext().getRealPath(FILE_NAME);
        System.out.println("User file path: " + filePath); // Debugging

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;

                String[] parts = line.split(",", -1);
                System.out.println("Processing line: " + line); // Debugging

                if (validateAdmin(parts, role, email, password)) {
                    User user = new AdminUser(
                            parts[1],  // firstName
                            "",        // lastName (not in data)
                            parts[2],  // email
                            parts[4]   // role
                    );
                    request.getSession().setAttribute("currentUser", user);
                    response.sendRedirect("adminDashboard.jsp");
                    return;
                }
                else if (validateRegular(parts, role, email, password)) {
                    String address = parts[5] + ", " + parts[6] + ", " + parts[7];
                    User user = new RegularUser(
                            parts[1],  // firstName
                            "",        // lastName (not in data)
                            parts[2],  // email
                            parts[8],  // phone
                            address,
                            parts[4]   // role
                    );
                    request.getSession().setAttribute("currentUser", user);
                    response.sendRedirect("userDashboard.jsp");
                    return;
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading user file: " + e.getMessage());
            response.sendRedirect("login.jsp?error=Server+error");
            return;
        }

        // No matching user found
        response.sendRedirect("login.jsp?error=Invalid+credentials");
    }

    private boolean validateAdmin(String[] parts, String role, String email, String pass) {
        return parts.length >= 5 &&
                "Admin".equalsIgnoreCase(role) &&
                parts.length >= 5 &&
                parts[2].equalsIgnoreCase(email) &&
                parts[3].equals(pass);
    }

    private boolean validateRegular(String[] parts, String role, String email, String pass) {
        return parts.length >= 9 &&
                "Regular".equalsIgnoreCase(role) &&
                parts[2].equalsIgnoreCase(email) &&
                parts[3].equals(pass);
    }
}
