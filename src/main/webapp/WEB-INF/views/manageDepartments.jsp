<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Manage Departments — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">Manage Departments</div>
        </header>
        <div class="page-body">
            <div class="card">
                <div class="card-header"><div class="card-title">➕ Add Department</div></div>
                <div class="card-body" style="padding: 20px;">
                    <form action="${pageContext.request.contextPath}/departments?action=add" method="POST" style="display: flex; gap: 10px;">
                        <input type="text" name="deptName" placeholder="Department Name" class="form-control" required style="flex: 1;"/>
                        <input type="text" name="deptHead" placeholder="Department Head" class="form-control" style="flex: 1;"/>
                        <button type="submit" class="btn btn-primary">Add</button>
                    </form>
                </div>
            </div>

            <div class="card" style="margin-top: 20px;">
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Head</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="d" items="${departments}">
                                <tr>
                                    <td>#${d.deptId}</td>
                                    <td><strong><c:out value="${d.deptName}"/></strong></td>
                                    <td><c:out value="${d.deptHead}"/></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/departments?action=delete" method="POST" style="display:inline;">
                                            <input type="hidden" name="deptId" value="${d.deptId}"/>
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
