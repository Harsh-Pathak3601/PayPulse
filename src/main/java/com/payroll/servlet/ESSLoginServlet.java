package com.payroll.servlet;

import com.payroll.dao.EmployeeDAO;
import com.payroll.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/emp-login")
public class ESSLoginServlet extends HttpServlet {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/empLogin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        
        Employee emp = employeeDAO.authenticateEmployee(email, pass);
        if (emp != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("empLoggedIn", true);
            session.setAttribute("empId", emp.getEmpId());
            session.setAttribute("empName", emp.getName());
            session.setAttribute("role", "EMPLOYEE");
            resp.sendRedirect(req.getContextPath() + "/emp-portal");
        } else {
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("/WEB-INF/views/empLogin.jsp").forward(req, resp);
        }
    }
}
