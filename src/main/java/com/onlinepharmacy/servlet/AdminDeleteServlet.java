package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;

public class AdminDeleteServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/admins.txt";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String employeeId = req.getParameter("employeeId");

        List<AdminUser> admins = new ArrayList<>();
        String path = getServletContext().getRealPath(FILE_PATH);
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                AdminUser admin = AdminUser.fromCSV(line);
                if (!admin.getEmployeeId().equals(employeeId)) {
                    admins.add(admin);
                }
            }
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, false))) {
            for (AdminUser admin : admins) {
                writer.write(admin.toCSV());
                writer.newLine();
            }
        }
        resp.sendRedirect("adminList");
    }
}
