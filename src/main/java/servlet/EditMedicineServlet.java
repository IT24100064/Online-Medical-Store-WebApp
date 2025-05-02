package servlet;

import model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditMedicineServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/medicines.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("viewMedicines");
            return;
        }

        Medicine medicine = loadMedicineById(id);
        if (medicine == null) {
            response.sendRedirect("viewMedicines");
            return;
        }

        request.setAttribute("medicine", medicine);
        request.getRequestDispatcher("/editMedicine.jsp").forward(request, response);
    }

    private Medicine loadMedicineById(String id) throws IOException {
        String realPath = getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);

        if (!file.exists()) return null;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Medicine med = Medicine.fromCSV(line);
                // Added null checks for med and med.getId()
                if (med != null && med.getId() != null && med.getId().equals(id)) {
                    return med;
                }
            }
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String category = request.getParameter("category");
        String manufacturer = request.getParameter("manufacturer");
        String expiryDate = request.getParameter("expiryDate");

        String saltComposition = request.getParameter("saltComposition");
        String brandName = request.getParameter("brandName");
        String prescriptionRequiredStr = request.getParameter("prescriptionRequired");

        // Validate required fields
        if (id == null || name == null || priceStr == null || quantityStr == null ||
                category == null || manufacturer == null || expiryDate == null ||
                id.isEmpty() || name.isEmpty() || priceStr.isEmpty() || quantityStr.isEmpty() ||
                category.isEmpty() || manufacturer.isEmpty() || expiryDate.isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/editMedicine.jsp").forward(request, response);
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            Medicine updatedMedicine;
            switch (category.toLowerCase()) {
                case "generic":
                    updatedMedicine = new GenericMedicine(id, name, price, quantity, manufacturer, expiryDate, saltComposition);
                    break;
                case "branded":
                    boolean prescriptionRequired = Boolean.parseBoolean(prescriptionRequiredStr);
                    updatedMedicine = new BrandedMedicine(id, name, price, quantity, manufacturer, expiryDate, brandName, prescriptionRequired);
                    break;
                default:
                    // Use regular constructor instead of anonymous class
                    updatedMedicine = new Medicine(id, name, price, quantity, category, manufacturer, expiryDate) {
                        @Override
                        public String getDescription() {
                            return "";
                        }
                    };
            }

            // Update medicine list
            String realPath = getServletContext().getRealPath(FILE_PATH);
            File file = new File(realPath);
            List<Medicine> medicines = new ArrayList<>();

            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        Medicine m = Medicine.fromCSV(line);
                        // Add null checks for m and m.getId()
                        if (m != null && m.getId() != null && !m.getId().equals(id)) {
                            medicines.add(m);
                        }
                    }
                }
            }
            medicines.add(updatedMedicine);

            // Write back to file
            try (PrintWriter writer = new PrintWriter(new FileWriter(file, false))) {
                for (Medicine m : medicines) {
                    writer.println(m.toCSV());
                }
            }

            response.sendRedirect("viewMedicines");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or quantity format");
            request.getRequestDispatcher("/editMedicine.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error updating medicine: " + e.getMessage());
            request.getRequestDispatcher("/editMedicine.jsp").forward(request, response);
        }
    }
}
