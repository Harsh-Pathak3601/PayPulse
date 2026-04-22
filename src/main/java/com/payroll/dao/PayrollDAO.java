package com.payroll.dao;

import com.payroll.model.Payroll;
import com.payroll.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PayrollDAO {

    public boolean payrollExistsForMonth(int empId, int month, int year) {
        String sql = "SELECT COUNT(*) FROM payroll WHERE emp_id=? AND MONTH(pay_date)=? AND YEAR(pay_date)=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean savePayroll(Payroll p) {
        String sql = "INSERT INTO payroll (emp_id, basic_salary, hra, da, bonus, pf_deduction, esi_deduction, tds_deduction, lop_deduction, gross_salary, net_salary, working_days, paid_days, overtime_pay, pay_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getEmpId());
            ps.setDouble(2, p.getBasicSalary());
            ps.setDouble(3, p.getHra());
            ps.setDouble(4, p.getDa());
            ps.setDouble(5, p.getBonus());
            ps.setDouble(6, p.getPfDeduction());
            ps.setDouble(7, p.getEsiDeduction());
            ps.setDouble(8, p.getTdsDeduction());
            ps.setDouble(9, p.getLopDeduction());
            ps.setDouble(10, p.getGrossSalary());
            ps.setDouble(11, p.getNetSalary());
            ps.setInt(12, p.getWorkingDays());
            ps.setInt(13, p.getPaidDays());
            ps.setDouble(14, p.getOvertimePay());
            ps.setDate(15, p.getPayDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Payroll> getAllPayroll() {
        List<Payroll> records = new ArrayList<>();
        String sql = "SELECT p.*, e.name, d.dept_name FROM payroll p "
                   + "JOIN employees e ON p.emp_id = e.emp_id "
                   + "LEFT JOIN departments d ON e.dept_id = d.dept_id ORDER BY p.pay_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) records.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }

    public List<Payroll> getPayrollByEmployee(int empId) {
        List<Payroll> records = new ArrayList<>();
        String sql = "SELECT p.*, e.name, d.dept_name FROM payroll p "
                   + "JOIN employees e ON p.emp_id = e.emp_id "
                   + "LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE p.emp_id=? ORDER BY p.pay_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) records.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }

    private Payroll mapRow(ResultSet rs) throws SQLException {
        Payroll p = new Payroll();
        p.setPayrollId(rs.getInt("payroll_id"));
        p.setEmpId(rs.getInt("emp_id"));
        p.setEmpName(rs.getString("name"));
        p.setDepartment(rs.getString("dept_name"));
        p.setBasicSalary(rs.getDouble("basic_salary"));
        p.setHra(rs.getDouble("hra"));
        p.setDa(rs.getDouble("da"));
        p.setBonus(rs.getDouble("bonus"));
        p.setPfDeduction(rs.getDouble("pf_deduction"));
        p.setEsiDeduction(rs.getDouble("esi_deduction"));
        p.setTdsDeduction(rs.getDouble("tds_deduction"));
        p.setLopDeduction(rs.getDouble("lop_deduction"));
        p.setGrossSalary(rs.getDouble("gross_salary"));
        p.setNetSalary(rs.getDouble("net_salary"));
        p.setWorkingDays(rs.getInt("working_days"));
        p.setPaidDays(rs.getInt("paid_days"));
        p.setOvertimePay(rs.getDouble("overtime_pay"));
        p.setPayDate(rs.getDate("pay_date"));
        return p;
    }
}
