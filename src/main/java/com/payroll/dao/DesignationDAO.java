package com.payroll.dao;

import com.payroll.model.Designation;
import com.payroll.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DesignationDAO {

    public List<Designation> getDesignationsByDept(int deptId) {
        List<Designation> desigs = new ArrayList<>();
        String sql = "SELECT * FROM designations WHERE dept_id=? ORDER BY desig_name ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    desigs.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching designations for department ID: " + deptId, e);
        }
        return desigs;
    }

    public List<Designation> getAllDesignations() {
        List<Designation> desigs = new ArrayList<>();
        String sql = "SELECT * FROM designations ORDER BY desig_name ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                desigs.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all designations", e);
        }
        return desigs;
    }

    public boolean addDesignation(Designation desig) {
        String sql = "INSERT INTO designations (desig_name, dept_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, desig.getDesigName());
            ps.setInt(2, desig.getDeptId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error adding designation: " + desig.getDesigName(), e);
        }
    }

    private Designation mapRow(ResultSet rs) throws SQLException {
        Designation d = new Designation();
        d.setDesigId(rs.getInt("desig_id"));
        d.setDesigName(rs.getString("desig_name"));
        d.setDeptId(rs.getInt("dept_id"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        return d;
    }
}
