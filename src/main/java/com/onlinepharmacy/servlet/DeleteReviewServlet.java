package com.onlinepharmacy.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;
import com.onlinepharmacy.model.Review;

@WebServlet("/deleteReview")
public class DeleteReviewServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reviewIdToDelete = request.getParameter("reviewId");
        String path = getServletContext().getRealPath(FILE_PATH);

        File inputFile = new File(path);
        File tempFile = new File(path + ".tmp");

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             PrintWriter writer = new PrintWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                Review review = Review.fromCSVString(line);
                if (review != null && !review.getReviewId().equals(reviewIdToDelete)) {
                    writer.println(line);
                }
            }
        }

        // Replace original file with updated temp file
        if (!inputFile.delete()) {
            throw new IOException("Could not delete original file.");
        }
        if (!tempFile.renameTo(inputFile)) {
            throw new IOException("Could not rename temporary file.");
        }

        // Redirect back to the viewReviews servlet
        response.sendRedirect("viewReviews");
    }
}
