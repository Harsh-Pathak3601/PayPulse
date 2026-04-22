package com.payroll.dao;

import com.payroll.model.Leave;
import com.payroll.model.LeaveBalance;
import com.payroll.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveDAO {

    public boolean applyLeave(Leave leave) {
        String sql = "INSERT INTO leaves (emp_id, leave_type, start_date, end_date, total_days, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, leave.getEmpId());
            ps.setString(2, leave.getLeaveType());
            ps.setDate(3, leave.getStartDate());
            ps.setDate(4, leave.getEndDate());
            ps.setInt(5, leave.getTotalDays());
            ps.setString(6, leave.getReason());
            ps.setString(7, "PENDING");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Leave> getPendingLeaves() {
        List<Leave> leaves = new ArrayList<>();
        String sql = "SELECT l.*, e.name FROM leaves l JOIN employees e ON l.emp_id = e.emp_id WHERE l.status='PENDING'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Leave l = mapRow(rs);
                l.setEmpName(rs.getString("name"));
                leaves.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaves;
    }

    public boolean updateLeaveStatus(int leaveId, String status, String remarks) {
        String sql = "UPDATE leaves SET status=?, admin_remarks=? WHERE leave_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, leaveId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public LeaveBalance getLeaveBalance(int empId, String type, int year) {
        String sql = "SELECT * FROM leave_balance WHERE emp_id=? AND leave_type=? AND year=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setString(2, type);
            ps.setInt(3, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapLeaveBalance(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Leave mapRow(ResultSet rs) throws SQLException {
        Leave l = new Leave();
        l.setLeaveId(rs.getInt("leave_id"));
        l.setEmpId(rs.getInt("emp_id"));
        l.setLeaveType(rs.getString("leave_type"));
        l.setStartDate(rs.getDate("start_date"));
        l.setEndDate(rs.getDate("end_date"));
        l.setTotalDays(rs.getInt("total_days"));
        l.setReason(rs.getString("reason"));
        l.setStatus(rs.getString("status"));
        l.setAdminRemarks(rs.getString("admin_remarks"));
        l.setAppliedAt(rs.getTimestamp("applied_at"));
        return l;
    }

    private LeaveBalance mapLeaveBalance(ResultSet rs) throws SQLException {
        LeaveBalance lb = new LeaveBalance();
        lb.setId(rs.getInt("id"));
        lb.setEmpId(rs.getInt("emp_id"));
        lb.setLeaveType(rs.getString("leave_type"));
        lb.setTotalEntitlement(rs.getInt("total_entitlement"));
        lb.setUsedDays(rs.getInt("used_days"));
        lb.setRemainingDays(rs.getInt("remaining_days"));
        lb.setYear(rs.getInt("year"));
        return lb;
    }
}
