package model;

public class GenericMedicine extends Medicine {
    private String saltComposition;

    public GenericMedicine(String id, String name, double price, int quantity,
                           String manufacturer, String expiryDate,
                           String saltComposition) {
        // Pass "generic" as category
        super(id, name, price, quantity, "generic", manufacturer, expiryDate);
        this.saltComposition = saltComposition;
    }

    public String getSaltComposition() { return saltComposition; }
    public void setSaltComposition(String saltComposition) { this.saltComposition = saltComposition; }

    @Override
    public String getDescription() {
        return String.format("%s (Generic) - Salt: %s - Rs. %.2f",
                getName(), saltComposition, getPrice());
    }

    @Override
    protected String getSpecificCSV() {
        return saltComposition != null ? saltComposition : "";
    }

    public static GenericMedicine fromCSV(String[] parts) {
        // Not used in main code, but can be used if needed.
        return new GenericMedicine(
                parts[0], parts[1], Double.parseDouble(parts[2]),
                Integer.parseInt(parts[3]), parts[5], parts[6], parts[7]
        );
    }
}
