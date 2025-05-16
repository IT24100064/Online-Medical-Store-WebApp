package model;


import java.io.Serializable;

public abstract class Medicine implements Serializable {
    private String id;
    private String name;
    private double price;
    private int quantity;
    private String category;
    private String manufacturer; // For BrandedMedicine: manufactureDate
    private String expiryDate;

    public Medicine(String id, String name, double price, int quantity,
                    String category, String manufacturer, String expiryDate) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.category = category;
        this.manufacturer = manufacturer;
        this.expiryDate = expiryDate;
    }

    public Medicine() {}

    // Getters and setters...

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

    public abstract String getDescription();

    protected String getSpecificCSV() { return ""; }

    public String toCSV() {
        return String.join(",",
                safe(id), safe(name), String.valueOf(price), String.valueOf(quantity),
                safe(category), safe(manufacturer), safe(expiryDate), getSpecificCSV()
        );
    }

    private String safe(String s) {
        return (s == null) ? "" : s;
    }

    public static Medicine fromCSV(String csv) {
        String[] parts = csv.split(",", -1); // Keep empty strings
        if (parts.length < 7) return null;

        try {
            String id = emptyToNull(parts[0]);
            String name = emptyToNull(parts[1]);
            double price = parts[2].isEmpty() ? 0.0 : Double.parseDouble(parts[2]);
            int quantity = parts[3].isEmpty() ? 0 : Integer.parseInt(parts[3]);
            String category = emptyToNull(parts[4]);
            String manufacturer = emptyToNull(parts[5]);
            String expiryDate = emptyToNull(parts[6]);

            if ("generic".equalsIgnoreCase(category) && parts.length >= 8) {
                String salt = emptyToNull(parts[7]);
                return new GenericMedicine(id, name, price, quantity, manufacturer, expiryDate, salt);
            } else if ("branded".equalsIgnoreCase(category) && parts.length >= 9) {
                String brand = emptyToNull(parts[7]);
                boolean pres = parts[8].equalsIgnoreCase("true");
                return new BrandedMedicine(id, name, price, quantity, brand, manufacturer, expiryDate, pres);
            } else {
                return new Medicine(id, name, price, quantity, category, manufacturer, expiryDate) {
                    @Override
                    public String getDescription() {
                        return "";
                    }
                };
            }
        } catch (Exception e) {
            return null;
        }
    }

    private static String emptyToNull(String s) {
        return (s == null || s.isEmpty() || s.equalsIgnoreCase("null")) ? null : s;
    }
}
