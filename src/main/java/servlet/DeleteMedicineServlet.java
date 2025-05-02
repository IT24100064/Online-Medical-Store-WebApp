package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DeleteMedicineServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/medicines.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("viewMedicines");
            return;
        }

        List<String> lines = new ArrayList<>();
        String realPath = getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.startsWith(id + ",")) {
                        lines.add(line);
                    }
                }
            }
        }

        try (PrintWriter writer = new PrintWriter(new FileWriter(file, false))) {
            for (String l : lines) {
                writer.println(l);
            }
        }
        response.sendRedirect("viewMedicines");
    }
}
