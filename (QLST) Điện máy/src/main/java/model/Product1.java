package model;

import java.io.Serializable;

public class Product1 implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String productCode;
    private String productName;
    private double price;
    private String unit;
    private int stockQuantity;
    private String brand;
    private int warrantyMonth;
    private String description;
    private Category1 category;

    public Product1() {
    }

    public Product1(int id, String productCode, String productName, double price, String unit,
                    int stockQuantity, String brand, int warrantyMonth, String description, Category1 category) {
        this.id = id;
        this.productCode = productCode;
        this.productName = productName;
        this.price = price;
        this.unit = unit;
        this.stockQuantity = stockQuantity;
        this.brand = brand;
        this.warrantyMonth = warrantyMonth;
        this.description = description;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public int getWarrantyMonth() {
        return warrantyMonth;
    }

    public void setWarrantyMonth(int warrantyMonth) {
        this.warrantyMonth = warrantyMonth;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Category1 getCategory() {
        return category;
    }

    public void setCategory(Category1 category) {
        this.category = category;
    }
}
