<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="generateSalary" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Generate Employee Salary — PayPulse"/>
    <title>Generate Salary — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div>
                <div class="top-bar-title">💰 Generate Salary</div>
                <div class="top-bar-sub">Select an employee to compute and save their salary slip</div>
            </div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline btn-sm">
                    📋 View History
                </a>
            </div>
        </header>

        <div class="page-body">
            <div class="card" style="max-width:600px;">
                <div class="card-header">
                    <div class="card-title">📋 Payroll Generation</div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error mb-16">
                        <span class="alert-icon">⚠️</span> ${error}
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/payroll?action=generate" id="genForm">
                    <div class="form-group">
                        <label for="empId">Select Employee <span class="required">*</span></label>
                        <select id="empId" name="empId" required onchange="updatePreview()">
                            <option value="">— Choose an employee —</option>
                            <c:forEach var="emp" items="${employees}">
                                <option
                                    value="${emp.empId}"
                                    data-basic="${emp.basicSalary}"
                                    data-dept="${emp.department}"
                                    data-desig="${emp.designation}"
                                >
                                    EMP-${emp.empId} — <c:out value="${emp.name}"/> (<c:out value="${emp.department}"/>)
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Employee Detail & Salary Breakdown Preview -->
                    <div id="empPreview" style="display:none; margin-top:20px;">
                        <div style="padding:16px; background:var(--bg-secondary); border:1px solid var(--border-color); border-radius:var(--radius-md); margin-bottom:16px;">
                            <div style="font-size:0.72rem; font-weight:600; color:var(--text-muted); text-transform:uppercase; letter-spacing:0.06em; margin-bottom:10px;">
                                Employee Info
                            </div>
                            <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px;">
                                <div><div style="font-size:0.72rem; color:var(--text-muted);">Department</div><div id="prevDept" style="font-weight:600; color:var(--text-primary); margin-top:2px;">—</div></div>
                                <div><div style="font-size:0.72rem; color:var(--text-muted);">Designation</div><div id="prevDesig" style="font-weight:600; color:var(--text-primary); margin-top:2px;">—</div></div>
                            </div>
                        </div>

                        <div style="padding:16px; background:var(--bg-secondary); border:1px solid var(--border-color); border-radius:var(--radius-md);">
                            <div style="font-size:0.72rem; font-weight:600; color:var(--text-muted); text-transform:uppercase; letter-spacing:0.06em; margin-bottom:12px;">
                                💡 Projected Salary Breakdown
                            </div>
                            <div style="display:flex; flex-direction:column; gap:8px;">
                                <div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--border-color);">
                                    <span style="color:var(--text-secondary);">Basic Salary</span>
                                    <span id="pb" style="font-weight:600;"></span>
                                </div>
                                <div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--border-color);">
                                    <span style="color:var(--accent-success);">+ HRA (20%)</span>
                                    <span id="ph" style="font-weight:600; color:var(--accent-success);"></span>
                                </div>
                                <div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--border-color);">
                                    <span style="color:var(--accent-success);">+ DA (10%)</span>
                                    <span id="pd" style="font-weight:600; color:var(--accent-success);"></span>
                                </div>
                                <div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--border-color);">
                                    <span style="color:var(--accent-success);">+ Bonus (5%)</span>
                                    <span id="pbo" style="font-weight:600; color:var(--accent-success);"></span>
                                </div>
                                <div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--border-color);">
                                    <span style="color:var(--accent-danger);">− Deductions (5%)</span>
                                    <span id="pde" style="font-weight:600; color:var(--accent-danger);"></span>
                                </div>
                                <div style="display:flex; justify-content:space-between; padding:10px 14px; background:linear-gradient(135deg, rgba(79,142,247,0.12), rgba(188,140,255,0.08)); border:1px solid rgba(79,142,247,0.3); border-radius:var(--radius-md); margin-top:4px;">
                                    <span style="font-weight:700; color:var(--text-primary);">Net Salary</span>
                                    <span id="pn" style="font-weight:800; font-size:1.2rem; color:var(--accent-primary);"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success" id="genBtn" disabled>
                            ✅ Generate &amp; Save Salary Slip
                        </button>
                        <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function fmt(n) { return '₹' + n.toLocaleString('en-IN', {minimumFractionDigits:2,maximumFractionDigits:2}); }

    function updatePreview() {
        const sel = document.getElementById('empId');
        const opt = sel.options[sel.selectedIndex];
        const preview = document.getElementById('empPreview');
        const btn = document.getElementById('genBtn');

        if (!sel.value) {
            preview.style.display = 'none';
            btn.disabled = true;
            return;
        }

        const basic = parseFloat(opt.dataset.basic);
        document.getElementById('prevDept').textContent  = opt.dataset.dept;
        document.getElementById('prevDesig').textContent = opt.dataset.desig;

        const hra = basic*0.20, da = basic*0.10, bonus = basic*0.05, deduct = basic*0.05;
        const net = basic + hra + da + bonus - deduct;

        document.getElementById('pb').textContent  = fmt(basic);
        document.getElementById('ph').textContent  = fmt(hra);
        document.getElementById('pd').textContent  = fmt(da);
        document.getElementById('pbo').textContent = fmt(bonus);
        document.getElementById('pde').textContent = fmt(deduct);
        document.getElementById('pn').textContent  = fmt(net);

        preview.style.display = 'block';
        btn.disabled = false;
    }
</script>
</body>
</html>
