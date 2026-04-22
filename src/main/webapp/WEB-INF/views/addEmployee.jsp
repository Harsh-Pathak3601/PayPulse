<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Add Employee — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">➕ Add New Employee</div>
        </header>
        <div class="page-body">
            <div class="card">
                <div class="card-body" style="padding: 30px;">
                    <form action="${pageContext.request.contextPath}/employees?action=add" method="POST">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                            <div>
                                <label class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" required/>
                            </div>
                            <div>
                                <label class="form-label">Email Address (for ESS & Login)</label>
                                <input type="email" name="email" class="form-control" required/>
                            </div>
                            <div>
                                <label class="form-label">Phone Number</label>
                                <input type="text" name="phone" class="form-control"/>
                            </div>
                            <div>
                                <label class="form-label">Department</label>
                                <select name="deptId" class="form-control" required>
                                    <c:forEach var="d" items="${departments}">
                                        <option value="${d.deptId}">${d.deptName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="form-label">Designation</label>
                                <select name="designation" class="form-control" required>
                                    <option value="">Select Designation</option>
                                    <c:forEach var="des" items="${designations}">
                                        <option value="${des.desigName}">${des.desigName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="form-label">Basic Monthly Salary (₹)</label>
                                <input type="number" name="basicSalary" class="form-control" required/>
                            </div>
                            <div>
                                <label class="form-label">Joining Date</label>
                                <input type="date" name="joinDate" class="form-control" required/>
                            </div>
                            <div>
                                <label class="form-label">Employee Type</label>
                                <select name="employeeType" class="form-control">
                                    <option value="FULL_TIME">Full Time</option>
                                    <option value="PART_TIME">Part Time</option>
                                    <option value="CONTRACT">Contract</option>
                                </select>
                            </div>
                            <div>
                                <label class="form-label">ESS Portal Password</label>
                                <input type="password" name="password" class="form-control" required/>
                            </div>
                        </div>
                        <div style="margin-top: 30px; display: flex; gap: 10px;">
                            <button type="submit" class="btn btn-primary">Create Employee Profile</button>
                            <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
