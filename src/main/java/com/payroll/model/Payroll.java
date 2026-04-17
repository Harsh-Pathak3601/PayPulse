package com.payroll.model;

import java.sql.Date;

/**
 * Payroll - POJO representing a payroll record.
 * Maps directly to the `payroll` table in the database.
 */
public class Payroll {

    private int    payrollId;
    private int    empId;
    private String empName;       // Joined from employees table for display
    private String department;    // Joined from employees table for display
    private double basicSalary;   // Snapshot at time of generation
    private double hra;
    private double da;
    private double bonus;
    private double deductions;
    private double netSalary;
    private Date   payDate;

    // ── Constructors ────────────────────────────────────────────────────────────

    public Payroll() {}

    public Payroll(int empId, double basicSalary, double hra,
                   double da, double bonus, double deductions,
                   double netSalary, Date payDate) {
        this.empId       = empId;
        this.basicSalary = basicSalary;
        this.hra         = hra;
        this.da          = da;
        this.bonus       = bonus;
        this.deductions  = deductions;
        this.netSalary   = netSalary;
        this.payDate     = payDate;
    }

    // ── Getters & Setters ───────────────────────────────────────────────────────

    public int    getPayrollId()           { return payrollId; }
    public void   setPayrollId(int id)     { this.payrollId = id; }

    public int    getEmpId()               { return empId; }
    public void   setEmpId(int id)         { this.empId = id; }

    public String getEmpName()             { return empName; }
    public void   setEmpName(String n)     { this.empName = n; }

    public String getDepartment()          { return department; }
    public void   setDepartment(String d)  { this.department = d; }

    public double getBasicSalary()              { return basicSalary; }
    public void   setBasicSalary(double v)      { this.basicSalary = v; }

    public double getHra()               { return hra; }
    public void   setHra(double v)       { this.hra = v; }

    public double getDa()                { return da; }
    public void   setDa(double v)        { this.da = v; }

    public double getBonus()             { return bonus; }
    public void   setBonus(double v)     { this.bonus = v; }

    public double getDeductions()         { return deductions; }
    public void   setDeductions(double v) { this.deductions = v; }

    public double getNetSalary()          { return netSalary; }
    public void   setNetSalary(double v)  { this.netSalary = v; }

    public Date   getPayDate()            { return payDate; }
    public void   setPayDate(Date d)      { this.payDate = d; }
}
