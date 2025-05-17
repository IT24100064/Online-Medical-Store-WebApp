package com.onlinepharmacy.model;

public class InternationalSupplier extends Supplier {
    private String importDuty;
    private String country;

    public InternationalSupplier(String id, String name, String email, String phone, String address, String companyName, String importDuty, String country) {
        super(id, name, email, phone, address, companyName);
        this.importDuty = importDuty;
        this.country = country;
    }

}
