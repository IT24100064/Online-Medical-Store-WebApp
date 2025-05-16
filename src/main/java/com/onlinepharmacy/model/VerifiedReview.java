package com.onlinepharmacy.model;

public class VerifiedReview extends Review {
    public VerifiedReview(String reviewId, String medicineName, String customerName, int rating, String comment, String orderId) {
        super(reviewId, medicineName, customerName, rating, comment, orderId);
        this.verified = true;
    }

    @Override
    public String display() {
        return String.format("Verified Review by %s: %d Stars - %s", customerName, rating, comment);
    }
}