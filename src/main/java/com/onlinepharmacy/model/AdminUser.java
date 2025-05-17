package com.onlinepharmacy.model;

public class AdminUser extends User {
    public AdminUser(String id, String username, String email, String password) {
        super(id, username, email, password, "Admin");
    }

    @Override
    public String toCSV() {
        return String.join(",", id, username, email, password, role);
    }
}
