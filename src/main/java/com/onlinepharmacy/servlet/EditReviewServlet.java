package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditReviewServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reviewId = request.getParameter("reviewId");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        String path = getServletContext().getRealPath(FILE_PATH);
        List<Review> reviews = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Review review = Review.fromCSVString(line);
                if (review != null) {
                    if (review.getReviewId().equals(reviewId)) {
                        review.updateReview(rating, comment);
                    }
                    reviews.add(review);
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, false))) {
            for (Review review : reviews) {
                writer.write(review.toCSVString());
                writer.newLine();
            }
        }

        response.sendRedirect("viewReviews");
    }
}
