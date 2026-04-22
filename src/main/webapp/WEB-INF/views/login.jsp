<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="Login to PayPulse — Enterprise Payroll Management System" />
        <title>Login — PayPulse</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
        <style>
            /* ── Premium Split-Screen Login ── */
            body {
                overflow: hidden;
            }

            .login-page {
                display: grid;
                grid-template-columns: 1fr 1fr;
                min-height: 100vh;
                background: var(--bg-primary);
            }

            /* LEFT PANEL — Brand */
            .login-left {
                position: relative;
                background: linear-gradient(145deg, #0d1b3e 0%, #0a0f1e 100%);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 60px;
                overflow: hidden;
            }

            .login-left::before {
                content: '';
                position: absolute;
                width: 600px;
                height: 600px;
                background: radial-gradient(circle, rgba(79, 142, 247, 0.18) 0%, transparent 70%);
                top: -100px;
                left: -100px;
                border-radius: 50%;
            }

            .login-left::after {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(188, 140, 255, 0.14) 0%, transparent 70%);
                bottom: -80px;
                right: -80px;
                border-radius: 50%;
            }

            .login-left-content {
                position: relative;
                z-index: 1;
                text-align: center;
            }

            .brand-logo-wrap {
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 28px;
            }

            @keyframes pulse-glow {

                0%,
                100% {
                    box-shadow: 0 8px 40px rgba(79, 142, 247, 0.5), 0 0 0 1px rgba(79, 142, 247, 0.3);
                }

                50% {
                    box-shadow: 0 8px 60px rgba(79, 142, 247, 0.7), 0 0 0 1px rgba(79, 142, 247, 0.5);
                }
            }

            .brand-name {
                font-size: 2.8rem;
                font-weight: 900;
                background: linear-gradient(135deg, #e6edf3 0%, #58a6ff 50%, #bc8cff 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                letter-spacing: -0.02em;
                line-height: 1;
                margin-bottom: 12px;
            }

            .brand-tagline {
                font-size: 1rem;
                color: rgba(255, 255, 255, 0.45);
                font-weight: 400;
                letter-spacing: 0.05em;
                margin-bottom: 48px;
            }

            .feature-list {
                list-style: none;
                display: flex;
                flex-direction: column;
                gap: 14px;
                text-align: left;
            }

            .feature-list li {
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 0.875rem;
                color: rgba(255, 255, 255, 0.6);
            }

            .feature-list li .fi {
                width: 32px;
                height: 32px;
                background: rgba(79, 142, 247, 0.12);
                border: 1px solid rgba(79, 142, 247, 0.2);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
                flex-shrink: 0;
            }

            /* RIGHT PANEL — Form */
            .login-right {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 60px 48px;
                background: var(--bg-primary);
                position: relative;
            }

            .login-right::before {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                background: radial-gradient(circle, rgba(188, 140, 255, 0.07) 0%, transparent 70%);
                bottom: 0;
                right: 0;
                border-radius: 50%;
            }

            .login-form-wrap {
                width: 100%;
                max-width: 420px;
                position: relative;
                z-index: 1;
            }

            .login-heading {
                margin-bottom: 8px;
            }

            .login-heading h2 {
                font-size: 1.8rem;
                font-weight: 800;
                color: var(--text-primary);
            }

            .login-heading p {
                font-size: 0.9rem;
                color: var(--text-muted);
                margin-top: 6px;
                margin-bottom: 32px;
            }

            .login-form-card {
                background: var(--bg-card);
                border: 1px solid var(--border-color);
                border-radius: 20px;
                padding: 36px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            }

            .input-icon-wrap {
                position: relative;
            }

            .input-icon-wrap .icon {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-muted);
                font-size: 1rem;
                pointer-events: none;
            }

            .input-icon-wrap input {
                padding-left: 40px;
            }

            .login-submit {
                width: 100%;
                justify-content: center;
                padding: 14px;
                font-size: 1rem;
                border-radius: 12px;
                margin-top: 24px;
                background: linear-gradient(135deg, var(--accent-primary) 0%, #6a7cf7 100%);
                border: none;
                letter-spacing: 0.02em;
                box-shadow: 0 4px 24px rgba(79, 142, 247, 0.4);
                transition: all 0.3s ease;
            }

            .login-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 32px rgba(79, 142, 247, 0.55);
            }

            .login-divider {
                display: flex;
                align-items: center;
                gap: 12px;
                margin: 20px 0;
                color: var(--text-muted);
                font-size: 0.78rem;
            }

            .login-divider::before,
            .login-divider::after {
                content: '';
                flex: 1;
                border-top: 1px solid var(--border-color);
            }

            .demo-creds {
                background: rgba(79, 142, 247, 0.06);
                border: 1px dashed rgba(79, 142, 247, 0.25);
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 0.8rem;
                color: var(--text-muted);
                text-align: center;
            }

            .demo-creds strong {
                color: var(--accent-info);
            }

            .emp-portal-link {
                text-align: center;
                margin-top: 20px;
                font-size: 0.82rem;
                color: var(--text-muted);
            }

            .emp-portal-link a {
                color: var(--accent-primary);
                font-weight: 600;
            }

            .emp-portal-link a:hover {
                text-decoration: underline;
            }

            @media (max-width: 900px) {
                .login-page {
                    grid-template-columns: 1fr;
                }

                .login-left {
                    display: none;
                }
            }
        </style>
    </head>

    <body>
        <div class="login-page">

            <!-- ── LEFT: Brand Panel ─────────────────────── -->
            <div class="login-left">
                <div class="login-left-content">
                    <div class="brand-logo-wrap">
                        <img src="${pageContext.request.contextPath}/public/images/logo.png"
                             alt="PayPulse"
                             style="height: 60px; width: auto; filter: drop-shadow(0 0 20px rgba(0,201,167,0.5));"/>
                    </div>
                    <div class="brand-name">PayPulse</div>
                    <div class="brand-tagline">ENTERPRISE PAYROLL MANAGEMENT</div>


                    <ul class="feature-list">
                        <li>
                            <span class="fi">⚖️</span>
                            Statutory Tax Compliance (PF, ESI, TDS)
                        </li>
                        <li>
                            <span class="fi">📅</span>
                            Attendance & Loss of Pay Tracking
                        </li>
                        <li>
                            <span class="fi">🍃</span>
                            Leave Management & Approval Workflow
                        </li>
                        <li>
                            <span class="fi">📧</span>
                            Automated Payslip Email Notifications
                        </li>
                        <li>
                            <span class="fi">📈</span>
                            Analytics Dashboard with Chart.js
                        </li>
                    </ul>
                </div>
            </div>

            <!-- ── RIGHT: Login Form ─────────────────────── -->
            <div class="login-right">
                <div class="login-form-wrap">
                    <div class="login-heading">
                        <h2>Welcome back 👋</h2>
                        <p>Sign in to access the admin dashboard</p>
                    </div>

                    <div class="login-form-card">
                        <% if (request.getAttribute("error") !=null) { %>
                            <div class="alert alert-error" style="margin-bottom: 20px;">
                                <span class="alert-icon">⚠️</span>
                                <%= request.getAttribute("error") %>
                            </div>
                            <% } %>

                                <form method="post" action="${pageContext.request.contextPath}/login" novalidate>

                                    <div class="form-group" style="margin-bottom: 18px;">
                                        <label for="username">Username</label>
                                        <div class="input-icon-wrap">
                                            <span class="icon">👤</span>
                                            <input type="text" id="username" name="username"
                                                placeholder="Enter your username" autocomplete="username" required
                                                value="<% if(request.getAttribute(" error") !=null){
                                                out.print(request.getParameter("username") !=null ?
                                                request.getParameter("username") : "" ); } %>"
                                            />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <div class="input-icon-wrap">
                                            <span class="icon">🔑</span>
                                            <input type="password" id="password" name="password"
                                                placeholder="Enter your password" autocomplete="current-password"
                                                required />
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary login-submit">
                                        Sign In to PayPulse →
                                    </button>
                                </form>

                                <div class="login-divider">or use demo credentials</div>

                                <div class="demo-creds">
                                    Username: <strong>admin</strong> &nbsp;|&nbsp; Password: <strong>admin123</strong>
                                </div>
                    </div>

                    <div class="emp-portal-link">
                        Employee? <a href="${pageContext.request.contextPath}/emp-login">Login to the Employee Portal
                            →</a>
                    </div>
                </div>
            </div>

        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const user = document.getElementById('username');
                const pass = document.getElementById('password');
                if (!user.value) user.focus();
                else pass.focus();
            });
        </script>
    </body>

    </html>