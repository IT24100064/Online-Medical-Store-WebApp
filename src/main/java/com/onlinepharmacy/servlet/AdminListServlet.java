package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.AdminUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.*;
import java.util.*;

public class AdminListServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/admins.txt";

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, ServletException {
        List<AdminUser> admins = new ArrayList<>();
        String path = getServletContext().getRealPath(FILE_PATH);
        File file = new File(path);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    admins.add(AdminUser.fromCSV(line));
                }
            }
        }
        req.setAttribute("admins", admins);
        req.getRequestDispatcher("/adminList.jsp").forward(req, resp);
    }
}
