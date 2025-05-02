package servlet;

import model.Medicine;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class SortMedicineServlet extends HttpServlet {
    private static final String DATA_FILE = "/WEB-INF/data/medicines.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Medicine> medicines = readMedicinesFromFile();
            quickSortByPrice(medicines, 0, medicines.size() - 1);
            request.setAttribute("medicines", medicines);
            request.getRequestDispatcher("/viewMedicines.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error sorting medicines", e);
        }
    }

    private List<Medicine> readMedicinesFromFile() throws IOException {
        List<Medicine> medicines = new ArrayList<>();
        String realPath = getServletContext().getRealPath(DATA_FILE);
        File file = new File(realPath);

        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
            return medicines;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                medicines.add(Medicine.fromCSV(line));
            }
        }
        return medicines;
    }

    // QuickSort implementation (divide-and-conquer algorithm)
    private void quickSortByPrice(List<Medicine> medicines, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(medicines, low, high);
            quickSortByPrice(medicines, low, pivotIndex - 1);
            quickSortByPrice(medicines, pivotIndex + 1, high);
        }
    }

    private int partition(List<Medicine> medicines, int low, int high) {
        double pivot = medicines.get(high).getPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (medicines.get(j).getPrice() < pivot) {
                i++;
                Collections.swap(medicines, i, j);
            }
        }
        Collections.swap(medicines, i + 1, high);
        return i + 1;
    }
}
