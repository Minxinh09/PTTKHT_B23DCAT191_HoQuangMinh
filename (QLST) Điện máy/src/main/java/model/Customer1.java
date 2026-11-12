package model;

import java.util.Date;

public class Customer1 extends Member1 {
    private static final long serialVersionUID = 1L;
    
    private String customerCode;

    public Customer1() {
        super();
    }

    public Customer1(int id, String username, String password, String name, Date dob, String email, String tel, String customerCode) {
        super(id, username, password, name, dob, email, tel);
        this.customerCode = customerCode;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }
}
