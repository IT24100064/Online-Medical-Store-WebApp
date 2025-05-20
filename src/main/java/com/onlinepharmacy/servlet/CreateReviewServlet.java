package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.UUID;

public class CreateReviewServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineName = request.getParameter("medicineName");
        String customerName = request.getParameter("customerName");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        String orderId = request.getParameter("orderId");

        String reviewId = UUID.randomUUID().toString();
        Review review;

        if (orderId != null && !orderId.isEmpty()) {
            review = new VerifiedReview(reviewId, medicineName, customerName, rating, comment, orderId);
        } else {
            review = new PublicReview(reviewId, medicineName, customerName, rating, comment, "");
        }

        String path = getServletContext().getRealPath(FILE_PATH);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
            writer.write(review.toCSVString());
            writer.newLine();
        }

        response.sendRedirect("viewReviews");
    }
}
