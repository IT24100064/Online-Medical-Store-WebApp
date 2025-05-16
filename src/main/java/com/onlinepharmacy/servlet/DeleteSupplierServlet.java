package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Supplier;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DeleteSupplierServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/suppliers.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("viewSuppliers?error=Invalid ID");
            return;
        }

        List<Supplier> validSuppliers = new ArrayList<>();
        String realPath = getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    Supplier s = Supplier.fromCSV(line);
                    if (s != null) {  // Skip invalid entries
                        if (!s.getId().equals(id)) {
                            validSuppliers.add(s);
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("viewSuppliers?error=Error reading suppliers");
                return;
            }
        }

        // Write back valid entries
        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            for (Supplier s : validSuppliers) {
                writer.println(s.toCSV());
            }
            response.sendRedirect("viewSuppliers?success=Supplier deleted");
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("viewSuppliers?error=Error saving changes");
        }
    }
}
