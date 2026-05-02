package com.payroll.model;

import java.sql.Date;

/**
 * Payroll - POJO representing a payroll record.
 * Updated for enterprise version v2.0 with detailed deductions.
 */
public class Payroll {

    private int    payrollId;
    private int    empId;
    private String empName;       
    private String department;    
    private double basicSalary;   
    private double hra;
    private double da;
    private double bonus;
    private double pfDeduction;
    private double esiDeduction;
    private double tdsDeduction;
    private double lopDeduction;
    private double grossSalary;
    private double netSalary;
    private int    workingDays;
    private double paidDays;
    private double overtimePay;
    private Date   payDate;

    public Payroll() {}

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

    public double getPfDeduction() { return pfDeduction; }
    public void setPfDeduction(double pfDeduction) { this.pfDeduction = pfDeduction; }

    public double getEsiDeduction() { return esiDeduction; }
    public void setEsiDeduction(double esiDeduction) { this.esiDeduction = esiDeduction; }

    public double getTdsDeduction() { return tdsDeduction; }
    public void setTdsDeduction(double tdsDeduction) { this.tdsDeduction = tdsDeduction; }

    public double getLopDeduction() { return lopDeduction; }
    public void setLopDeduction(double lopDeduction) { this.lopDeduction = lopDeduction; }

    public double getGrossSalary() { return grossSalary; }
    public void setGrossSalary(double grossSalary) { this.grossSalary = grossSalary; }

    public double getNetSalary() { return netSalary; }
    public void setNetSalary(double netSalary) { this.netSalary = netSalary; }

    public int getWorkingDays() { return workingDays; }
    public void setWorkingDays(int workingDays) { this.workingDays = workingDays; }

    public double getPaidDays() { return paidDays; }
    public void setPaidDays(double paidDays) { this.paidDays = paidDays; }

    public double getOvertimePay() { return overtimePay; }
    public void setOvertimePay(double overtimePay) { this.overtimePay = overtimePay; }

    public Date getPayDate() { return payDate; }
    public void setPayDate(Date payDate) { this.payDate = payDate; }
    
    // Total deductions for convenience in JSP
    public double getTotalDeductions() {
        return pfDeduction + esiDeduction + tdsDeduction + lopDeduction;
    }
}
