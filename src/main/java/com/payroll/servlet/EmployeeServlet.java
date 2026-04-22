package com.payroll.servlet;

import com.payroll.dao.DepartmentDAO;
import com.payroll.dao.EmployeeDAO;
import com.payroll.model.Employee;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    private final com.payroll.dao.DesignationDAO designationDAO = new com.payroll.dao.DesignationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);

        String action = req.getParameter("action");
        System.out.println("[EmployeeServlet] Received request for action: " + action);

        if ("add".equals(action)) {
            var depts = departmentDAO.getAllDepartments();
            var desigs = designationDAO.getAllDesignations();
            System.out.println("[EmployeeServlet] Loading Add Form. Depts: " + depts.size() + ", Desigs: " + desigs.size());
            
            req.setAttribute("departments", depts);
            req.setAttribute("designations", desigs);
            req.setAttribute("activePage", "addEmployee");
            req.getRequestDispatcher("/WEB-INF/views/addEmployee.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("employee", employeeDAO.getEmployeeById(id));
            req.setAttribute("departments", departmentDAO.getAllDepartments());
            req.setAttribute("designations", designationDAO.getAllDesignations());
            req.getRequestDispatcher("/WEB-INF/views/editEmployee.jsp").forward(req, resp);
        } else {
            req.setAttribute("employees", employeeDAO.getAllEmployees());
            req.setAttribute("activePage", "employees");
            req.getRequestDispatcher("/WEB-INF/views/viewEmployees.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);
        
        String action = req.getParameter("action");
        Employee emp = new Employee();
        emp.setName(req.getParameter("name"));
        emp.setEmail(req.getParameter("email"));
        emp.setPhone(req.getParameter("phone"));
        emp.setDeptId(Integer.parseInt(req.getParameter("deptId")));
        emp.setDesignation(req.getParameter("designation"));
        emp.setBasicSalary(Double.parseDouble(req.getParameter("basicSalary")));
        emp.setJoinDate(Date.valueOf(req.getParameter("joinDate")));
        emp.setEmployeeType(req.getParameter("employeeType"));

        if ("add".equals(action)) {
            emp.setPasswordHash(req.getParameter("password")); // Demo: plain text. Real: use hash.
            employeeDAO.addEmployee(emp);
        } else if ("edit".equals(action)) {
            emp.setEmpId(Integer.parseInt(req.getParameter("empId")));
            employeeDAO.updateEmployee(emp);
        } else if ("delete".equals(action)) {
            employeeDAO.deleteEmployee(Integer.parseInt(req.getParameter("empId")));
        }
        
        resp.sendRedirect(req.getContextPath() + "/employees");
    }
}
