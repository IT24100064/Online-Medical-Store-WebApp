package servlet;

import model.Medicine;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class ViewMedicineServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/medicines.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Medicine> medicines = loadMedicines();
        String sortBy = request.getParameter("sortBy");
        if ("price".equals(sortBy)) {
            medicines.sort(Comparator.comparingDouble(Medicine::getPrice));
        }
        request.setAttribute("medicines", medicines);
        request.getRequestDispatcher("/viewMedicines.jsp").forward(request, response);
    }

    private List<Medicine> loadMedicines() throws IOException {
        List<Medicine> medicines = new ArrayList<>();
        String realPath = getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    medicines.add(Medicine.fromCSV(line));
                }
            }
        }
        return medicines;
    }
}
