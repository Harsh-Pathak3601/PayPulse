<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>My Attendance — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <!-- Include Employee Sidebar (if applicable) or use simplified nav -->
    <aside class="sidebar">
        <div class="sidebar-logo">
            <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="Logo" style="height: 38px;"/>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/emp-portal" class="nav-item"><span class="nav-icon">🏠</span> Dashboard</a>
            <a href="${pageContext.request.contextPath}/leaves" class="nav-item"><span class="nav-icon">🍃</span> Apply Leave</a>
            <a href="${pageContext.request.contextPath}/attendance" class="nav-item active"><span class="nav-icon">📅</span> My Attendance</a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--accent-danger);"><span class="nav-icon">🚪</span> Logout</a>
        </div>
    </aside>

    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">📅 My Attendance Record</div>
        </header>
        <div class="page-body">
            <div class="card">
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>Overtime Hours</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="att" items="${attendance}">
                                <tr>
                                    <td><fmt:formatDate value="${att.attDate}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${att.status == 'PRESENT'}">
                                                <span class="badge badge-success">Present</span>
                                            </c:when>
                                            <c:when test="${att.status == 'ABSENT'}">
                                                <span class="badge badge-danger">Absent</span>
                                            </c:when>
                                            <c:when test="${att.status == 'HALF_DAY'}">
                                                <span class="badge badge-warning">Half Day</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">${att.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${att.checkIn != null ? att.checkIn : '--:--'}</td>
                                    <td>${att.checkOut != null ? att.checkOut : '--:--'}</td>
                                    <td>${att.overtimeHours}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty attendance}">
                                <tr>
                                    <td colspan="5" class="text-center">No attendance records found for this month.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
