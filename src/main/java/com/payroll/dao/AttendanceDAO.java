package com.payroll.dao;

import com.payroll.model.Attendance;
import com.payroll.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public boolean markAttendance(Attendance att) {
        String sql = "INSERT INTO attendance (emp_id, att_date, status, check_in, check_out, overtime_hours) "
                   + "VALUES (?, ?, ?, ?, ?, ?) "
                   + "ON DUPLICATE KEY UPDATE status=?, check_in=?, check_out=?, overtime_hours=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, att.getEmpId());
            ps.setDate(2, att.getAttDate());
            ps.setString(3, att.getStatus());
            ps.setTime(4, att.getCheckIn());
            ps.setTime(5, att.getCheckOut());
            ps.setDouble(6, att.getOvertimeHours());
            
            ps.setString(7, att.getStatus());
            ps.setTime(8, att.getCheckIn());
            ps.setTime(9, att.getCheckOut());
            ps.setDouble(10, att.getOvertimeHours());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Attendance> getMonthlyAttendance(int empId, int month, int year) {
        List<Attendance> records = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE emp_id=? AND MONTH(att_date)=? AND YEAR(att_date)=? ORDER BY att_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    records.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }

    public int getPresentDays(int empId, int month, int year) {
        String sql = "SELECT COUNT(*) FROM attendance WHERE emp_id=? AND status='PRESENT' AND MONTH(att_date)=? AND YEAR(att_date)=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setAttendanceId(rs.getInt("attendance_id"));
        a.setEmpId(rs.getInt("emp_id"));
        a.setAttDate(rs.getDate("att_date"));
        a.setStatus(rs.getString("status"));
        a.setCheckIn(rs.getTime("check_in"));
        a.setCheckOut(rs.getTime("check_out"));
        a.setOvertimeHours(rs.getDouble("overtime_hours"));
        return a;
    }
}
