package com.payroll.dao;

import com.payroll.model.Employee;
import com.payroll.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees (name, email, phone, dept_id, designation, basic_salary, join_date, employee_type, password_hash) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, emp.getName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getPhone());
            if (emp.getDeptId() != null) ps.setInt(4, emp.getDeptId()); else ps.setNull(4, Types.INTEGER);
            ps.setString(5, emp.getDesignation());
            ps.setDouble(6, emp.getBasicSalary());
            ps.setDate(7, emp.getJoinDate());
            ps.setString(8, emp.getEmployeeType());
            ps.setString(9, emp.getPasswordHash());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Employee> getAllEmployees(String search, Integer deptId) {
        List<Employee> employees = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.isEmpty()) {
            sql.append(" AND (e.name LIKE ? OR e.designation LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        if (deptId != null) {
            sql.append(" AND e.dept_id = ?");
            params.add(deptId);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) employees.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    public Employee getEmployeeById(int id) {
        String sql = "SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE e.emp_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Employee authenticateEmployee(String email, String password) {
        String sql = "SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE e.email=? AND e.password_hash=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password); // In production, use BCrypt or similar
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET name=?, email=?, phone=?, dept_id=?, designation=?, basic_salary=?, join_date=?, employee_type=? WHERE emp_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, emp.getName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getPhone());
            if (emp.getDeptId() != null) ps.setInt(4, emp.getDeptId()); else ps.setNull(4, Types.INTEGER);
            ps.setString(5, emp.getDesignation());
            ps.setDouble(6, emp.getBasicSalary());
            ps.setDate(7, emp.getJoinDate());
            ps.setString(8, emp.getEmployeeType());
            ps.setInt(9, emp.getEmpId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(int empId, String newPassword) {
        String sql = "UPDATE employees SET password_hash=? WHERE emp_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword); // In production, hash this password
            ps.setInt(2, empId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE emp_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setEmpId(rs.getInt("emp_id"));
        e.setName(rs.getString("name"));
        e.setEmail(rs.getString("email"));
        e.setPhone(rs.getString("phone"));
        e.setDeptId(rs.getInt("dept_id"));
        e.setDepartment(rs.getString("dept_name"));
        e.setDesignation(rs.getString("designation"));
        e.setBasicSalary(rs.getDouble("basic_salary"));
        e.setJoinDate(rs.getDate("join_date"));
        e.setEmployeeType(rs.getString("employee_type"));
        e.setPasswordHash(rs.getString("password_hash"));
        return e;
    }

    public List<Employee> getAllEmployees() {
        return getAllEmployees(null, null);
    }
}
