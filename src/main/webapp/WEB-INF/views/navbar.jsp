<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="sidebar">
    <div class="sidebar-logo">
        <a href="${pageContext.request.contextPath}/dashboard" style="display: flex; align-items: center; gap: 12px; text-decoration: none;">
            <img src="${pageContext.request.contextPath}/public/images/logo.webp" alt="PayPulse Logo" style="height: 38px; width: auto;">
            <span style="font-size: 1.5rem; font-weight: 800; color: var(--accent-primary); letter-spacing: -0.5px;">PayPulse</span>
        </a>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-label">Main Menu</div>

        <a href="${pageContext.request.contextPath}/dashboard"
           class="nav-item ${activePage eq 'dashboard' ? 'active' : ''}">
            <span class="nav-icon">🏠</span> Dashboard
        </a>

        <div class="nav-section-label" style="margin-top:16px;">Employees</div>

        <a href="${pageContext.request.contextPath}/employees"
           class="nav-item ${activePage eq 'employees' ? 'active' : ''}">
            <span class="nav-icon">👥</span> All Employees
        </a>
        
        <a href="${pageContext.request.contextPath}/departments"
           class="nav-item ${activePage eq 'departments' ? 'active' : ''}">
            <span class="nav-icon">🏢</span> Departments
        </a>

        <div class="nav-section-label" style="margin-top:16px;">Operations</div>

        <a href="${pageContext.request.contextPath}/attendance"
           class="nav-item ${activePage eq 'attendance' ? 'active' : ''}">
            <span class="nav-icon">📅</span> Attendance
        </a>

        <a href="${pageContext.request.contextPath}/leaves"
           class="nav-item ${activePage eq 'leaves' ? 'active' : ''}">
            <span class="nav-icon">🍃</span> Leave Requests
        </a>

        <div class="nav-section-label" style="margin-top:16px;">Payroll</div>

        <a href="${pageContext.request.contextPath}/payroll"
           class="nav-item ${activePage eq 'payroll' ? 'active' : ''}">
            <span class="nav-icon">📊</span> Payroll History
        </a>

        <a href="${pageContext.request.contextPath}/payroll?action=generate"
           class="nav-item ${activePage eq 'generateSalary' ? 'active' : ''}">
            <span class="nav-icon">💰</span> Generate Salary
        </a>
        
        <div class="nav-section-label" style="margin-top:16px;">Analytics</div>
        
        <a href="${pageContext.request.contextPath}/reports"
           class="nav-item ${activePage eq 'reports' ? 'active' : ''}">
            <span class="nav-icon">📈</span> Reports
        </a>
    </nav>

    <div class="sidebar-footer">
        <div class="sidebar-user">
            <div class="avatar">A</div>
            <div class="user-info">
                <div class="user-name">
                    <c:out value="${sessionScope.adminUser}" default="Admin"/>
                </div>
                <div class="user-role">Administrator</div>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item" style="margin-top:8px; color:var(--accent-danger);">
            <span class="nav-icon">🚪</span> Logout
        </a>
    </div>
</aside>
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const sidebar = document.querySelector('.sidebar');
    const overlay = document.getElementById('sidebarOverlay');
    const topBar = document.querySelector('.top-bar');

    if (topBar && !document.querySelector('.menu-toggle')) {
        const toggleBtn = document.createElement('button');
        toggleBtn.className = 'menu-toggle';
        toggleBtn.innerHTML = '☰';
        toggleBtn.onclick = toggleSidebar;
        topBar.prepend(toggleBtn);
    }

    function toggleSidebar() {
        sidebar.classList.toggle('open');
        overlay.classList.toggle('active');
    }

    overlay.onclick = toggleSidebar;
});
</script>
