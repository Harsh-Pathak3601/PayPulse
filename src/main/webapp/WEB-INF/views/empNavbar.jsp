<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="sidebar">
    <div class="sidebar-logo">
        <a href="${pageContext.request.contextPath}/emp-portal" style="display: flex; align-items: center; gap: 12px; text-decoration: none;">
            <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="PayPulse Logo" style="height: 38px; width: auto;">
            <span style="font-size: 1.5rem; font-weight: 800; color: var(--accent-primary); letter-spacing: -0.5px;">PayPulse</span>
        </a>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-label">Employee Portal</div>
        <a href="${pageContext.request.contextPath}/emp-portal" class="nav-item ${activePage eq 'dashboard' ? 'active' : ''}">
            <span class="nav-icon">🏠</span> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/leaves" class="nav-item ${activePage eq 'leaves' ? 'active' : ''}">
            <span class="nav-icon">🍃</span> Apply Leave
        </a>
        <a href="${pageContext.request.contextPath}/attendance" class="nav-item ${activePage eq 'attendance' ? 'active' : ''}">
            <span class="nav-icon">📅</span> My Attendance
        </a>
    </nav>
    <div class="sidebar-footer">
        <div class="sidebar-user">
            <div class="avatar">${not empty empName ? empName.substring(0,1) : 'E'}</div>
            <div class="user-info">
                <div class="user-name"><c:out value="${empName}" default="Employee"/></div>
                <div class="user-role">Employee</div>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="margin-top:8px; color:var(--accent-danger);">
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
