package com.onlinepharmacy.model;

public class PublicReview extends Review {

    public PublicReview(String reviewId, String medicineName, String customerName, int rating, String comment, String orderId) {
        super(reviewId, medicineName, customerName, rating, comment, orderId);
        this.setVerified(false);
    }

    @Override
    public String display() {
        return String.format("Public Review by %s: %d Stars - %s", customerName, rating, comment);
    }
}
