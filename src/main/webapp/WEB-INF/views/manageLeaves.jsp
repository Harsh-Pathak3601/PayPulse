<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Manage Leaves — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">Leave Approval Panel</div>
        </header>
        <div class="page-body">
            <div class="card">
                <div class="card-header"><div class="card-title">⏳ Pending Requests</div></div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Employee</th>
                                <th>Type</th>
                                <th>Dates</th>
                                <th>Days</th>
                                <th>Reason</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${pendingLeaves}">
                                <tr>
                                    <td><strong><c:out value="${l.empName}"/></strong></td>
                                    <td><span class="badge badge-blue">${l.leaveType}</span></td>
                                    <td><fmt:formatDate value="${l.startDate}" pattern="dd MMM"/> - <fmt:formatDate value="${l.endDate}" pattern="dd MMM"/></td>
                                    <td>${l.totalDays} Days</td>
                                    <td><c:out value="${l.reason}"/></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/leaves" method="POST" style="display: flex; gap: 5px;">
                                            <input type="hidden" name="leaveId" value="${l.leaveId}"/>
                                            <input type="text" name="remarks" placeholder="Remarks" class="form-control" style="width: 100px; padding: 5px;"/>
                                            <button type="submit" name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
                                            <button type="submit" name="action" value="reject" class="btn btn-danger btn-sm">Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty pendingLeaves}">
                                <tr><td colspan="6" style="text-align:center; padding: 20px;">No pending leave requests.</td></tr>
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
