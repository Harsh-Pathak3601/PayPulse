package com.payroll.dao;

import com.payroll.model.Employee;
import com.payroll.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * EmployeeDAO - Data Access Object for all employee-related CRUD operations.
 * Uses PreparedStatement for all queries to prevent SQL injection.
 */
public class EmployeeDAO {

    // ── CREATE ──────────────────────────────────────────────────────────────────

    /**
     * Inserts a new employee record into the database.
     * @return true if insertion was successful, false otherwise.
     */
    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees (name, department, designation, basic_salary) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, emp.getName());
            ps.setString(2, emp.getDepartment());
            ps.setString(3, emp.getDesignation());
            ps.setDouble(4, emp.getBasicSalary());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.addEmployee] Error: " + e.getMessage());
            return false;
        }
    }

    // ── READ ────────────────────────────────────────────────────────────────────

    /**
     * Retrieves all employees, optionally filtered by search term and/or department.
     * @param search     Name/designation keyword (nullable / empty for no filter)
     * @param department Department filter (nullable / empty for all departments)
     */
    public List<Employee> getAllEmployees(String search, String department) {
        List<Employee> employees = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT emp_id, name, department, designation, basic_salary FROM employees WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR designation LIKE ?)");
            params.add("%" + search.trim() + "%");
            params.add("%" + search.trim() + "%");
        }
        if (department != null && !department.trim().isEmpty()) {
            sql.append(" AND department = ?");
            params.add(department.trim());
        }
        sql.append(" ORDER BY emp_id ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    employees.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.getAllEmployees] Error: " + e.getMessage());
        }
        return employees;
    }

    /** Retrieves all employees without any filters. */
    public List<Employee> getAllEmployees() {
        return getAllEmployees(null, null);
    }

    /**
     * Retrieve a single employee by primary key.
     * @return Employee object, or null if not found.
     */
    public Employee getEmployeeById(int empId) {
        String sql = "SELECT emp_id, name, department, designation, basic_salary FROM employees WHERE emp_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.getEmployeeById] Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Returns a distinct list of all department names (used for filter dropdown).
     */
    public List<String> getAllDepartments() {
        List<String> depts = new ArrayList<>();
        String sql = "SELECT DISTINCT department FROM employees ORDER BY department ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) depts.add(rs.getString("department"));

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.getAllDepartments] Error: " + e.getMessage());
        }
        return depts;
    }

    // ── UPDATE ──────────────────────────────────────────────────────────────────

    /**
     * Updates an existing employee record.
     * @return true if at least one row was updated.
     */
    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET name=?, department=?, designation=?, basic_salary=? WHERE emp_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, emp.getName());
            ps.setString(2, emp.getDepartment());
            ps.setString(3, emp.getDesignation());
            ps.setDouble(4, emp.getBasicSalary());
            ps.setInt(5, emp.getEmpId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.updateEmployee] Error: " + e.getMessage());
            return false;
        }
    }

    // ── DELETE ──────────────────────────────────────────────────────────────────

    /**
     * Deletes an employee and all associated payroll records (cascade handled in DB).
     * @return true if deletion was successful.
     */
    public boolean deleteEmployee(int empId) {
        String sql = "DELETE FROM employees WHERE emp_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, empId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.deleteEmployee] Error: " + e.getMessage());
            return false;
        }
    }

    // ── Utility ─────────────────────────────────────────────────────────────────

    /** Maps a ResultSet row to an Employee object. */
    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setEmpId(rs.getInt("emp_id"));
        e.setName(rs.getString("name"));
        e.setDepartment(rs.getString("department"));
        e.setDesignation(rs.getString("designation"));
        e.setBasicSalary(rs.getDouble("basic_salary"));
        return e;
    }
}
