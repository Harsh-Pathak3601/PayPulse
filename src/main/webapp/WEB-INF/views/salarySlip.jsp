<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="generateSalary" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Salary Slip — PayPulse"/>
    <title>Salary Slip — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <style>
        @media print {
            .sidebar, .main-content > header, .no-print { display: none !important; }
            .main-content { margin-left: 0; }
            .slip-container { max-width: 100%; }
            body { background: #fff; color: #000; }
        }
    </style>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <div class="main-content">
        <header class="top-bar no-print">
            <div>
                <div class="top-bar-title">📄 Salary Slip</div>
                <div class="top-bar-sub">Generated successfully for <strong><c:out value="${employee.name}"/></strong></div>
            </div>
            <div class="top-bar-actions">
                <button onclick="window.print()" class="btn btn-outline btn-sm">🖨️ Print Slip</button>
                <a href="${pageContext.request.contextPath}/payroll?action=generate" class="btn btn-primary btn-sm">
                    💰 Generate Another
                </a>
            </div>
        </header>

        <div class="page-body">

            <div class="alert alert-success no-print" style="max-width:680px; margin:0 auto 20px auto;">
                <span class="alert-icon">✅</span>
                Salary slip for <strong><c:out value="${employee.name}"/></strong> has been generated and saved successfully!
            </div>

            <div class="slip-container">
                <!-- Slip Header -->
                <div class="slip-header">
                    <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="PayPulse Logo" style="height: 50px; width: auto; margin-bottom: 12px;">
                    <p style="font-size: 1.1rem; font-weight: 700; color: #fff; margin-bottom: 4px;">PayPulse</p>
                    <p>Employee Salary Slip</p>
                    <p style="margin-top:6px; font-size:0.8rem;">
                        Pay Date: <fmt:formatDate value="${payroll.payDate}" pattern="dd MMMM yyyy"/>
                    </p>
                </div>

                <div class="slip-body">
                    <!-- Employee Info -->
                    <div class="slip-employee-info">
                        <div class="slip-info-item">
                            <div class="label">Employee Name</div>
                            <div class="value"><c:out value="${employee.name}"/></div>
                        </div>
                        <div class="slip-info-item">
                            <div class="label">Employee ID</div>
                            <div class="value">EMP-<c:out value="${employee.empId}"/></div>
                        </div>
                        <div class="slip-info-item">
                            <div class="label">Department</div>
                            <div class="value"><c:out value="${employee.department}"/></div>
                        </div>
                        <div class="slip-info-item">
                            <div class="label">Designation</div>
                            <div class="value"><c:out value="${employee.designation}"/></div>
                        </div>
                        <div class="slip-info-item">
                            <div class="label">Payroll ID</div>
                            <div class="value">#<c:out value="${payroll.payrollId}"/></div>
                        </div>
                        <div class="slip-info-item">
                            <div class="label">Pay Period</div>
                            <div class="value"><fmt:formatDate value="${payroll.payDate}" pattern="MMMM yyyy"/></div>
                        </div>
                    </div>

                    <!-- Earnings -->
                    <div style="font-size:0.72rem; font-weight:600; color:var(--text-muted); text-transform:uppercase; letter-spacing:0.06em; margin-bottom:10px;">
                        Earnings
                    </div>

                    <div class="slip-row">
                        <span class="row-label">Basic Salary</span>
                        <span class="row-value">₹<fmt:formatNumber value="${payroll.basicSalary}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="slip-row">
                        <span class="row-label">House Rent Allowance (HRA) — 20%</span>
                        <span class="row-value positive">+ ₹<fmt:formatNumber value="${payroll.hra}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="slip-row">
                        <span class="row-label">Dearness Allowance (DA) — 10%</span>
                        <span class="row-value positive">+ ₹<fmt:formatNumber value="${payroll.da}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="slip-row">
                        <span class="row-label">Performance Bonus — 5%</span>
                        <span class="row-value positive">+ ₹<fmt:formatNumber value="${payroll.bonus}" pattern="#,##0.00"/></span>
                    </div>

                    <!-- Deductions -->
                    <div style="font-size:0.72rem; font-weight:600; color:var(--text-muted); text-transform:uppercase; letter-spacing:0.06em; margin:16px 0 10px;">
                        Deductions
                    </div>

                    <div class="slip-row">
                        <span class="row-label">Total Deductions — 5%</span>
                        <span class="row-value negative">− ₹<fmt:formatNumber value="${payroll.deductions}" pattern="#,##0.00"/></span>
                    </div>

                    <!-- Net Salary -->
                    <div class="slip-total">
                        <span class="total-label">💵 Net Salary</span>
                        <span class="total-amount">₹<fmt:formatNumber value="${payroll.netSalary}" pattern="#,##0.00"/></span>
                    </div>

                    <!-- Footer note -->
                    <div style="margin-top:20px; padding:12px; background:rgba(88,166,255,0.07); border:1px solid rgba(88,166,255,0.2); border-radius:var(--radius-md); font-size:0.78rem; color:var(--text-muted); text-align:center;">
                        This is a system-generated salary slip and does not require a signature.
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-12 no-print" style="margin-top:20px; justify-content:center;">
                        <button onclick="window.print()" class="btn btn-primary">🖨️ Print / Save as PDF</button>
                        <a href="${pageContext.request.contextPath}/payroll?action=history&empId=${employee.empId}" class="btn btn-outline">
                            📋 View History
                        </a>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline">
                            👥 Employees
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>
