package servlet;

import model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

public class AddMedicineServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/medicines.txt";
    private static final Pattern ID_PATTERN = Pattern.compile("^MC\\d{5}$");
    private static final Pattern PRICE_PATTERN = Pattern.compile("^\\d+(\\.\\d{1,2})?$");
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Trim and format inputs (manufacturer removed)
        String id = request.getParameter("id") != null ? request.getParameter("id").trim().toUpperCase() : "";
        String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        String priceStr = request.getParameter("price") != null ? request.getParameter("price").trim() : "";
        String quantityStr = request.getParameter("quantity") != null ? request.getParameter("quantity").trim() : "";
        String category = request.getParameter("category") != null ? request.getParameter("category").trim() : "";
        String manufacturingDate = request.getParameter("manufacturingDate") != null ? request.getParameter("manufacturingDate").trim() : "";
        String expiryDate = request.getParameter("expiryDate") != null ? request.getParameter("expiryDate").trim() : "";

        String saltComposition = request.getParameter("saltComposition") != null ?
                request.getParameter("saltComposition").trim() : "";
        String brandName = request.getParameter("brandName") != null ?
                request.getParameter("brandName").trim() : "";
        String prescriptionRequiredStr = request.getParameter("prescriptionRequired");

        // Validate required fields (manufacturer removed)
        if (id.isEmpty() || name.isEmpty() || priceStr.isEmpty() || quantityStr.isEmpty() ||
                category.isEmpty() || manufacturingDate.isEmpty() || expiryDate.isEmpty()) {
            sendError(request, response, "All required fields must be filled");
            return;
        }

        // Validate ID format (unchanged)
        if (!ID_PATTERN.matcher(id).matches()) {
            sendError(request, response, "Invalid ID format. Must be exactly 7 characters: 'MC' followed by 5 digits (e.g. MC12345)");
            return;
        }

        try {
            // ID uniqueness check (unchanged)
            if (!isIdUnique(id)) {
                sendError(request, response, "Medicine ID already exists");
                return;
            }

            // Price validation (unchanged)
            if (!PRICE_PATTERN.matcher(priceStr).matches()) {
                sendError(request, response, "Invalid price format. Use numbers with optional decimal (e.g. 10.99)");
                return;
            }
            double price = Double.parseDouble(priceStr);
            if (price <= 0) {
                sendError(request, response, "Price must be greater than 0");
                return;
            }

            // Quantity validation (unchanged)
            if (!quantityStr.matches("^\\d+$")) {
                sendError(request, response, "Quantity must be a whole number");
                return;
            }
            int quantity = Integer.parseInt(quantityStr);
            if (quantity <= 0) {
                sendError(request, response, "Quantity must be at least 1");
                return;
            }

            // Date validation (unchanged)
            DATE_FORMAT.setLenient(false);
            Date mfgDate = DATE_FORMAT.parse(manufacturingDate);
            Date expDate = DATE_FORMAT.parse(expiryDate);
            Date today = DATE_FORMAT.parse(DATE_FORMAT.format(new Date()));

            if (mfgDate.after(today)) {
                sendError(request, response, "Manufacturing date cannot be in the future");
                return;
            }
            if (!expDate.after(mfgDate)) {
                sendError(request, response, "Expiry date must be after manufacturing date");
                return;
            }

            // Category handling (fixed brand name usage)
            Medicine medicine;
            switch (category.toLowerCase()) {
                case "generic":
                    if (saltComposition.isEmpty()) {
                        sendError(request, response, "Salt composition is required for generic medicines");
                        return;
                    }
                    medicine = new GenericMedicine(id, name, price, quantity, manufacturingDate, expiryDate, saltComposition);
                    break;
                case "branded":
                    if (brandName.isEmpty()) {
                        sendError(request, response, "Brand name is required for branded medicines");
                        return;
                    }
                    if (prescriptionRequiredStr == null) {
                        sendError(request, response, "Please specify if prescription is required");
                        return;
                    }
                    boolean prescriptionRequired = Boolean.parseBoolean(prescriptionRequiredStr);
                    // Corrected constructor: manufacturer parameter replaced with brandName
                    medicine = new BrandedMedicine(id, name, price, quantity, brandName, manufacturingDate, expiryDate, prescriptionRequired);
                    break;
                default:
                    sendError(request, response, "Invalid medicine category");
                    return;
            }

            // Save to file (unchanged)
            String realPath = getServletContext().getRealPath(FILE_PATH);
            try (PrintWriter writer = new PrintWriter(new FileWriter(realPath, true))) {
                writer.println(medicine.toCSV());
            }

            response.sendRedirect("viewMedicines");
        } catch (NumberFormatException e) {
            sendError(request, response, "Invalid numeric format in price/quantity");
        } catch (ParseException e) {
            sendError(request, response, "Invalid date format. Use YYYY-MM-DD");
        } catch (Exception e) {
            sendError(request, response, "System error: " + e.getMessage());
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/addMedicine.jsp").forward(request, response);
    }

    private boolean isIdUnique(String id) throws IOException {
        String realPath = getServletContext().getRealPath(FILE_PATH);
        File file = new File(realPath);
        if (!file.exists()) return true;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            return reader.lines()
                    .map(line -> line.split(",", 2))
                    .noneMatch(parts -> parts.length > 0 && parts[0].equalsIgnoreCase(id));
        }
    }
}
