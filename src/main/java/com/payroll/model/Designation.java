package com.payroll.model;

import java.sql.Timestamp;

public class Designation {
    private int desigId;
    private String desigName;
    private int deptId;
    private Timestamp createdAt;

    public Designation() {}

    public Designation(int desigId, String desigName, int deptId) {
        this.desigId = desigId;
        this.desigName = desigName;
        this.deptId = deptId;
    }

    public int getDesigId() { return desigId; }
    public void setDesigId(int desigId) { this.desigId = desigId; }

    public String getDesigName() { return desigName; }
    public void setDesigName(String desigName) { this.desigName = desigName; }

    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
