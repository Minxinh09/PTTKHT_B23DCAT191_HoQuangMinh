package model;

public class SupplierStat1 extends Supplier1 {
    private static final long serialVersionUID = 1L;
    
    private int totalImportQuantity;
    private double totalImportAmount;
    private int importCount;
    private int rank;

    public SupplierStat1() {
        super();
    }

    public SupplierStat1(int id, String supplierCode, String supplierName, String phone, String email, String address,
                         int totalImportQuantity, double totalImportAmount, int importCount, int rank) {
        super(id, supplierCode, supplierName, phone, email, address);
        this.totalImportQuantity = totalImportQuantity;
        this.totalImportAmount = totalImportAmount;
        this.importCount = importCount;
        this.rank = rank;
    }

    public int getTotalImportQuantity() {
        return totalImportQuantity;
    }

    public void setTotalImportQuantity(int totalImportQuantity) {
        this.totalImportQuantity = totalImportQuantity;
    }

    public double getTotalImportAmount() {
        return totalImportAmount;
    }

    public void setTotalImportAmount(double totalImportAmount) {
        this.totalImportAmount = totalImportAmount;
    }

    public int getImportCount() {
        return importCount;
    }

    public void setImportCount(int importCount) {
        this.importCount = importCount;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
