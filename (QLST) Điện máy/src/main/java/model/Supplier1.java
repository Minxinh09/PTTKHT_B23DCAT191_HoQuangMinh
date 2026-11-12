package model;

import java.io.Serializable;

public class Supplier1 implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String supplierCode;
    private String supplierName;
    private String phone;
    private String email;
    private String address;

    public Supplier1() {
    }

    public Supplier1(int id, String supplierCode, String supplierName, String phone, String email, String address) {
        this.id = id;
        this.supplierCode = supplierCode;
        this.supplierName = supplierName;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
