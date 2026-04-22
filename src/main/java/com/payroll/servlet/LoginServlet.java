package com.payroll.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * LoginServlet - Handles admin authentication with session management.
 * GET  → renders login page
 * POST → validates credentials, starts session
 *
 * NOTE: For production, store hashed passwords in DB. This demo uses
 *       hardcoded credentials for simplicity — replace with DB lookup.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Demo credentials — replace with DB-backed auth in production
    private static final String ADMIN_USER = "admin";
    private static final String ADMIN_PASS = "admin123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // If already logged in, redirect to dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedIn") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Basic input validation
        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Username and password are required.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        if (ADMIN_USER.equals(username.trim()) && ADMIN_PASS.equals(password.trim())) {
            // Create session with 30-minute timeout
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedIn", true);
            session.setAttribute("adminUser", username.trim());
            session.setAttribute("role", "ADMIN");
            session.setMaxInactiveInterval(30 * 60);

            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } else {
            req.setAttribute("error", "Invalid username or password. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }
}
