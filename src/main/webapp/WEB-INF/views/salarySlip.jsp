<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Salary Slip — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <style>
        @media print { .no-print { display: none; } .sidebar { display: none; } .main-content { margin: 0; padding: 0; width: 100%; } }
        .slip-container { max-width: 800px; margin: 20px auto; padding: 40px; background: white; color: #333; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .slip-header { border-bottom: 2px solid #eee; padding-bottom: 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .slip-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .slip-table th, .slip-table td { padding: 12px; border: 1px solid #eee; text-align: left; }
        .slip-table th { background: #f8f9fa; }
        .total-row { font-weight: bold; font-size: 1.1em; background: #f1f3f5 !important; }
    </style>
</head>
<body style="background: var(--bg-deep);">
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <div class="page-body">
            <div class="no-print" style="margin-bottom: 20px; display: flex; justify-content: space-between;">
                <button onclick="window.print()" class="btn btn-success">🖨️ Print Slip</button>
                <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline">Back to History</a>
            </div>

            <div class="slip-container">
                <div class="slip-header">
                    <div>
                        <h1 style="margin:0; color:var(--accent-primary);">PayPulse</h1>
                        <p style="margin:5px 0; color:#666;">Enterprise Payroll Solutions</p>
                    </div>
                    <div style="text-align: right;">
                        <h3 style="margin:0;">SALARY SLIP</h3>
                        <p style="margin:5px 0;">Date: <fmt:formatDate value="${payroll.payDate}" pattern="MMMM yyyy"/></p>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 40px; margin-bottom: 30px;">
                    <div>
                        <p><strong>Employee ID:</strong> #${payroll.empId}</p>
                        <p><strong>Name:</strong> <c:out value="${payroll.empName}"/></p>
                        <p><strong>Department:</strong> <c:out value="${payroll.department}"/></p>
                    </div>
                    <div style="text-align: right;">
                        <p><strong>Paid Days:</strong> ${payroll.paidDays} / ${payroll.workingDays}</p>
                        <p><strong>Status:</strong> Generated</p>
                    </div>
                </div>

                <table class="slip-table">
                    <thead>
                        <tr>
                            <th>Earnings</th>
                            <th>Amount (₹)</th>
                            <th>Deductions</th>
                            <th>Amount (₹)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Basic Salary</td>
                            <td><fmt:formatNumber value="${payroll.basicSalary}" pattern="#,##0.00"/></td>
                            <td>Provident Fund (PF)</td>
                            <td><fmt:formatNumber value="${payroll.pfDeduction}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr>
                            <td>House Rent Allowance (HRA)</td>
                            <td><fmt:formatNumber value="${payroll.hra}" pattern="#,##0.00"/></td>
                            <td>ESI Deduction</td>
                            <td><fmt:formatNumber value="${payroll.esiDeduction}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr>
                            <td>Dearness Allowance (DA)</td>
                            <td><fmt:formatNumber value="${payroll.da}" pattern="#,##0.00"/></td>
                            <td>Income Tax (TDS)</td>
                            <td><fmt:formatNumber value="${payroll.tdsDeduction}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr>
                            <td>Performance Bonus</td>
                            <td><fmt:formatNumber value="${payroll.bonus}" pattern="#,##0.00"/></td>
                            <td>Loss of Pay (LOP)</td>
                            <td><fmt:formatNumber value="${payroll.lopDeduction}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr class="total-row">
                            <td>Gross Earnings</td>
                            <td>₹<fmt:formatNumber value="${payroll.grossSalary}" pattern="#,##0.00"/></td>
                            <td>Total Deductions</td>
                            <td>₹<fmt:formatNumber value="${payroll.totalDeductions}" pattern="#,##0.00"/></td>
                        </tr>
                    </tbody>
                </table>

                <div style="margin-top: 40px; padding: 20px; background: #e7f5ff; border-radius: 4px; text-align: center;">
                    <h2 style="margin:0; color:#1971c2;">Net Salary Payable: ₹<fmt:formatNumber value="${payroll.netSalary}" pattern="#,##0.00"/></h2>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
