package com.onlinepharmacy.model;


import java.io.Serializable;

public class Medicine implements Serializable {
    private static final long serialVersionUID = 1L;

    private String name;
    private int quantity;

    public Medicine() {}

    public Medicine(String name, int quantity) {
        this.name = name;
        this.quantity = quantity;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
