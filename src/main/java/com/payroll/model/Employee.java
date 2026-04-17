package com.payroll.model;

/**
 * Employee - Plain Java Object (POJO) representing an employee entity.
 * Maps directly to the `employees` table in the database.
 */
public class Employee {

    private int    empId;
    private String name;
    private String department;
    private String designation;
    private double basicSalary;

    // ── Constructors ────────────────────────────────────────────────────────────

    public Employee() {}

    public Employee(int empId, String name, String department,
                    String designation, double basicSalary) {
        this.empId       = empId;
        this.name        = name;
        this.department  = department;
        this.designation = designation;
        this.basicSalary = basicSalary;
    }

    // ── Getters & Setters ───────────────────────────────────────────────────────

    public int    getEmpId()       { return empId; }
    public void   setEmpId(int id) { this.empId = id; }

    public String getName()           { return name; }
    public void   setName(String n)   { this.name = n; }

    public String getDepartment()              { return department; }
    public void   setDepartment(String dept)   { this.department = dept; }

    public String getDesignation()                 { return designation; }
    public void   setDesignation(String desig)     { this.designation = desig; }

    public double getBasicSalary()              { return basicSalary; }
    public void   setBasicSalary(double salary) { this.basicSalary = salary; }

    // ── Computed salary components ──────────────────────────────────────────────

    /** House Rent Allowance = 20% of basic salary */
    public double getHra()  { return basicSalary * 0.20; }

    /** Dearness Allowance = 10% of basic salary */
    public double getDa()   { return basicSalary * 0.10; }

    /** Performance Bonus = 5% of basic salary */
    public double getBonus() { return basicSalary * 0.05; }

    /** Total Deductions = 5% of basic salary */
    public double getDeductions() { return basicSalary * 0.05; }

    /** Net Salary = Basic + HRA + DA + Bonus - Deductions */
    public double getNetSalary() {
        return basicSalary + getHra() + getDa() + getBonus() - getDeductions();
    }

    @Override
    public String toString() {
        return "Employee{empId=" + empId + ", name='" + name + "', department='" + department + "'}";
    }
}
