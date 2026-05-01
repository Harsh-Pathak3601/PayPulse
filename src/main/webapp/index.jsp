<%-- index.jsp: Landing page with login options --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session != null && session.getAttribute("loggedIn") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    } else if (session != null && session.getAttribute("empLoggedIn") != null) {
        response.sendRedirect(request.getContextPath() + "/emp-portal");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome — PayPulse</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            /* Override global style.css background */
            background: none !important;
            background-image: url('<%= request.getContextPath() %>/public/bg.webp') !important;
            background-size: cover !important;
            background-position: center center !important;
            background-repeat: no-repeat !important;
            background-attachment: scroll !important; /* Fixed causes lag on mobile */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Gradient overlay sits naturally above body bg image */
        /* Dark gradient overlay — Restore visibility of bg image */
        .page-overlay {
            position: fixed;
            inset: 0;
            background: linear-gradient(135deg,
                rgba(0, 8, 20, 0.75) 0%,
                rgba(0, 8, 20, 0.55) 50%,
                rgba(0, 8, 20, 0.65) 100%);
            z-index: 0;
        }

        .hero-container {
            position: relative;
            z-index: 1;
            width: 100%;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 24px;
            gap: 0;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 52px;
        }

        .brand-header img {
            height: 62px;
            margin-bottom: 14px;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.5));
        }

        .brand-header h1 {
            font-size: 2.6rem;
            font-weight: 800;
            color: #FFFFFF;
            letter-spacing: -0.5px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.6);
        }

        .brand-header p {
            font-size: 1rem;
            color: rgba(255,255,255,0.7);
            margin-top: 8px;
            font-weight: 400;
        }

        .portal-cards {
            display: flex;
            gap: 28px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .glass-card {
            width: 270px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            padding: 44px 28px 36px;
            text-align: center;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            background: rgba(255, 255, 255, 0.18);
            border-color: rgba(255, 255, 255, 0.4);
            transform: translateY(-8px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }

        .card-icon {
            font-size: 3rem;
            color: #FFFFFF;
            margin-bottom: 20px;
            text-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #FFFFFF;
            margin-bottom: 10px;
        }

        .card-desc {
            font-size: 0.85rem;
            color: rgba(255,255,255,0.7);
            line-height: 1.6;
            margin-bottom: 28px;
        }

        .card-btn {
            display: block;
            width: 100%;
            padding: 12px 24px;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 700;
            transition: all 0.25s ease;
        }

        .card-btn-admin {
            background: #FFFFFF;
            color: #161D29;
        }

        .glass-card:hover .card-btn-admin {
            background: #673AB7;
            color: #FFFFFF;
        }

        .card-btn-emp {
            background: #673AB7;
            color: #FFFFFF;
        }

        .glass-card:hover .card-btn-emp {
            background: #2E7D32;
            color: #FFFFFF;
        }

        @media (max-width: 640px) {
            .portal-cards { flex-direction: column; align-items: center; }
            .glass-card { width: 100%; max-width: 320px; }
            .brand-header h1 { font-size: 2rem; }
        }
    </style>
</head>
<body>
    <div class="page-overlay"></div>

    <div class="hero-container">
        <!-- Brand -->
        <div class="brand-header">
            <img src="<%= request.getContextPath() %>/public/images/logo.png" alt="PayPulse Logo" onerror="this.style.display='none'"/>
            <h1>PayPulse</h1>
            <p>Select your portal to continue</p>
        </div>

        <!-- Portal Cards -->
        <div class="portal-cards">
            <a href="<%= request.getContextPath() %>/login" class="glass-card">
                <div class="card-icon"><i class="fa-solid fa-user-shield"></i></div>
                <div class="card-title">Admin Portal</div>
                <div class="card-desc">Manage employees, approve payroll, and oversee operations.</div>
                <div class="card-btn card-btn-admin">Admin Login</div>
            </a>

            <a href="<%= request.getContextPath() %>/emp-login" class="glass-card">
                <div class="card-icon"><i class="fa-solid fa-users"></i></div>
                <div class="card-title">Employee Portal</div>
                <div class="card-desc">View payslips, track attendance, and check leave status.</div>
                <div class="card-btn card-btn-emp">Employee Login</div>
            </a>
        </div>
    </div>
</body>
</html>
