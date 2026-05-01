<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Apply Leave — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/empNavbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">Apply for Leave</div>
        </header>
        <div class="page-body">
            <div class="card" style="max-width: 600px; margin: 0 auto;">
                <div class="card-body" style="padding: 30px;">
                    <form action="${pageContext.request.contextPath}/leaves?action=apply" method="POST">
                        <div style="margin-bottom: 20px;">
                            <label class="form-label">Leave Type</label>
                            <select name="type" class="form-control" required>
                                <option value="SICK">Sick Leave</option>
                                <option value="ANNUAL">Annual Leave</option>
                                <option value="CASUAL">Casual Leave</option>
                            </select>
                        </div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                            <div>
                                <label class="form-label">Start Date</label>
                                <input type="date" name="startDate" class="form-control" required/>
                            </div>
                            <div>
                                <label class="form-label">End Date</label>
                                <input type="date" name="endDate" class="form-control" required/>
                            </div>
                        </div>
                        <div style="margin-bottom: 20px;">
                            <label class="form-label">Total Days</label>
                            <input type="number" name="totalDays" class="form-control" required min="1"/>
                        </div>
                        <div style="margin-bottom: 20px;">
                            <label class="form-label">Reason</label>
                            <textarea name="reason" class="form-control" rows="4" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Submit Request</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
