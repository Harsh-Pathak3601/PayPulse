<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard — PayPulse v2.0</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div>
                <div class="top-bar-title">Dashboard</div>
                <div class="top-bar-sub">Welcome back, <c:out value="${sessionScope.adminUser}"/>! Overview of your enterprise.</div>
            </div>
        </header>

        <div class="page-body">
        <div class="stats-grid">
                <div class="stat-card stat-blue">
                    <div class="stat-icon">👥</div>
                    <div class="stat-info">
                        <div class="stat-value">${totalEmployees}</div>
                        <div class="stat-label">Total Employees</div>
                    </div>
                </div>
                <div class="stat-card stat-purple">
                    <div class="stat-icon">🏢</div>
                    <div class="stat-info">
                        <div class="stat-value">${totalDepts}</div>
                        <div class="stat-label">Departments</div>
                    </div>
                </div>
                <div class="stat-card stat-green">
                    <div class="stat-icon">📋</div>
                    <div class="stat-info">
                        <div class="stat-value">${totalPayrolls}</div>
                        <div class="stat-label">Payroll Records</div>
                    </div>
                </div>
                <div class="stat-card stat-orange">
                    <div class="stat-icon">💰</div>
                    <div class="stat-info">
                        <div class="stat-value">₹<fmt:formatNumber value="${monthlySpend}" pattern="#,##0" maxFractionDigits="0"/></div>
                        <div class="stat-label">Monthly Payroll Spend</div>
                    </div>
                </div>
            </div>

            <div class="card" style="margin-top: 24px;">
                <div class="card-header">
                    <div class="card-title">📈 Salary Expenditure by Department</div>
                </div>
                <div style="max-width: 420px; margin: 0 auto; padding: 16px 20px 20px;">
                    <canvas id="deptChart"></canvas>
                </div>
            </div>
            
            <!-- Recent Payroll Activity -->
            <div class="card" style="margin-top: 20px;">
                <div class="card-header">
                    <div class="card-title">📊 Recent Payroll Activity</div>
                </div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Employee</th>
                                <th>Gross</th>
                                <th>Deductions</th>
                                <th>Net Salary</th>
                                <th>Pay Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${recentPayrolls}">
                                <tr>
                                    <td><strong><c:out value="${p.empName}"/></strong></td>
                                    <td>₹<fmt:formatNumber value="${p.grossSalary}" pattern="#,##0.00"/></td>
                                    <td style="color:var(--accent-danger)">₹<fmt:formatNumber value="${p.totalDeductions}" pattern="#,##0.00"/></td>
                                    <td style="color:var(--accent-success); font-weight:700;">₹<fmt:formatNumber value="${p.netSalary}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatDate value="${p.payDate}" pattern="dd MMM yyyy"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    fetch('${pageContext.request.contextPath}/reports?action=json')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('deptChart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: Object.keys(data),
                    datasets: [{
                        data: Object.values(data),
                        backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'bottom', labels: { color: '#ffffff' } }
                    }
                }
            });
        });
</script>
</body>
</html>
