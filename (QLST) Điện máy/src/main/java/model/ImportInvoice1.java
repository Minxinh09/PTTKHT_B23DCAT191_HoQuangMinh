package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ImportInvoice1 implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String importCode;
    private Date importDate;
    private double totalAmount;
    private Supplier1 supplier;
    private WarehouseStaff1 warehouseStaff;
    private List<ImportDetail1> importDetail;

    public ImportInvoice1() {
        this.importDetail = new ArrayList<>();
    }

    public ImportInvoice1(int id, String importCode, Date importDate, double totalAmount,
                          Supplier1 supplier, WarehouseStaff1 warehouseStaff) {
        this.id = id;
        this.importCode = importCode;
        this.importDate = importDate;
        this.totalAmount = totalAmount;
        this.supplier = supplier;
        this.warehouseStaff = warehouseStaff;
        this.importDetail = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImportCode() {
        return importCode;
    }

    public void setImportCode(String importCode) {
        this.importCode = importCode;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Supplier1 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier1 supplier) {
        this.supplier = supplier;
    }

    public WarehouseStaff1 getWarehouseStaff() {
        return warehouseStaff;
    }

    public void setWarehouseStaff(WarehouseStaff1 warehouseStaff) {
        this.warehouseStaff = warehouseStaff;
    }

    public List<ImportDetail1> getImportDetail() {
        return importDetail;
    }

    public void setImportDetail(List<ImportDetail1> importDetail) {
        this.importDetail = importDetail;
    }
}
