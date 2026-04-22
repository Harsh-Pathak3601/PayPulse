package com.payroll.model;

import java.sql.Date;
import java.sql.Time;

public class Attendance {
    private int attendanceId;
    private int empId;
    private Date attDate;
    private String status; // PRESENT, ABSENT, HALF_DAY, HOLIDAY
    private Time checkIn;
    private Time checkOut;
    private double overtimeHours;

    public Attendance() {}

    public int getAttendanceId() { return attendanceId; }
    public void setAttendanceId(int attendanceId) { this.attendanceId = attendanceId; }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public Date getAttDate() { return attDate; }
    public void setAttDate(Date attDate) { this.attDate = attDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Time getCheckIn() { return checkIn; }
    public void setCheckIn(Time checkIn) { this.checkIn = checkIn; }

    public Time getCheckOut() { return checkOut; }
    public void setCheckOut(Time checkOut) { this.checkOut = checkOut; }

    public double getOvertimeHours() { return overtimeHours; }
    public void setOvertimeHours(double overtimeHours) { this.overtimeHours = overtimeHours; }
}
