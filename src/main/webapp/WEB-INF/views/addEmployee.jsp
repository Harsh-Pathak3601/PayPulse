<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activePage" value="addEmployee" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Add a new employee — PayPulse"/>
    <title>Add Employee — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div>
                <div class="top-bar-title">➕ Add New Employee</div>
                <div class="top-bar-sub">Fill in the details to register a new team member</div>
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
                    <div class="card-title">👤 Employee Details</div>
                </div>

                <!-- Validation Error -->
                <c:if test="${not empty error}">
                    <div class="alert alert-error mb-16">
                        <span class="alert-icon">⚠️</span> ${error}
                    </div>
                </c:if>

                <form
                    method="post"
                    action="${pageContext.request.contextPath}/employees?action=add"
                    id="addEmpForm"
                    novalidate
                >
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="name">Full Name <span class="required">*</span></label>
                            <input
                                type="text"
                                id="name"
                                name="name"
                                placeholder="e.g. Ravi Kumar"
                                required
                                minlength="2"
                                maxlength="100"
                                value="${not empty param.name ? param.name : ''}"
                            />
                            <span class="input-hint">Minimum 2 characters</span>
                        </div>

                        <div class="form-group">
                            <label for="department">Department <span class="required">*</span></label>
                            <input
                                type="text"
                                id="department"
                                name="department"
                                placeholder="e.g. Engineering"
                                required
                                maxlength="50"
                                list="deptSuggestions"
                                value="${not empty param.department ? param.department : ''}"
                            />
                            <datalist id="deptSuggestions">
                                <option value="Engineering"/>
                                <option value="Finance"/>
                                <option value="Human Resources"/>
                                <option value="Marketing"/>
                                <option value="Operations"/>
                                <option value="Product"/>
                                <option value="Sales"/>
                                <option value="IT"/>
                            </datalist>
                        </div>

                        <div class="form-group">
                            <label for="designation">Designation <span class="required">*</span></label>
                            <input
                                type="text"
                                id="designation"
                                name="designation"
                                placeholder="e.g. Senior Developer"
                                required
                                maxlength="80"
                                value="${not empty param.designation ? param.designation : ''}"
                            />
                        </div>

                        <div class="form-group">
                            <label for="basicSalary">Basic Salary (₹) <span class="required">*</span></label>
                            <input
                                type="number"
                                id="basicSalary"
                                name="basicSalary"
                                placeholder="e.g. 50000"
                                required
                                min="1"
                                step="0.01"
                                value="${not empty param.basicSalary ? param.basicSalary : ''}"
                            />
                            <span class="input-hint">Net salary will be auto-calculated (HRA 20% + DA 10% + Bonus 5% - Deduction 5%)</span>
                        </div>
                    </div>

                    <!-- Salary Preview -->
                    <div id="salaryPreview" style="display:none; margin-top:20px; padding:16px; background:var(--bg-secondary); border:1px solid var(--border-color); border-radius:var(--radius-md);">
                        <div style="font-size:0.8rem; font-weight:600; color:var(--text-muted); margin-bottom:12px; text-transform:uppercase; letter-spacing:0.06em;">
                            💡 Salary Breakdown Preview
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
                        <button type="submit" class="btn btn-primary">✅ Add Employee</button>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Real-time salary preview
    const salaryInput = document.getElementById('basicSalary');
    const preview     = document.getElementById('salaryPreview');

    function fmt(n) { return '₹' + n.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2}); }

    salaryInput.addEventListener('input', function () {
        const basic = parseFloat(this.value);
        if (isNaN(basic) || basic <= 0) { preview.style.display = 'none'; return; }
        const hra  = basic * 0.20, da = basic * 0.10, bonus = basic * 0.05, deduct = basic * 0.05;
        const net  = basic + hra + da + bonus - deduct;
        document.getElementById('previewBasic').textContent  = fmt(basic);
        document.getElementById('previewHra').textContent    = fmt(hra);
        document.getElementById('previewDa').textContent     = fmt(da);
        document.getElementById('previewBonus').textContent  = fmt(bonus);
        document.getElementById('previewDeduct').textContent = fmt(deduct);
        document.getElementById('previewNet').textContent    = fmt(net);
        preview.style.display = 'block';
    });

    // Front-end validation
    document.getElementById('addEmpForm').addEventListener('submit', function (e) {
        const name   = document.getElementById('name').value.trim();
        const dept   = document.getElementById('department').value.trim();
        const desig  = document.getElementById('designation').value.trim();
        const salary = parseFloat(document.getElementById('basicSalary').value);
        if (!name || name.length < 2) { alert('Please enter a valid name (min 2 characters).'); e.preventDefault(); return; }
        if (!dept) { alert('Department is required.'); e.preventDefault(); return; }
        if (!desig) { alert('Designation is required.'); e.preventDefault(); return; }
        if (isNaN(salary) || salary <= 0) { alert('Please enter a valid positive salary.'); e.preventDefault(); }
    });
</script>
</body>
</html>
