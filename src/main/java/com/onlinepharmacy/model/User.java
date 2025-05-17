package com.onlinepharmacy.model;

public abstract class User {
    protected String id;
    protected String username;
    protected String email;
    protected String password;
    protected String role;

    public User(String id, String username, String email, String password, String role) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getters
    public String getId() { return id; }
    public String getUsername() { return username; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getRole() { return role; }

    // Setters for updatable fields
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }

    // Abstract method for CSV serialization
    public abstract String toCSV();
}
