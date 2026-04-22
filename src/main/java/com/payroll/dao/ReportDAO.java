package com.payroll.dao;

import com.payroll.util.DBConnection;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class ReportDAO {

    public Map<String, Double> getDepartmentWiseExpenditure() {
        Map<String, Double> data = new HashMap<>();
        String sql = "SELECT d.dept_name, SUM(p.net_salary) as total FROM payroll p "
                   + "JOIN employees e ON p.emp_id = e.emp_id "
                   + "JOIN departments d ON e.dept_id = d.dept_id "
                   + "GROUP BY d.dept_name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("dept_name"), rs.getDouble("total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    public Map<String, Double> getMonthlyExpenditureTrend() {
        Map<String, Double> data = new HashMap<>();
        String sql = "SELECT DATE_FORMAT(pay_date, '%b %Y') as month, SUM(net_salary) as total "
                   + "FROM payroll GROUP BY month ORDER BY pay_date ASC LIMIT 6";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("month"), rs.getDouble("total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
}
