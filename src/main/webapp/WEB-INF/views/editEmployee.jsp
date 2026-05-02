<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="employees" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Edit Employee — PayPulse"/>
    <title>Edit Employee — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div>
                <div class="top-bar-title">✏️ Edit Employee</div>
                <div class="top-bar-sub">Update details for <strong><c:out value="${employee.name}"/></strong></div>
            </div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline btn-sm">
                    ← Back to Employees
                </a>
            </div>
        </header>

        <div class="page-body">
            <div class="card" style="max-width:780px;">
                <div class="card-header">
                    <div class="card-title">
                        👤 Employee #<c:out value="${employee.empId}"/>
                    </div>
                    <span class="badge badge-blue">Editing</span>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error mb-16">
                        <span class="alert-icon">⚠️</span> ${error}
                    </div>
                </c:if>

                <form
                    method="post"
                    action="${pageContext.request.contextPath}/employees"
                    id="editEmpForm"
                    novalidate
                >
                    <input type="hidden" name="action" value="edit"/>
                    <input type="hidden" name="empId" value="${employee.empId}"/>

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="name">Full Name <span class="required">*</span></label>
                            <input
                                type="text"
                                id="name"
                                name="name"
                                required
                                minlength="2"
                                maxlength="100"
                                value="<c:out value='${employee.name}'/>"
                            />
                        </div>

                        <div class="form-group">
                            <label for="deptId">Department <span class="required">*</span></label>
                            <select name="deptId" id="deptId" class="form-control" required>
                                <c:forEach var="d" items="${departments}">
                                    <option value="${d.deptId}" ${d.deptId == employee.deptId ? 'selected' : ''}>
                                        ${d.deptName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="designation">Designation <span class="required">*</span></label>
                            <select name="designation" id="designation" class="form-control" required>
                                <c:forEach var="des" items="${designations}">
                                    <option value="${des.desigName}" ${des.desigName == employee.designation ? 'selected' : ''}>
                                        ${des.desigName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="basicSalary">Basic Salary (₹) <span class="required">*</span></label>
                            <input
                                type="number"
                                id="basicSalary"
                                name="basicSalary"
                                required
                                min="1"
                                step="0.01"
                                value="<fmt:formatNumber value='${employee.basicSalary}' pattern='#.##'/>"
                            />
                            <span class="input-hint">Changing salary affects future payroll calculations. Existing records remain unchanged.</span>
                        </div>
                    </div>

                    <!-- Salary Preview -->
                    <div id="salaryPreview" style="margin-top:20px; padding:16px; background:var(--bg-secondary); border:1px solid var(--border-color); border-radius:var(--radius-md);">
                        <div style="font-size:0.8rem; font-weight:600; color:var(--text-muted); margin-bottom:12px; text-transform:uppercase; letter-spacing:0.06em;">
                            💡 Current Salary Breakdown
                        </div>
                        <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(140px,1fr)); gap:12px;">
                            <div><div style="font-size:0.72rem; color:var(--text-muted);">Basic</div><div id="previewBasic" style="font-weight:700; color:var(--text-primary);">—</div></div>
                            <div><div style="font-size:0.72rem; color:var(--text-muted);">HRA (20%)</div><div id="previewHra" style="font-weight:700; color:var(--accent-success);">—</div></div>
                            <div><div style="font-size:0.72rem; color:var(--text-muted);">DA (10%)</div><div id="previewDa" style="font-weight:700; color:var(--accent-success);">—</div></div>
                            <div><div style="font-size:0.72rem; color:var(--text-muted);">Bonus (5%)</div><div id="previewBonus" style="font-weight:700; color:var(--accent-success);">—</div></div>
                            <div><div style="font-size:0.72rem; color:var(--text-muted);">Deductions (5%)</div><div id="previewDeduct" style="font-weight:700; color:var(--accent-danger);">—</div></div>
                            <div><div style="font-size:0.72rem; color:var(--text-muted);">Net Salary</div><div id="previewNet" style="font-weight:800; font-size:1rem; color:var(--accent-primary);">—</div></div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">💾 Save Changes</button>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function fmt(n) { return '₹' + n.toLocaleString('en-IN', {minimumFractionDigits:2, maximumFractionDigits:2}); }

    function updatePreview(basic) {
        if (isNaN(basic) || basic <= 0) return;
        const hra = basic*0.20, da = basic*0.10, bonus = basic*0.05, deduct = basic*0.05;
        const net = basic + hra + da + bonus - deduct;
        document.getElementById('previewBasic').textContent  = fmt(basic);
        document.getElementById('previewHra').textContent    = fmt(hra);
        document.getElementById('previewDa').textContent     = fmt(da);
        document.getElementById('previewBonus').textContent  = fmt(bonus);
        document.getElementById('previewDeduct').textContent = fmt(deduct);
        document.getElementById('previewNet').textContent    = fmt(net);
    }

    const salaryInput = document.getElementById('basicSalary');
    salaryInput.addEventListener('input', function () { updatePreview(parseFloat(this.value)); });
    // Show on page load
    updatePreview(parseFloat(salaryInput.value));

    document.getElementById('editEmpForm').addEventListener('submit', function (e) {
        const name   = document.getElementById('name').value.trim();
        const salary = parseFloat(document.getElementById('basicSalary').value);
        if (!name || name.length < 2) { alert('Please enter a valid name.'); e.preventDefault(); return; }
        if (isNaN(salary) || salary <= 0) { alert('Please enter a valid salary.'); e.preventDefault(); }
    });
</script>
</body>
</html>
