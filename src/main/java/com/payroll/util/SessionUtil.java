package com.payroll.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class SessionUtil {

    public static boolean isAdminLoggedIn(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && session.getAttribute("loggedIn") != null && "ADMIN".equals(session.getAttribute("role"));
    }

    public static boolean isEmployeeLoggedIn(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && session.getAttribute("empLoggedIn") != null && "EMPLOYEE".equals(session.getAttribute("role"));
    }

    public static void requireAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!isAdminLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    public static void requireEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!isEmployeeLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/emp-login");
        }
    }
}
