<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Employee Portal — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/empNavbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">Welcome, ${empName}</div>
        </header>
        <div class="page-body">
            <div class="stats-grid">
                <div class="stat-card stat-blue">
                    <div class="stat-info">
                        <div class="stat-value">#${employee.empId}</div>
                        <div class="stat-label">Employee ID</div>
                    </div>
                </div>
                <div class="stat-card stat-purple">
                    <div class="stat-info">
                        <div class="stat-value">${employee.department}</div>
                        <div class="stat-label">Department</div>
                    </div>
                </div>
                <div class="stat-card stat-green">
                    <div class="stat-info">
                        <div class="stat-value">₹<fmt:formatNumber value="${employee.basicSalary}" pattern="#,###"/></div>
                        <div class="stat-label">Basic Salary</div>
                    </div>
                </div>
            </div>

            <div class="card" style="margin-top: 20px;">
                <div class="card-header"><div class="card-title">📜 My Payroll History</div></div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Month</th>
                                <th>Gross</th>
                                <th>Deductions</th>
                                <th>Net Salary</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${payrolls}">
                                <tr>
                                    <td><fmt:formatDate value="${p.payDate}" pattern="MMMM yyyy"/></td>
                                    <td>₹<fmt:formatNumber value="${p.grossSalary}" pattern="#,##0.00"/></td>
                                    <td style="color:var(--accent-danger)">₹<fmt:formatNumber value="${p.totalDeductions}" pattern="#,##0.00"/></td>
                                    <td style="color:var(--accent-success); font-weight:700;">₹<fmt:formatNumber value="${p.netSalary}" pattern="#,##0.00"/></td>
                                    <td><a href="#" class="btn btn-outline btn-sm">View Slip</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
