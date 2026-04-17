<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="PayPulse Admin Dashboard — overview of employees and payroll"/>
    <title>Dashboard — PayrollPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">

    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <header class="top-bar">
            <div>
                <div class="top-bar-title">Dashboard</div>
                <div class="top-bar-sub">Welcome back, <c:out value="${sessionScope.adminUser}"/>! Here's your overview.</div>
            </div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/employees?action=add" class="btn btn-primary btn-sm">
                    ➕ Add Employee
                </a>
                <a href="${pageContext.request.contextPath}/payroll?action=generate" class="btn btn-success btn-sm">
                    💰 Generate Salary
                </a>
            </div>
        </header>

        <div class="page-body">

            <!-- Flash messages from session -->
            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success">
                    <span class="alert-icon">✅</span> ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-error">
                    <span class="alert-icon">⚠️</span> ${sessionScope.errorMsg}
                </div>
                <c:remove var="errorMsg" scope="session"/>
            </c:if>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <a href="${pageContext.request.contextPath}/employees" class="stat-card stat-blue" style="text-decoration:none;">
                    <div class="stat-icon">👥</div>
                    <div class="stat-info">
                        <div class="stat-value">${totalEmployees}</div>
                        <div class="stat-label">Total Employees</div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/payroll" class="stat-card stat-green" style="text-decoration:none;">
                    <div class="stat-icon">📋</div>
                    <div class="stat-info">
                        <div class="stat-value">${totalPayrolls}</div>
                        <div class="stat-label">Payroll Records</div>
                    </div>
                </a>

                <div class="stat-card stat-purple">
                    <div class="stat-icon">🏢</div>
                    <div class="stat-info">
                        <div class="stat-value">${totalDepts}</div>
                        <div class="stat-label">Departments</div>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/payroll?action=generate" class="stat-card stat-orange" style="text-decoration:none;">
                    <div class="stat-icon">💰</div>
                    <div class="stat-info">
                        <div class="stat-value">Generate</div>
                        <div class="stat-label">Run Payroll</div>
                    </div>
                </a>
            </div>

            <!-- Recent Payroll Activity -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">📊 Recent Payroll Activity</div>
                    <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline btn-sm">View All</a>
                </div>

                <c:choose>
                    <c:when test="${not empty recentPayrolls}">
                        <div class="table-wrapper">
                            <table>
                                <thead>
                                    <tr>
                                        <th>#ID</th>
                                        <th>Employee</th>
                                        <th>Department</th>
                                        <th>Basic Salary</th>
                                        <th>Net Salary</th>
                                        <th>Pay Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${recentPayrolls}">
                                        <tr>
                                            <td class="td-mono">#<c:out value="${p.payrollId}"/></td>
                                            <td>
                                                <strong><c:out value="${p.empName}"/></strong>
                                            </td>
                                            <td>
                                                <span class="badge badge-blue">
                                                    <c:out value="${p.department}"/>
                                                </span>
                                            </td>
                                            <td>
                                                ₹<fmt:formatNumber value="${p.basicSalary}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="color:var(--accent-success); font-weight:700;">
                                                ₹<fmt:formatNumber value="${p.netSalary}" pattern="#,##0.00"/>
                                            </td>
                                            <td class="td-mono">
                                                <fmt:formatDate value="${p.payDate}" pattern="dd MMM yyyy"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-empty">
                            <div class="empty-icon">📭</div>
                            <p>No payroll records yet. <a href="${pageContext.request.contextPath}/payroll?action=generate">Generate your first salary slip</a>.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Quick Action Cards -->
            <div class="action-grid">
                <a href="${pageContext.request.contextPath}/employees?action=add" class="action-card">
                    <div class="action-icon">👤</div>
                    <div class="action-info">
                        <div class="action-title">Add New Employee</div>
                        <div class="action-desc">Register a new team member</div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/employees" class="action-card">
                    <div class="action-icon">🔍</div>
                    <div class="action-info">
                        <div class="action-title">Search Employees</div>
                        <div class="action-desc">Filter by name or department</div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/payroll?action=generate" class="action-card">
                    <div class="action-icon">📄</div>
                    <div class="action-info">
                        <div class="action-title">Generate Salary Slip</div>
                        <div class="action-desc">Compute and save payroll</div>
                    </div>
                </a>
            </div>

        </div><!-- /page-body -->
    </div><!-- /main-content -->
</div><!-- /app-wrapper -->

<script>
    // Auto-dismiss alerts after 4 seconds
    setTimeout(function () {
        document.querySelectorAll('.alert').forEach(function (el) {
            el.style.transition = 'opacity 0.6s ease';
            el.style.opacity = '0';
            setTimeout(function () { el.remove(); }, 600);
        });
    }, 4000);
</script>
</body>
</html>
