package com.payroll.servlet;

import com.payroll.dao.EmployeeDAO;
import com.payroll.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * EmployeeServlet - Central controller for all employee CRUD operations.
 *
 * Route mapping (via 'action' parameter):
 *  GET  /employees              → list all (with search/filter)
 *  GET  /employees?action=add   → show add form
 *  POST /employees?action=add   → process add
 *  GET  /employees?action=edit  → show edit form
 *  POST /employees?action=edit  → process update
 *  GET  /employees?action=delete → process delete
 */
@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    // ── Auth helper ─────────────────────────────────────────────────────────────
    private boolean isAuthenticated(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s != null && s.getAttribute("loggedIn") != null;
    }

    // ── GET ──────────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAuthenticated(req)) { resp.sendRedirect(req.getContextPath() + "/login"); return; }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/WEB-INF/views/addEmployee.jsp").forward(req, resp);
                break;

            case "edit":
                showEditForm(req, resp);
                break;

            case "delete":
                deleteEmployee(req, resp);
                break;

            default:
                listEmployees(req, resp);
        }
    }

    // ── POST ─────────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAuthenticated(req)) { resp.sendRedirect(req.getContextPath() + "/login"); return; }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add":
                addEmployee(req, resp);
                break;
            case "edit":
                updateEmployee(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/employees");
        }
    }

    // ── Handlers ─────────────────────────────────────────────────────────────────

    private void listEmployees(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String search     = req.getParameter("search");
        String department = req.getParameter("department");

        req.setAttribute("employees",   employeeDAO.getAllEmployees(search, department));
        req.setAttribute("departments", employeeDAO.getAllDepartments());
        req.setAttribute("search",      search);
        req.setAttribute("filterDept",  department);
        req.getRequestDispatcher("/WEB-INF/views/viewEmployees.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int empId = Integer.parseInt(req.getParameter("id"));
            Employee emp = employeeDAO.getEmployeeById(empId);
            if (emp == null) {
                req.getSession().setAttribute("errorMsg", "Employee not found.");
                resp.sendRedirect(req.getContextPath() + "/employees");
                return;
            }
            req.setAttribute("employee", emp);
            req.getRequestDispatcher("/WEB-INF/views/editEmployee.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/employees");
        }
    }

    private void addEmployee(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name        = req.getParameter("name");
        String department  = req.getParameter("department");
        String designation = req.getParameter("designation");
        String salaryStr   = req.getParameter("basicSalary");

        // Backend validation
        String validationError = validateEmployeeInput(name, department, designation, salaryStr);
        if (validationError != null) {
            req.setAttribute("error", validationError);
            req.getRequestDispatcher("/WEB-INF/views/addEmployee.jsp").forward(req, resp);
            return;
        }

        Employee emp = new Employee();
        emp.setName(name.trim());
        emp.setDepartment(department.trim());
        emp.setDesignation(designation.trim());
        emp.setBasicSalary(Double.parseDouble(salaryStr.trim()));

        boolean success = employeeDAO.addEmployee(emp);
        if (success) {
            req.getSession().setAttribute("successMsg", "Employee '" + emp.getName() + "' added successfully!");
        } else {
            req.getSession().setAttribute("errorMsg", "Failed to add employee. Please try again.");
        }
        resp.sendRedirect(req.getContextPath() + "/employees");
    }

    private void updateEmployee(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr       = req.getParameter("empId");
        String name        = req.getParameter("name");
        String department  = req.getParameter("department");
        String designation = req.getParameter("designation");
        String salaryStr   = req.getParameter("basicSalary");

        String validationError = validateEmployeeInput(name, department, designation, salaryStr);
        if (validationError != null) {
            // Re-fetch and show edit form with error
            try {
                int empId = Integer.parseInt(idStr);
                Employee emp = employeeDAO.getEmployeeById(empId);
                req.setAttribute("employee", emp);
                req.setAttribute("error", validationError);
                req.getRequestDispatcher("/WEB-INF/views/editEmployee.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/employees");
            }
            return;
        }

        try {
            Employee emp = new Employee();
            emp.setEmpId(Integer.parseInt(idStr.trim()));
            emp.setName(name.trim());
            emp.setDepartment(department.trim());
            emp.setDesignation(designation.trim());
            emp.setBasicSalary(Double.parseDouble(salaryStr.trim()));

            boolean success = employeeDAO.updateEmployee(emp);
            if (success) {
                req.getSession().setAttribute("successMsg", "Employee updated successfully!");
            } else {
                req.getSession().setAttribute("errorMsg", "Update failed. Please try again.");
            }
            resp.sendRedirect(req.getContextPath() + "/employees");

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/employees");
        }
    }

    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int empId = Integer.parseInt(req.getParameter("id"));
            boolean success = employeeDAO.deleteEmployee(empId);
            if (success) {
                req.getSession().setAttribute("successMsg", "Employee deleted successfully.");
            } else {
                req.getSession().setAttribute("errorMsg", "Could not delete employee.");
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("errorMsg", "Invalid employee ID.");
        }
        resp.sendRedirect(req.getContextPath() + "/employees");
    }

    // ── Validation ───────────────────────────────────────────────────────────────

    /**
     * Validates employee form inputs.
     * @return error message string, or null if all inputs are valid.
     */
    private String validateEmployeeInput(String name, String department,
                                          String designation, String salaryStr) {
        if (name == null || name.trim().isEmpty())        return "Employee name is required.";
        if (name.trim().length() < 2)                     return "Name must be at least 2 characters.";
        if (department == null || department.trim().isEmpty()) return "Department is required.";
        if (designation == null || designation.trim().isEmpty()) return "Designation is required.";
        if (salaryStr == null || salaryStr.trim().isEmpty()) return "Basic salary is required.";
        try {
            double salary = Double.parseDouble(salaryStr.trim());
            if (salary <= 0) return "Salary must be a positive number.";
        } catch (NumberFormatException e) {
            return "Invalid salary format. Enter a numeric value.";
        }
        return null; // all valid
    }
}
