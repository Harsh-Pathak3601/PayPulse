package com.payroll.dao;

import com.payroll.model.Employee;
import com.payroll.model.Payroll;
import com.payroll.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * PayrollDAO - Data Access Object for all payroll-related operations.
 * Handles salary generation, history storage, and retrieval.
 */
public class PayrollDAO {

    // ── CREATE ──────────────────────────────────────────────────────────────────

    /**
     * Saves a newly generated payroll record to the database.
     * @param payroll Payroll object with all computed values pre-set.
     * @return true if insertion was successful.
     */
    public boolean savePayroll(Payroll payroll) {
        String sql = "INSERT INTO payroll (emp_id, basic_salary, hra, da, bonus, deductions, net_salary, pay_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt   (1, payroll.getEmpId());
            ps.setDouble(2, payroll.getBasicSalary());
            ps.setDouble(3, payroll.getHra());
            ps.setDouble(4, payroll.getDa());
            ps.setDouble(5, payroll.getBonus());
            ps.setDouble(6, payroll.getDeductions());
            ps.setDouble(7, payroll.getNetSalary());
            ps.setDate  (8, payroll.getPayDate());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[PayrollDAO.savePayroll] Error: " + e.getMessage());
            return false;
        }
    }

    // ── READ ────────────────────────────────────────────────────────────────────

    /**
     * Retrieves full payroll history for a specific employee.
     * Joins with employees table to include name and department.
     */
    public List<Payroll> getPayrollByEmployee(int empId) {
        List<Payroll> records = new ArrayList<>();
        String sql = "SELECT p.payroll_id, p.emp_id, e.name, e.department, "
                   + "p.basic_salary, p.hra, p.da, p.bonus, p.deductions, p.net_salary, p.pay_date "
                   + "FROM payroll p JOIN employees e ON p.emp_id = e.emp_id "
                   + "WHERE p.emp_id = ? ORDER BY p.pay_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) records.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.err.println("[PayrollDAO.getPayrollByEmployee] Error: " + e.getMessage());
        }
        return records;
    }

    /**
     * Retrieves the most recent payroll record for a given employee.
     * Used to display the salary slip right after generation.
     */
    public Payroll getLatestPayroll(int empId) {
        String sql = "SELECT p.payroll_id, p.emp_id, e.name, e.department, "
                   + "p.basic_salary, p.hra, p.da, p.bonus, p.deductions, p.net_salary, p.pay_date "
                   + "FROM payroll p JOIN employees e ON p.emp_id = e.emp_id "
                   + "WHERE p.emp_id = ? ORDER BY p.payroll_id DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            System.err.println("[PayrollDAO.getLatestPayroll] Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves all payroll records across all employees (admin view).
     */
    public List<Payroll> getAllPayroll() {
        List<Payroll> records = new ArrayList<>();
        String sql = "SELECT p.payroll_id, p.emp_id, e.name, e.department, "
                   + "p.basic_salary, p.hra, p.da, p.bonus, p.deductions, p.net_salary, p.pay_date "
                   + "FROM payroll p JOIN employees e ON p.emp_id = e.emp_id "
                   + "ORDER BY p.pay_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) records.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[PayrollDAO.getAllPayroll] Error: " + e.getMessage());
        }
        return records;
    }

    /**
     * Builds a Payroll object from an Employee (calculates components on the fly).
     * Used in the GenerateSalaryServlet before persisting.
     */
    public static Payroll buildPayroll(Employee emp) {
        Payroll p = new Payroll();
        p.setEmpId(emp.getEmpId());
        p.setEmpName(emp.getName());
        p.setDepartment(emp.getDepartment());
        p.setBasicSalary(emp.getBasicSalary());
        p.setHra(emp.getHra());
        p.setDa(emp.getDa());
        p.setBonus(emp.getBonus());
        p.setDeductions(emp.getDeductions());
        p.setNetSalary(emp.getNetSalary());
        p.setPayDate(new java.sql.Date(System.currentTimeMillis()));
        return p;
    }

    // ── Utility ─────────────────────────────────────────────────────────────────

    /** Maps a ResultSet row to a Payroll object. */
    private Payroll mapRow(ResultSet rs) throws SQLException {
        Payroll p = new Payroll();
        p.setPayrollId (rs.getInt   ("payroll_id"));
        p.setEmpId     (rs.getInt   ("emp_id"));
        p.setEmpName   (rs.getString("name"));
        p.setDepartment(rs.getString("department"));
        p.setBasicSalary(rs.getDouble("basic_salary"));
        p.setHra        (rs.getDouble("hra"));
        p.setDa         (rs.getDouble("da"));
        p.setBonus      (rs.getDouble("bonus"));
        p.setDeductions (rs.getDouble("deductions"));
        p.setNetSalary  (rs.getDouble("net_salary"));
        p.setPayDate    (rs.getDate  ("pay_date"));
        return p;
    }
}
