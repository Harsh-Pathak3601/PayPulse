package com.payroll.servlet;

import com.payroll.dao.DepartmentDAO;
import com.payroll.dao.EmployeeDAO;
import com.payroll.dao.PayrollDAO;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final PayrollDAO  payrollDAO  = new PayrollDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);

        List<com.payroll.model.Payroll> allPayrolls = payrollDAO.getAllPayroll();
        
        req.setAttribute("totalEmployees", employeeDAO.getAllEmployees().size());
        req.setAttribute("totalPayrolls",  allPayrolls.size());
        req.setAttribute("totalDepts",     departmentDAO.getAllDepartments().size());
        req.setAttribute("recentPayrolls", allPayrolls.stream().limit(5).collect(Collectors.toList()));
        req.setAttribute("activePage", "dashboard");

        // Monthly payroll spend: sum of net salaries from all payroll records
        double monthlySpend = allPayrolls.stream()
                .mapToDouble(p -> p.getNetSalary())
                .sum();
        req.setAttribute("monthlySpend", monthlySpend);

        req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);

    }
}
