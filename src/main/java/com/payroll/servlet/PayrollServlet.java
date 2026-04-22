package com.payroll.servlet;

import com.payroll.dao.AttendanceDAO;
import com.payroll.dao.EmployeeDAO;
import com.payroll.dao.PayrollDAO;
import com.payroll.model.Employee;
import com.payroll.model.Payroll;
import com.payroll.util.EmailService;
import com.payroll.util.SessionUtil;
import com.payroll.util.TaxCalculator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
@WebServlet("/payroll")
public class PayrollServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final PayrollDAO  payrollDAO  = new PayrollDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "generate":
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.setAttribute("activePage", "generateSalary");
                req.getRequestDispatcher("/WEB-INF/views/generateSalary.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("payrolls", payrollDAO.getAllPayroll());
                req.setAttribute("activePage", "payroll");
                req.getRequestDispatcher("/WEB-INF/views/payrollHistory.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);

        String empIdStr = req.getParameter("empId");
        if (empIdStr == null || empIdStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/payroll?action=generate&error=NoEmployee");
            return;
        }

        int empId = Integer.parseInt(empIdStr.trim());
        Employee emp = employeeDAO.getEmployeeById(empId);
        if (emp == null) {
            resp.sendRedirect(req.getContextPath() + "/payroll?action=generate&error=NotFound");
            return;
        }

        // Logic for Attendance-based salary
        LocalDate now = LocalDate.now();
        
        // Prevent duplicate generation for the current month
        if (payrollDAO.payrollExistsForMonth(empId, now.getMonthValue(), now.getYear())) {
            resp.sendRedirect(req.getContextPath() + "/payroll?action=generate&error=AlreadyGenerated");
            return;
        }
        
        int workingDays = now.lengthOfMonth();
        int presentDays = attendanceDAO.getPresentDays(empId, now.getMonthValue(), now.getYear());
        
        // Build Payroll
        Payroll p = new Payroll();
        p.setEmpId(empId);
        p.setEmpName(emp.getName());
        p.setDepartment(emp.getDepartment());
        p.setBasicSalary(emp.getBasicSalary());
        p.setPayDate(Date.valueOf(now));
        
        // Calculate Proportional Salary
        double fullBasic = emp.getBasicSalary();
        double proratedRatio = workingDays > 0 ? (double) presentDays / workingDays : 0.0;
        
        double earnedBasic = fullBasic * proratedRatio;
        
        p.setWorkingDays(workingDays);
        p.setPaidDays(presentDays);
        p.setLopDeduction(0.0); // Set LOP to 0 because earnings are already prorated
        
        // Use full basic for reference in model, but the UI usually shows earned or full.
        // We'll set p.setBasicSalary to earnedBasic so the Payslip shows what they actually get for the days worked.
        p.setBasicSalary(earnedBasic);
        p.setHra(TaxCalculator.calculateHRA(earnedBasic));
        p.setDa(TaxCalculator.calculateDA(earnedBasic));
        p.setBonus(TaxCalculator.calculateBonus(earnedBasic));
        
        double earnedGross = earnedBasic + p.getHra() + p.getDa() + p.getBonus();
        p.setGrossSalary(earnedGross);
        
        // Deductions
        p.setPfDeduction(TaxCalculator.calculatePF(earnedBasic));
        p.setEsiDeduction(TaxCalculator.calculateESI(earnedGross));
        p.setTdsDeduction(TaxCalculator.calculateTDS(earnedGross));
        
        double net = earnedGross - p.getPfDeduction() - p.getEsiDeduction() - p.getTdsDeduction();
        p.setNetSalary(net);

        if (payrollDAO.savePayroll(p)) {
            // Send Email Notification
            EmailService.sendPayslipNotification(emp, p);
            
            req.setAttribute("payroll", p);
            req.setAttribute("employee", emp);
            req.getRequestDispatcher("/WEB-INF/views/salarySlip.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/payroll?action=generate&error=SaveFailed");
        }
    }
}
