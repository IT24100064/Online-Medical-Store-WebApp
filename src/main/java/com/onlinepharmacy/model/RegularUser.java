package com.onlinepharmacy.model;

public class RegularUser extends User {
    private String address;
    private String contact;

    public RegularUser(String id, String username, String email, String password,
                       String address, String contact) {
        super(id, username, email, password, "Regular");
        this.address = address;
        this.contact = contact;
    }

    // Getters
    public String getAddress() { return address; }
    public String getContact() { return contact; }

    @Override
    public String toCSV() {
        return String.join(",",
                id, username, email, password, role,
                address,  // No splitting here
                contact
        );
    }
}
