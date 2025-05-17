package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import com.onlinepharmacy.model.RegularUser;
import com.onlinepharmacy.model.User;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DeleteUserServlet extends HttpServlet {
    private static final String FILE_NAME = "/WEB-INF/data/users.txt";

    private synchronized List<User> loadUsers(ServletContext context) throws IOException {
        List<User> users = new ArrayList<>();
        String path = context.getRealPath(FILE_NAME);
        File file = new File(path);

        if (!file.exists()) return users;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length >= 5) {
                    String id = parts[0];
                    String username = parts[1];
                    String email = parts[2];
                    String password = parts[3];
                    String role = parts[4];

                    if ("Admin".equals(role)) {
                        users.add(new AdminUser(id, username, email, password));
                    } else if ("Regular".equals(role) && parts.length >= 9) {
                        String address = parts[5] + ", " + parts[6] + ", " + parts[7];
                        String contact = parts[8];
                        users.add(new RegularUser(id, username, email, password, address, contact));
                    }
                }
            }
        }
        return users;
    }

    private synchronized void saveUsers(List<User> users, ServletContext context) throws IOException {
        String path = context.getRealPath(FILE_NAME);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
            for (User user : users) {
                writer.write(user.toCSV());
                writer.newLine();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("id");

        if (userId != null) {
            List<User> users = loadUsers(getServletContext());

            // Remove user by ID
            users.removeIf(user -> user.getId().equals(userId));

            // Save updated list back to file
            saveUsers(users, getServletContext());
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
