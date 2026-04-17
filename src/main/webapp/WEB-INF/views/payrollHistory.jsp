<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="payroll" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Payroll History — PayPulse"/>
    <title>Payroll History — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div>
                <div class="top-bar-title">
                    <c:choose>
                        <c:when test="${not empty employee}">
                            📋 Payroll History — <c:out value="${employee.name}"/>
                        </c:when>
                        <c:otherwise>📊 All Payroll Records</c:otherwise>
                    </c:choose>
                </div>
                <div class="top-bar-sub">
                    <c:choose>
                        <c:when test="${not empty employee}">
                            Showing <strong>${payrolls.size()}</strong> record(s) for
                            <strong><c:out value="${employee.name}"/></strong>
                            (${employee.department} — ${employee.designation})
                        </c:when>
                        <c:otherwise>Complete payroll history across all employees</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/payroll?action=generate" class="btn btn-success btn-sm">
                    💰 Generate Salary
                </a>
                <c:if test="${not empty employee}">
                    <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline btn-sm">
                        📊 All Records
                    </a>
                </c:if>
            </div>
        </header>

        <div class="page-body">

            <c:choose>
                <c:when test="${not empty payrolls}">
                    <div class="card" style="padding:0;">
                        <div class="card-header" style="padding:18px 24px; margin-bottom:0;">
                            <div class="card-title">
                                Payroll Records
                                <span class="badge badge-green" style="margin-left:8px;">${payrolls.size()} total</span>
                            </div>
                        </div>

                        <div class="table-wrapper" style="border:none; border-radius:0 0 var(--radius-lg) var(--radius-lg);">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Slip ID</th>
                                        <th>Employee</th>
                                        <th>Department</th>
                                        <th>Basic</th>
                                        <th>HRA</th>
                                        <th>DA</th>
                                        <th>Bonus</th>
                                        <th>Deductions</th>
                                        <th>Net Salary</th>
                                        <th>Pay Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${payrolls}">
                                        <tr>
                                            <td class="td-mono">#<c:out value="${p.payrollId}"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/payroll?action=history&empId=${p.empId}"
                                                   style="color:var(--text-link); font-weight:600;">
                                                    <c:out value="${p.empName}"/>
                                                </a>
                                                <br/><span class="td-mono" style="font-size:0.7rem;">EMP-${p.empId}</span>
                                            </td>
                                            <td>
                                                <span class="badge badge-blue"><c:out value="${p.department}"/></span>
                                            </td>
                                            <td>₹<fmt:formatNumber value="${p.basicSalary}" pattern="#,##0.00"/></td>
                                            <td style="color:var(--accent-success);">
                                                ₹<fmt:formatNumber value="${p.hra}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="color:var(--accent-success);">
                                                ₹<fmt:formatNumber value="${p.da}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="color:var(--accent-success);">
                                                ₹<fmt:formatNumber value="${p.bonus}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="color:var(--accent-danger);">
                                                ₹<fmt:formatNumber value="${p.deductions}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="font-weight:800; color:var(--accent-primary); font-size:0.95rem;">
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
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <div class="table-empty">
                            <div class="empty-icon">📭</div>
                            <p>
                                <c:choose>
                                    <c:when test="${not empty employee}">
                                        No payroll records for <strong><c:out value="${employee.name}"/></strong> yet.
                                    </c:when>
                                    <c:otherwise>No payroll records found.</c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/payroll?action=generate">Generate the first salary slip</a>.
                            </p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
</body>
</html>
