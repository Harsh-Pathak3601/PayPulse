package com.payroll.servlet;

import com.payroll.dao.EmployeeDAO;
import com.payroll.dao.PayrollDAO;
import com.payroll.model.Employee;
import com.payroll.model.Payroll;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * PayrollServlet - Handles salary generation, salary slip display,
 * and viewing payroll history per employee.
 *
 * Routes:
 *  GET  /payroll                          → list all payroll history
 *  GET  /payroll?action=generate          → show employee selection for generation
 *  POST /payroll?action=generate          → compute & save payroll, show slip
 *  GET  /payroll?action=history&empId=X   → payroll history for employee X
 *  GET  /payroll?action=slip&payrollId=X  → view a specific payroll slip
 */
@WebServlet("/payroll")
public class PayrollServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final PayrollDAO  payrollDAO  = new PayrollDAO();

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
            case "generate":
                showGenerateForm(req, resp);
                break;
            case "history":
                showEmployeeHistory(req, resp);
                break;
            default:
                listAllPayroll(req, resp);
        }
    }

    // ── POST ─────────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAuthenticated(req)) { resp.sendRedirect(req.getContextPath() + "/login"); return; }

        String action = req.getParameter("action");
        if ("generate".equals(action)) {
            generateSalary(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/payroll");
        }
    }

    // ── Handlers ─────────────────────────────────────────────────────────────────

    private void listAllPayroll(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Payroll> allPayrolls = payrollDAO.getAllPayroll();
        req.setAttribute("payrolls", allPayrolls);
        req.getRequestDispatcher("/WEB-INF/views/payrollHistory.jsp").forward(req, resp);
    }

    private void showGenerateForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("employees", employeeDAO.getAllEmployees());
        req.getRequestDispatcher("/WEB-INF/views/generateSalary.jsp").forward(req, resp);
    }

    private void generateSalary(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String empIdStr = req.getParameter("empId");
        if (empIdStr == null || empIdStr.trim().isEmpty()) {
            req.setAttribute("error", "Please select an employee.");
            req.setAttribute("employees", employeeDAO.getAllEmployees());
            req.getRequestDispatcher("/WEB-INF/views/generateSalary.jsp").forward(req, resp);
            return;
        }

        try {
            int empId = Integer.parseInt(empIdStr.trim());
            Employee emp = employeeDAO.getEmployeeById(empId);

            if (emp == null) {
                req.setAttribute("error", "Employee not found.");
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.getRequestDispatcher("/WEB-INF/views/generateSalary.jsp").forward(req, resp);
                return;
            }

            // Build and persist payroll record
            Payroll payroll = PayrollDAO.buildPayroll(emp);
            boolean saved   = payrollDAO.savePayroll(payroll);

            if (!saved) {
                req.setAttribute("error", "Failed to save payroll. Please try again.");
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.getRequestDispatcher("/WEB-INF/views/generateSalary.jsp").forward(req, resp);
                return;
            }

            // Show generated salary slip
            req.setAttribute("payroll", payroll);
            req.setAttribute("employee", emp);
            req.getRequestDispatcher("/WEB-INF/views/salarySlip.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/payroll?action=generate");
        }
    }

    private void showEmployeeHistory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String empIdStr = req.getParameter("empId");
        if (empIdStr == null || empIdStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/payroll");
            return;
        }
        try {
            int empId       = Integer.parseInt(empIdStr.trim());
            Employee emp    = employeeDAO.getEmployeeById(empId);
            List<Payroll> history = payrollDAO.getPayrollByEmployee(empId);

            req.setAttribute("employee", emp);
            req.setAttribute("payrolls", history);
            req.getRequestDispatcher("/WEB-INF/views/payrollHistory.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/payroll");
        }
    }
}
