package model;

public class BrandedMedicine extends Medicine {
    private String brandName;
    private boolean prescriptionRequired;

    public BrandedMedicine(String id, String name, double price, int quantity,
                           String manufacturer, String expiryDate,
                           String brandName, boolean prescriptionRequired) {
        // Pass "branded" as category
        super(id, name, price, quantity, "branded", manufacturer, expiryDate);
        this.brandName = brandName;
        this.prescriptionRequired = prescriptionRequired;
    }

    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }

    public boolean isPrescriptionRequired() { return prescriptionRequired; }
    public void setPrescriptionRequired(boolean prescriptionRequired) { this.prescriptionRequired = prescriptionRequired; }

    @Override
    public String getDescription() {
        return String.format("%s (%s) %s - Rs. %.2f",
                getName(),
                brandName,
                prescriptionRequired ? "(Prescription Required)" : "",
                getPrice());
    }

    @Override
    protected String getSpecificCSV() {
        return (brandName != null ? brandName : "") + "," + prescriptionRequired;
    }

    public static BrandedMedicine fromCSV(String[] parts) {
        // Not used in main code, but can be used if needed.
        return new BrandedMedicine(
                parts[0], parts[1], Double.parseDouble(parts[2]),
                Integer.parseInt(parts[3]), parts[5], parts[6], parts[7],
                Boolean.parseBoolean(parts[8])
        );
    }
}
