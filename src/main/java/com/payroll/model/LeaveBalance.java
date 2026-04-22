package com.payroll.model;

public class LeaveBalance {
    private int id;
    private int empId;
    private String leaveType;
    private int totalEntitlement;
    private int usedDays;
    private int remainingDays;
    private int year;

    public LeaveBalance() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public String getLeaveType() { return leaveType; }
    public void setLeaveType(String leaveType) { this.leaveType = leaveType; }

    public int getTotalEntitlement() { return totalEntitlement; }
    public void setTotalEntitlement(int totalEntitlement) { this.totalEntitlement = totalEntitlement; }

    public int getUsedDays() { return usedDays; }
    public void setUsedDays(int usedDays) { this.usedDays = usedDays; }

    public int getRemainingDays() { return remainingDays; }
    public void setRemainingDays(int remainingDays) { this.remainingDays = remainingDays; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
}
