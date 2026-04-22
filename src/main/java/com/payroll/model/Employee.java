package com.payroll.model;

import java.sql.Date;

/**
 * Employee - Plain Java Object (POJO) representing an employee entity.
 * Updated for enterprise version v2.0.
 */
public class Employee {

    private int    empId;
    private String name;
    private String email;
    private String phone;
    private Integer deptId;      // Foreign key to departments table
    private String department;   // Joined for display
    private String designation;
    private double basicSalary;
    private Date   joinDate;
    private String employeeType; // FULL_TIME, PART_TIME, CONTRACT
    private String passwordHash;

    // ── Constructors ────────────────────────────────────────────────────────────

    public Employee() {}

    public Employee(int empId, String name, String email, String designation, double basicSalary) {
        this.empId       = empId;
        this.name        = name;
        this.email       = email;
        this.designation = designation;
        this.basicSalary = basicSalary;
    }

    // ── Getters & Setters ───────────────────────────────────────────────────────

    public int    getEmpId()       { return empId; }
    public void   setEmpId(int id) { this.empId = id; }

    public String getName()           { return name; }
    public void   setName(String n)   { this.name = n; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Integer getDeptId() { return deptId; }
    public void setDeptId(Integer deptId) { this.deptId = deptId; }

    public String getDepartment()              { return department; }
    public void   setDepartment(String dept)   { this.department = dept; }

    public String getDesignation()                 { return designation; }
    public void   setDesignation(String desig)     { this.designation = desig; }

    public double getBasicSalary()              { return basicSalary; }
    public void   setBasicSalary(double salary) { this.basicSalary = salary; }

    public Date getJoinDate() { return joinDate; }
    public void setJoinDate(Date joinDate) { this.joinDate = joinDate; }

    public String getEmployeeType() { return employeeType; }
    public void setEmployeeType(String employeeType) { this.employeeType = employeeType; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    // Note: Salary components are now calculated in TaxCalculator utility
    // instead of hardcoded in the model for better flexibility.

    @Override
    public String toString() {
        return "Employee{empId=" + empId + ", name='" + name + "', email='" + email + "'}";
    }
}
