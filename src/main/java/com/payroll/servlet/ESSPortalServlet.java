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
        SessionUtil.requireEmployee(req, resp);
        int empId = (int) req.getSession().getAttribute("empId");
        
        Employee emp = employeeDAO.getEmployeeById(empId);
        req.setAttribute("employee", emp);
        req.setAttribute("payrolls", payrollDAO.getPayrollByEmployee(empId));
        
        req.getRequestDispatcher("/WEB-INF/views/empPortal.jsp").forward(req, resp);
    }
}
