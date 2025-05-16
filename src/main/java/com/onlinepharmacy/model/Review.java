package com.onlinepharmacy.model;

import java.time.LocalDateTime;

public class Review {
    protected String reviewId;
    protected String medicineName;
    protected String customerName;
    protected int rating;
    protected String comment;
    protected String orderId;
    protected boolean verified;
    protected LocalDateTime timestamp;
    protected String status; // PENDING, APPROVED, REJECTED

    public Review(String reviewId, String medicineName, String customerName, int rating, String comment, String orderId) {
        this.reviewId = reviewId;
        this.medicineName = medicineName;
        this.customerName = customerName;
        this.rating = rating;
        this.comment = comment;
        this.orderId = orderId;
        this.verified = false;
        this.timestamp = LocalDateTime.now();
        this.status = "PENDING";
    }

    // Getters
    public String getReviewId() { return reviewId; }
    public String getMedicineName() { return medicineName; }
    public String getCustomerName() { return customerName; }
    public int getRating() { return rating; }
    public String getComment() { return comment; }
    public String getOrderId() { return orderId; }
    public boolean isVerified() { return verified; }
    public LocalDateTime getTimestamp() { return timestamp; }
    public String getStatus() { return status; }

    // Setters
    public void setReviewId(String reviewId) { this.reviewId = reviewId; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public void setRating(int rating) { this.rating = rating; }
    public void setComment(String comment) { this.comment = comment; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public void setVerified(boolean verified) { this.verified = verified; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
    public void setStatus(String status) { this.status = status; }

    // Utility Methods
    public void updateReview(int rating, String comment) {
        this.rating = rating;
        this.comment = comment;
        this.status = "PENDING"; // reset status after update
    }

    public String toCSVString() {
        return String.join(",",
                reviewId,
                medicineName,
                customerName,
                String.valueOf(rating),
                comment.replace(",", ";comma;"),
                orderId,
                String.valueOf(verified),
                timestamp.toString(),
                status
        );
    }

    public static Review fromCSVString(String csvLine) {
        String[] parts = csvLine.split(",", 9);
        if (parts.length < 9) return null;

        Review review = new Review(parts[0], parts[1], parts[2], Integer.parseInt(parts[3]), parts[4].replace(";comma;", ","), parts[5]);
        review.setVerified(Boolean.parseBoolean(parts[6]));
        review.setTimestamp(LocalDateTime.parse(parts[7]));
        review.setStatus(parts[8]);
        return review;
    }

    public String display() {
        return String.format("%s - %d Stars: %s", medicineName, rating, comment);
    }
}
