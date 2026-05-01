<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>My Attendance — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/empNavbar.jsp"/>

    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">📅 My Attendance Record</div>
        </header>
        <div class="page-body">
            <!-- Filter Section -->
            <div class="card" style="margin-bottom: 20px;">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/attendance" method="GET" class="filter-form" style="display: flex; gap: 15px; align-items: flex-end;">
                        <div class="form-group" style="margin: 0; flex: 1;">
                            <label class="form-label">Month</label>
                            <select name="month" class="form-control">
                                <option value="1" ${selectedMonth == 1 ? 'selected' : ''}>January</option>
                                <option value="2" ${selectedMonth == 2 ? 'selected' : ''}>February</option>
                                <option value="3" ${selectedMonth == 3 ? 'selected' : ''}>March</option>
                                <option value="4" ${selectedMonth == 4 ? 'selected' : ''}>April</option>
                                <option value="5" ${selectedMonth == 5 ? 'selected' : ''}>May</option>
                                <option value="6" ${selectedMonth == 6 ? 'selected' : ''}>June</option>
                                <option value="7" ${selectedMonth == 7 ? 'selected' : ''}>July</option>
                                <option value="8" ${selectedMonth == 8 ? 'selected' : ''}>August</option>
                                <option value="9" ${selectedMonth == 9 ? 'selected' : ''}>September</option>
                                <option value="10" ${selectedMonth == 10 ? 'selected' : ''}>October</option>
                                <option value="11" ${selectedMonth == 11 ? 'selected' : ''}>November</option>
                                <option value="12" ${selectedMonth == 12 ? 'selected' : ''}>December</option>
                            </select>
                        </div>
                        <div class="form-group" style="margin: 0; flex: 1;">
                            <label class="form-label">Year</label>
                            <input type="number" name="year" class="form-control" value="${selectedYear}" min="2020" max="2100"/>
                        </div>
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </form>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>Overtime Hours</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="att" items="${attendance}">
                                <tr>
                                    <td><fmt:formatDate value="${att.attDate}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${att.status == 'PRESENT'}">
                                                <span class="badge badge-success">Present</span>
                                            </c:when>
                                            <c:when test="${att.status == 'ABSENT'}">
                                                <span class="badge badge-danger">Absent</span>
                                            </c:when>
                                            <c:when test="${att.status == 'HALF_DAY'}">
                                                <span class="badge badge-warning">Half Day</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">${att.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${att.checkIn != null ? att.checkIn : '--:--'}</td>
                                    <td>${att.checkOut != null ? att.checkOut : '--:--'}</td>
                                    <td>${att.overtimeHours}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty attendance}">
                                <tr>
                                    <td colspan="5" class="text-center">No attendance records found for this month.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
