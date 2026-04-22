<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activePage" value="employees" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="View and manage all employees — PayPulse"/>
    <title>Employees — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div>
                <div class="top-bar-title">👥 Employees</div>
                <div class="top-bar-sub">Manage your organization's workforce</div>
            </div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/employees?action=add" class="btn btn-primary btn-sm">
                    ➕ Add Employee
                </a>
            </div>
        </header>

        <div class="page-body">

            <!-- Flash Messages -->
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

            <!-- Search & Filter Bar -->
            <form method="get" action="${pageContext.request.contextPath}/employees" id="filterForm">
                <div class="filter-bar">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input
                            type="text"
                            name="search"
                            id="searchInput"
                            placeholder="Search by name or designation…"
                            value="<c:out value='${search}'/>"
                        />
                    </div>

                    <select name="department" id="deptFilter" class="filter-select" onchange="this.form.submit()">
                        <option value="">All Departments</option>
                        <c:forEach var="dept" items="${departments}">
                            <option value="${dept}"
                                <c:if test="${dept eq filterDept}">selected</c:if>>
                                <c:out value="${dept}"/>
                            </option>
                        </c:forEach>
                    </select>

                    <button type="submit" class="btn btn-primary btn-sm">Filter</button>

                    <c:if test="${not empty search or not empty filterDept}">
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline btn-sm">✕ Clear</a>
                    </c:if>
                </div>
            </form>

            <!-- Employee Table -->
            <div class="card" style="padding:0;">
                <div class="card-header" style="padding:18px 24px; margin-bottom:0;">
                    <div class="card-title">
                        Employee Records
                        <span class="badge badge-blue" style="margin-left:8px;">${fn:length(employees)} found</span>
                    </div>
                </div>

                <div class="table-wrapper" style="border:none; border-radius:0 0 var(--radius-lg) var(--radius-lg);">
                    <table>
                        <thead>
                            <tr>
                                <th>Emp ID</th>
                                <th>Name</th>
                                <th>Department</th>
                                <th>Designation</th>
                                <th>Basic Salary</th>
                                <th>Join Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty employees}">
                                    <c:forEach var="emp" items="${employees}">
                                        <tr>
                                            <td class="td-mono">EMP-<c:out value="${emp.empId}"/></td>
                                            <td>
                                                <strong><c:out value="${emp.name}"/></strong>
                                            </td>
                                            <td>
                                                <span class="badge badge-blue">
                                                    <c:out value="${emp.department}"/>
                                                </span>
                                            </td>
                                            <td><c:out value="${emp.designation}"/></td>
                                            <td>
                                                ₹<fmt:formatNumber value="${emp.basicSalary}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="color:var(--text-muted);">
                                                <fmt:formatDate value="${emp.joinDate}" pattern="MMM dd, yyyy"/>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-8">
                                                    <!-- Edit -->
                                                    <a href="${pageContext.request.contextPath}/employees?action=edit&id=${emp.empId}"
                                                       class="btn btn-warning btn-sm" title="Edit Employee">
                                                        ✏️ Edit
                                                    </a>
                                                    <!-- Payroll History -->
                                                    <a href="${pageContext.request.contextPath}/payroll?action=history&empId=${emp.empId}"
                                                       class="btn btn-outline btn-sm" title="Payroll History">
                                                        📋 History
                                                    </a>
                                                    <!-- Generate Salary -->
                                                    <a href="${pageContext.request.contextPath}/payroll?action=generate"
                                                       class="btn btn-primary btn-sm" title="Generate Salary">
                                                        💰
                                                    </a>
                                                    <!-- Delete -->
                                                    <button
                                                        type="button"
                                                        class="btn btn-danger btn-sm delete-btn"
                                                        data-id="${emp.empId}"
                                                        data-name="<c:out value='${emp.name}'/>"
                                                        title="Delete Employee">
                                                        🗑️
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7">
                                            <div class="table-empty">
                                                <div class="empty-icon">👤</div>
                                                <p>No employees found.
                                                    <c:choose>
                                                        <c:when test="${not empty search or not empty filterDept}">
                                                            <a href="${pageContext.request.contextPath}/employees">Clear filters</a> or
                                                        </c:when>
                                                    </c:choose>
                                                    <a href="${pageContext.request.contextPath}/employees?action=add">Add the first employee</a>.
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,0.7); z-index:1000; align-items:center; justify-content:center;">
    <div style="background:var(--bg-card); border:1px solid var(--border-color); border-radius:var(--radius-lg); padding:32px; max-width:420px; width:90%; text-align:center;">
        <div style="font-size:3rem; margin-bottom:16px;">⚠️</div>
        <h3 style="margin-bottom:8px;">Delete Employee?</h3>
        <p id="deleteMsg" style="color:var(--text-muted); font-size:0.9rem; margin-bottom:24px;"></p>
        <div class="d-flex gap-12" style="justify-content:center;">
            <button type="button" id="cancelDeleteBtn" class="btn btn-outline">Cancel</button>
            <a id="deleteConfirmLink" href="#" class="btn btn-danger">🗑️ Delete</a>
        </div>
    </div>
</div>

<script>
    var contextPath = '${pageContext.request.contextPath}';

    // Attach click handlers to all delete buttons via data attributes
    document.querySelectorAll('.delete-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var empId   = this.getAttribute('data-id');
            var empName = this.getAttribute('data-name');
            document.getElementById('deleteMsg').textContent =
                'Are you sure you want to delete "' + empName + '"? This will also remove all their payroll records.';
            document.getElementById('deleteConfirmLink').href =
                contextPath + '/employees?action=delete&id=' + empId;
            document.getElementById('deleteModal').style.display = 'flex';
        });
    });

    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
    }

    document.getElementById('cancelDeleteBtn').addEventListener('click', closeDeleteModal);

    // Close on backdrop click
    document.getElementById('deleteModal').addEventListener('click', function (e) {
        if (e.target === this) closeDeleteModal();
    });

    // Auto-dismiss alerts
    setTimeout(function () {
        document.querySelectorAll('.alert').forEach(function (el) {
            el.style.transition = 'opacity 0.6s';
            el.style.opacity = '0';
            setTimeout(function () { el.remove(); }, 600);
        });
    }, 4000);
</script>
</body>
</html>
