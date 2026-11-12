package model;

import java.util.Date;

public class Employee1 extends Member1 {
    private static final long serialVersionUID = 1L;
    
    private String employeeCode;
    private String position;
    private String department;
    private double salary;

    public Employee1() {
        super();
    }

    public Employee1(int id, String username, String password, String name, Date dob, String email, String tel,
                     String employeeCode, String position, String department, double salary) {
        super(id, username, password, name, dob, email, tel);
        this.employeeCode = employeeCode;
        this.position = position;
        this.department = department;
        this.salary = salary;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }
}
