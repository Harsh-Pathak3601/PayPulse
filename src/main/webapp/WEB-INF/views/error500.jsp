<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>500 — Server Error | PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div style="display:flex; align-items:center; justify-content:center; min-height:100vh; text-align:center; padding:24px;">
    <div>
        <div style="font-size:6rem; margin-bottom:16px;">💥</div>
        <h1 style="font-size:4rem; font-weight:900; color:var(--accent-danger); margin-bottom:8px;">500</h1>
        <h2 style="margin-bottom:12px; color:var(--text-primary);">Internal Server Error</h2>
        <p style="color:var(--text-muted); max-width:400px; margin:0 auto 28px;">
            Something went wrong on our end. The error has been logged. Please try again later.
        </p>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
            🏠 Go to Dashboard
        </a>
    </div>
</div>
</body>
</html>
