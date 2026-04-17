package com.payroll.servlet;

import com.payroll.dao.EmployeeDAO;
import com.payroll.dao.PayrollDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * DashboardServlet - Renders the main admin dashboard with summary statistics.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final PayrollDAO  payrollDAO  = new PayrollDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Auth guard — redirect unauthenticated requests to login
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Load summary data for dashboard widgets
        int totalEmployees = employeeDAO.getAllEmployees().size();
        int totalPayrolls  = payrollDAO.getAllPayroll().size();
        int totalDepts     = employeeDAO.getAllDepartments().size();

        req.setAttribute("totalEmployees", totalEmployees);
        req.setAttribute("totalPayrolls",  totalPayrolls);
        req.setAttribute("totalDepts",     totalDepts);
        req.setAttribute("recentPayrolls", payrollDAO.getAllPayroll().stream().limit(5).toList());

        req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
    }
}
