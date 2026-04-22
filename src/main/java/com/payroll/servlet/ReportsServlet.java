package com.payroll.servlet;

import com.payroll.dao.ReportDAO;
import com.payroll.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {
    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.requireAdmin(req, resp);
        String action = req.getParameter("action");
        
        if ("json".equals(action)) {
            resp.setContentType("application/json");
            PrintWriter out = resp.getWriter();
            Map<String, Double> deptData = reportDAO.getDepartmentWiseExpenditure();
            String json = "{" + deptData.entrySet().stream()
                    .map(e -> "\"" + e.getKey() + "\":" + e.getValue())
                    .collect(Collectors.joining(",")) + "}";
            out.print(json);
            return;
        }
        
        req.setAttribute("activePage", "reports");
        req.getRequestDispatcher("/WEB-INF/views/reports.jsp").forward(req, resp);
    }
}
