package com.onlinepharmacy.servlet;

import com.onlinepharmacy.model.Review;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/viewReviews")
public class ViewReviewsServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/data/reviews.txt";

    @Override

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String path = getServletContext().getRealPath(FILE_PATH);
        List<Review> approvedReviews = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Review review = Review.fromCSVString(line);
                if (review != null && "APPROVED".equalsIgnoreCase(review.getStatus())) {
                    approvedReviews.add(review);
                }
            }
        }

        request.setAttribute("reviews", approvedReviews);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewReviews.jsp");
        dispatcher.forward(request, response);
    }
}
