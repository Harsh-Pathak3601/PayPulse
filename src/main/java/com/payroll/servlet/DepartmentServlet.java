package com.payroll.servlet;

import com.payroll.dao.DepartmentDAO;
import com.payroll.model.Department;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/departments", "/dept"})
public class DepartmentServlet extends HttpServlet {
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.isAdminLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.setAttribute("activePage", "departments");
        req.getRequestDispatcher("/WEB-INF/views/manageDepartments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.isAdminLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        
        if ("add".equals(action)) {
            String name = req.getParameter("deptName");
            String head = req.getParameter("deptHead");
            
            if (name == null || name.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Department name is required.");
            } else {
                Department d = new Department();
                d.setDeptName(name.trim());
                d.setDeptHead(head != null ? head.trim() : "");
                
                if (departmentDAO.addDepartment(d)) {
                    session.setAttribute("successMsg", "Department '" + name + "' added successfully!");
                } else {
                    session.setAttribute("errorMsg", "Failed to add department. It might already exist.");
                }
            }
        } else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("deptId"));
                if (departmentDAO.deleteDepartment(id)) {
                    session.setAttribute("successMsg", "Department deleted successfully.");
                } else {
                    session.setAttribute("errorMsg", "Failed to delete department.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Invalid Department ID.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/departments");
    }
}
