package com.payroll.servlet;

import com.payroll.dao.EmployeeDAO;
import com.payroll.dao.PayrollDAO;
import com.payroll.model.Employee;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/emp-portal")
public class ESSPortalServlet extends HttpServlet {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final PayrollDAO payrollDAO = new PayrollDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.isEmployeeLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/emp-login");
            return;
        }
        int empId = (int) req.getSession().getAttribute("empId");
        
        Employee emp = employeeDAO.getEmployeeById(empId);
        req.setAttribute("employee", emp);
        req.setAttribute("payrolls", payrollDAO.getPayrollByEmployee(empId));
        
        req.getRequestDispatcher("/WEB-INF/views/empPortal.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.isEmployeeLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/emp-login");
            return;
        }

        String action = req.getParameter("action");
        if ("changePassword".equals(action)) {
            int empId = (int) req.getSession().getAttribute("empId");
            String currentPassword = req.getParameter("currentPassword");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            Employee emp = employeeDAO.getEmployeeById(empId);

            if (emp == null || !emp.getPasswordHash().equals(currentPassword)) {
                req.getSession().setAttribute("errorMsg", "Current password is incorrect.");
            } else if (newPassword == null || newPassword.length() < 6) {
                req.getSession().setAttribute("errorMsg", "New password must be at least 6 characters.");
            } else if (!newPassword.equals(confirmPassword)) {
                req.getSession().setAttribute("errorMsg", "New passwords do not match.");
            } else {
                if (employeeDAO.updatePassword(empId, newPassword)) {
                    req.getSession().setAttribute("successMsg", "Password updated successfully.");
                } else {
                    req.getSession().setAttribute("errorMsg", "Failed to update password. Try again.");
                }
            }
        }
        resp.sendRedirect(req.getContextPath() + "/emp-portal");
    }
}
