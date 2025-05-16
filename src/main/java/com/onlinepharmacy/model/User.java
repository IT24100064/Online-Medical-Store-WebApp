package com.onlinepharmacy.model;

public abstract class User {
    private String employeeId;
    private String username;
    private String password;
    private String email;

    public User(String employeeId, String username, String password, String email) {
        this.employeeId = employeeId;
        this.username = username;
        this.password = password;
        this.email = email;
    }

    // Getters & Setters
    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
