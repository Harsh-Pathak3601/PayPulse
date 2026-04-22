package com.payroll.servlet;

import com.payroll.dao.DepartmentDAO;
import com.payroll.model.Department;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/departments")
public class DepartmentServlet extends HttpServlet {
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.setAttribute("activePage", "departments");
        req.getRequestDispatcher("/WEB-INF/views/manageDepartments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);
        String action = req.getParameter("action");
        
        if ("add".equals(action)) {
            String name = req.getParameter("deptName");
            String head = req.getParameter("deptHead");
            Department d = new Department();
            d.setDeptName(name);
            d.setDeptHead(head);
            departmentDAO.addDepartment(d);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("deptId"));
            departmentDAO.deleteDepartment(id);
        }
        resp.sendRedirect(req.getContextPath() + "/departments");
    }
}
