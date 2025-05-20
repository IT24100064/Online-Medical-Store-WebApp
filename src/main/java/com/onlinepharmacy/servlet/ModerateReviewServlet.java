package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Review;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class ModerateReviewServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reviewId = request.getParameter("reviewId");
        String action = request.getParameter("action");

        String path = getServletContext().getRealPath(FILE_PATH);
        List<Review> updatedReviews = new ArrayList<>();

        // Read and update reviews
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Review review = Review.fromCSVString(line);
                if (review != null) {
                    if (review.getReviewId().equals(reviewId)) {
                        switch (action) {
                            case "approve":
                                review.setStatus("APPROVED");
                                break;
                            case "reject":
                                review.setStatus("REJECTED");
                                break;
                            case "delete":
                                continue; // Skip the review (do not add)
                        }
                    }
                    updatedReviews.add(review);
                }
            }
        }

        // Write back updated reviews
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, false))) {
            for (Review review : updatedReviews) {
                writer.write(review.toCSVString());
                writer.newLine();
            }
        }

        // ✅ Redirect to ViewReviews servlet (which will forward to viewReviews.jsp)
        response.sendRedirect("viewReviews");
    }
}
