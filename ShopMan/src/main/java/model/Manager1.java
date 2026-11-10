package model;

import java.util.Date;

public class Manager1 extends Employee1 {
    private static final long serialVersionUID = 1L;
    
    private String managementLevel;

    public Manager1() {
        super();
    }

    public Manager1(int id, String username, String password, String name, Date dob, String email, String tel,
                    String employeeCode, String position, String department, double salary, String managementLevel) {
        super(id, username, password, name, dob, email, tel, employeeCode, position, department, salary);
        this.managementLevel = managementLevel;
    }

    public String getManagementLevel() {
        return managementLevel;
    }

    public void setManagementLevel(String managementLevel) {
        this.managementLevel = managementLevel;
    }
}
