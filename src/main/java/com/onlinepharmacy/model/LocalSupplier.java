package com.onlinepharmacy.model;

public class LocalSupplier extends Supplier {
    private String taxId;

    public LocalSupplier(String id, String name, String email, String phone, String address, String companyName, String taxId) {
        super(id, name, email, phone, address, companyName);
        this.taxId = taxId;
    }

    public String getTaxId() { return taxId; }

    @Override
    public String toCSV() {
        return String.join(",", id, name, email, phone, address, companyName, taxId, "", "");
    }
}
