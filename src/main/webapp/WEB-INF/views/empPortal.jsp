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
            
            <!-- Alert Messages -->
            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success" style="margin-bottom: 20px; padding: 12px; background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; border-radius: 8px;">
                    ✅ ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-error" style="margin-bottom: 20px; padding: 12px; background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; border-radius: 8px;">
                    ⚠️ ${sessionScope.errorMsg}
                </div>
                <c:remove var="errorMsg" scope="session"/>
            </c:if>

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

            <!-- Change Password Section -->
            <div class="card" style="margin-top: 20px; max-width: 600px;">
                <div class="card-header"><div class="card-title">🔒 Change Password</div></div>
                <div class="card-body" style="padding: 20px;">
                    <form action="${pageContext.request.contextPath}/emp-portal" method="POST">
                        <input type="hidden" name="action" value="changePassword"/>
                        
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label class="form-label">Current Password</label>
                            <input type="password" name="currentPassword" class="form-control" required/>
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label class="form-label">New Password</label>
                            <input type="password" name="newPassword" class="form-control" minlength="6" required/>
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 20px;">
                            <label class="form-label">Confirm New Password</label>
                            <input type="password" name="confirmPassword" class="form-control" minlength="6" required/>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Update Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
