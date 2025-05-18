package com.onlinepharmacy.model;

public class Supplier {
    protected String id;
    protected String name;
    protected String email;
    protected String phone;
    protected String address;
    protected String companyName;

    public Supplier(String id, String name, String email, String phone, String address, String companyName) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.companyName = companyName;
    }

    // Getters
    public String getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    public String getCompanyName() { return companyName; }

    public String toCSV() {
        return String.join(",", id, name, email, phone, address, companyName, "", "", "");
    }

    public static Supplier fromCSV(String line) {
        String[] parts = line.split(",", -1); // Keep empty fields
        if (parts.length < 9) return null; // Invalid line

        // Local Supplier: taxId at index 6
        if (!parts[6].isEmpty()) {
            return new LocalSupplier(
                    parts[0], parts[1], parts[2], parts[3],
                    parts[4], parts[5], parts[6]
            );
        }
        // International Supplier: importDuty (7) and country (8)
        else if (!parts[7].isEmpty() && !parts[8].isEmpty()) {
            return new InternationalSupplier(
                    parts[0], parts[1], parts[2], parts[3],
                    parts[4], parts[5], parts[7], parts[8]
            );
        }
        // Base Supplier
        else {
            return new Supplier(
                    parts[0], parts[1], parts[2],
                    parts[3], parts[4], parts[5]
            );
        }
    }
}
