package model;

public class BrandedMedicine extends Medicine {
    private String brandName;
    private boolean prescriptionRequired;

    // manufactureDate is stored in the 'manufacturer' field of Medicine for compatibility
    public BrandedMedicine(String id, String name, double price, int quantity,
                           String brandName, String manufactureDate, String expiryDate,
                           boolean prescriptionRequired) {
        super(id, name, price, quantity, "branded", manufactureDate, expiryDate);
        this.brandName = brandName;
        this.prescriptionRequired = prescriptionRequired;
    }

    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }

    // manufactureDate getter/setter mapped to 'manufacturer'
    public String getManufactureDate() { return getManufacturer(); }
    public void setManufactureDate(String manufactureDate) { setManufacturer(manufactureDate); }

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
}
