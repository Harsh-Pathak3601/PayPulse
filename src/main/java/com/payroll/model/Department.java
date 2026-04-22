package com.payroll.model;

import java.sql.Timestamp;

public class Department {
    private int deptId;
    private String deptName;
    private String deptHead;
    private Timestamp createdAt;

    public Department() {}

    public Department(int deptId, String deptName, String deptHead) {
        this.deptId = deptId;
        this.deptName = deptName;
        this.deptHead = deptHead;
    }

    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }

    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }

    public String getDeptHead() { return deptHead; }
    public void setDeptHead(String deptHead) { this.deptHead = deptHead; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
