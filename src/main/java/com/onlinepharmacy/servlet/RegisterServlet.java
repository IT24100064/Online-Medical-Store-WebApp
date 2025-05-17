package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import com.onlinepharmacy.model.RegularUser;
import com.onlinepharmacy.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final String FILE_NAME = "/WEB-INF/data/users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String id = UUID.randomUUID().toString();

        if (username == null || email == null || password == null || role == null || username.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=MissingFields");
            return;
        }

        User user = null;

        if ("Admin".equalsIgnoreCase(role)) {
            user = new AdminUser(id, username, email, password);
        } else if ("Regular".equalsIgnoreCase(role)) {
            String address = request.getParameter("address");
            String contact = request.getParameter("contact");

            if (address == null || contact == null || address.trim().isEmpty() || !contact.matches("\\d{10}")) {
                response.sendRedirect("register.jsp?error=InvalidContact");
                return;
            }

            user = new RegularUser(id, username, email, password, address, contact);
        } else {
            response.sendRedirect("register.jsp?error=InvalidRole");
            return;
        }

        // Write to file
        String filePath = getServletContext().getRealPath(FILE_NAME);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(user.toCSV());
            writer.newLine();
        } catch (IOException e) {
            response.sendRedirect("register.jsp?error=FileWriteError");
            return;
        }

        // Add user to session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);

        response.sendRedirect(role.equalsIgnoreCase("Admin") ? "adminDashboard.jsp" : "userDashboard.jsp");
    }
}
