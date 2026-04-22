package com.payroll.servlet;

import com.payroll.dao.AttendanceDAO;
import com.payroll.dao.EmployeeDAO;
import com.payroll.model.Attendance;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessionUtil.isAdminLoggedIn(req)) {
            req.setAttribute("employees", employeeDAO.getAllEmployees());
            req.setAttribute("activePage", "attendance");
            req.getRequestDispatcher("/WEB-INF/views/markAttendance.jsp").forward(req, resp);
        } else if (SessionUtil.isEmployeeLoggedIn(req)) {
            int empId = (int) req.getSession().getAttribute("empId");
            LocalDate now = LocalDate.now();
            req.setAttribute("attendance", attendanceDAO.getMonthlyAttendance(empId, now.getMonthValue(), now.getYear()));
            req.getRequestDispatcher("/WEB-INF/views/viewAttendance.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);
        int empId = Integer.parseInt(req.getParameter("empId"));
        Date date = Date.valueOf(req.getParameter("date"));
        String status = req.getParameter("status");

        Attendance att = new Attendance();
        att.setEmpId(empId);
        att.setAttDate(date);
        att.setStatus(status);
        
        attendanceDAO.markAttendance(att);
        resp.sendRedirect(req.getContextPath() + "/attendance?success=1");
    }
}
