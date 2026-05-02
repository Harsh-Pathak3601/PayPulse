package com.payroll.servlet;

import com.payroll.dao.LeaveDAO;
import com.payroll.model.Leave;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/leaves")
public class LeaveServlet extends HttpServlet {
    private final LeaveDAO leaveDAO = new LeaveDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessionUtil.isAdminLoggedIn(req)) {
            req.setAttribute("pendingLeaves", leaveDAO.getPendingLeaves());
            req.setAttribute("activePage", "leaves");
            req.getRequestDispatcher("/WEB-INF/views/manageLeaves.jsp").forward(req, resp);
        } else if (SessionUtil.isEmployeeLoggedIn(req)) {
            req.getRequestDispatcher("/WEB-INF/views/applyLeave.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        if ("apply".equals(action)) {
            if (!SessionUtil.isEmployeeLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/emp-login");
                return;
            }
            Leave l = new Leave();
            l.setEmpId((int) req.getSession().getAttribute("empId"));
            l.setLeaveType(req.getParameter("type"));
            l.setStartDate(Date.valueOf(req.getParameter("startDate")));
            l.setEndDate(Date.valueOf(req.getParameter("endDate")));
            l.setTotalDays(Integer.parseInt(req.getParameter("totalDays")));
            l.setReason(req.getParameter("reason"));
            leaveDAO.applyLeave(l);
            resp.sendRedirect(req.getContextPath() + "/emp-portal?msg=LeaveApplied");
        } else if ("approve".equals(action) || "reject".equals(action)) {
            if (!SessionUtil.isAdminLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            int id = Integer.parseInt(req.getParameter("leaveId"));
            String status = action.toUpperCase() + "D"; // APPROVED or REJECTED
            String remarks = req.getParameter("remarks");
            leaveDAO.updateLeaveStatus(id, status, remarks);
            resp.sendRedirect(req.getContextPath() + "/leaves");
        } else {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }
}
