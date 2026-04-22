<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Mark Attendance — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">Mark Daily Attendance</div>
        </header>
        <div class="page-body">
            <div class="card">
                <div class="card-body" style="padding: 20px;">
                    <form action="${pageContext.request.contextPath}/attendance" method="POST">
                        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 15px; align-items: end;">
                            <div>
                                <label class="form-label">Date</label>
                                <input type="date" name="date" class="form-control" required value="<%= java.time.LocalDate.now() %>"/>
                            </div>
                            <div>
                                <label class="form-label">Employee</label>
                                <select name="empId" class="form-control" required>
                                    <c:forEach var="e" items="${employees}">
                                        <option value="${e.empId}">${e.name} (${e.designation})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="form-label">Status</label>
                                <select name="status" class="form-control">
                                    <option value="PRESENT">Present</option>
                                    <option value="ABSENT">Absent</option>
                                    <option value="HALF_DAY">Half Day</option>
                                    <option value="HOLIDAY">Holiday</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Mark Status</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <c:if test="${not empty param.success}">
                <div class="alert alert-success" style="margin-top: 20px;">Attendance marked successfully!</div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
