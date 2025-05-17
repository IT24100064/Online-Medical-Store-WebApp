package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import com.onlinepharmacy.model.RegularUser;
import com.onlinepharmacy.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class UserManagementServlet extends HttpServlet {
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
                    }
                    else if ("Regular".equals(role) && parts.length == 9) {
                        String address = parts[5] + ", " + parts[6] + ", " + parts[7];
                        String contact = parts[8];
                        users.add(new RegularUser(id, username, email, password, address, contact));
                    }
                }
            }
        }
        return users;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<User> users = loadUsers(getServletContext());
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
        } catch (IOException e) {
            handleError(request, response, "Error loading users: " + e.getMessage());
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }
}
