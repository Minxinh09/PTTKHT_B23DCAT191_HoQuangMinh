package model;

import java.util.Date;

public class WarehouseStaff1 extends Employee1 {
    private static final long serialVersionUID = 1L;
    
    private String warehouseDuty;

    public WarehouseStaff1() {
        super();
    }

    public WarehouseStaff1(int id, String username, String password, String name, Date dob, String email, String tel,
                           String employeeCode, String position, String department, double salary, String warehouseDuty) {
        super(id, username, password, name, dob, email, tel, employeeCode, position, department, salary);
        this.warehouseDuty = warehouseDuty;
    }

    public String getWarehouseDuty() {
        return warehouseDuty;
    }

    public void setWarehouseDuty(String warehouseDuty) {
        this.warehouseDuty = warehouseDuty;
    }
}
