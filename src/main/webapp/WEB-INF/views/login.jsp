<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Login to PayPulse Employee Payroll Management System"/>
    <title>Login — PayPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="login-page">
    <div class="login-container">

        <!-- Brand -->
        <div class="login-brand">
            <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="PayPulse Logo" style="height: 80px; width: auto; margin-bottom: 20px;">
            <h1>PayPulse</h1>
            <p>Management System</p>
        </div>

        <!-- Login Card -->
        <div class="login-card">
            <h2 style="font-size:1.2rem; margin-bottom:6px; color:var(--text-primary);">
                Welcome back 👋
            </h2>
            <p style="font-size:0.85rem; color:var(--text-muted); margin-bottom:24px;">
                Sign in to access the admin dashboard
            </p>

            <!-- Error message -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <span class="alert-icon">⚠️</span>
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/login" novalidate>

                <div class="form-group">
                    <label for="username">Username <span class="required">*</span></label>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Enter your username"
                        autocomplete="username"
                        required
                        value="<% if(request.getAttribute("error") != null){ out.print(request.getParameter("username") != null ? request.getParameter("username") : ""); } %>"
                    />
                </div>

                <div class="form-group" style="margin-top:16px;">
                    <label for="password">Password <span class="required">*</span></label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required
                    />
                </div>

                <button type="submit" class="btn btn-primary login-btn" style="margin-top:24px;">
                    🔐 Sign In
                </button>
            </form>

            <div class="login-hint">
                Demo credentials: <strong>admin</strong> / <strong>admin123</strong>
            </div>
        </div>

    </div>
</div>

<script>
    // Autofocus first empty field
    document.addEventListener('DOMContentLoaded', function () {
        const user = document.getElementById('username');
        const pass = document.getElementById('password');
        if (!user.value) user.focus();
        else pass.focus();
    });
</script>
</body>
</html>
