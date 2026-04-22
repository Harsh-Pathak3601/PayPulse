<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Reports — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp"/>
    <div class="main-content">
        <header class="top-bar">
            <div class="top-bar-title">📊 Financial Reports</div>
        </header>
        <div class="page-body">
            <div class="row mb-4">
    <div class="col-12">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="font-weight:700; color:var(--text-primary); margin:0;">
                <i class="fas fa-chart-pie me-2" style="color:var(--accent-primary);"></i> Financial Reports
            </h2>
        </div>
        
        <div class="card p-4">
            <h5 class="mb-4">Department-wise Expenditure</h5>
            <div id="chartContainer" style="height: 400px; width: 100%; display: flex; justify-content: center; align-items: center; background: rgba(0,0,0,0.02); border-radius: 12px;">
                <canvas id="deptChart"></canvas>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetch('${pageContext.request.contextPath}/reports?action=json')
            .then(response => response.json())
            .then(data => {
                const ctx = document.getElementById('deptChart').getContext('2d');
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: Object.keys(data),
                        datasets: [{
                            data: Object.values(data),
                            backgroundColor: [
                                '#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'
                            ],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'right'
                            }
                        }
                    }
                });
            })
            .catch(error => {
                console.error("Error fetching report data:", error);
                document.getElementById('chartContainer').innerHTML = "<p class='text-muted'>No data available to display chart.</p>";
            });
    });
</script>
        </div>
    </div>
</div>
</body>
</html>
