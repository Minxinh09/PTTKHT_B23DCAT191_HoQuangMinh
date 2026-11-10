package model;

import java.io.Serializable;

public class ImportDetail1 implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private int quantity;
    private double importPrice;
    private ImportInvoice1 importInvoice;
    private Product1 product;

    public ImportDetail1() {
    }

    public ImportDetail1(int id, int quantity, double importPrice, ImportInvoice1 importInvoice, Product1 product) {
        this.id = id;
        this.quantity = quantity;
        this.importPrice = importPrice;
        this.importInvoice = importInvoice;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(double importPrice) {
        this.importPrice = importPrice;
    }

    public ImportInvoice1 getImportInvoice() {
        return importInvoice;
    }

    public void setImportInvoice(ImportInvoice1 importInvoice) {
        this.importInvoice = importInvoice;
    }

    public Product1 getProduct() {
        return product;
    }

    public void setProduct(Product1 product) {
        this.product = product;
    }

    public double getAmount() {
        return this.quantity * this.importPrice;
    }
}
