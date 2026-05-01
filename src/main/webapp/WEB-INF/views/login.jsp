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
                font-family: 'Inter', sans-serif;
                background: #070d1a;
                color: #e8f0fe;
                -webkit-font-smoothing: antialiased;
            }

            .login-page {
                display: grid;
                grid-template-columns: 1fr 1fr;
                min-height: 100vh;
                background: #070d1a;
            }

            /* LEFT PANEL — Brand */
            .login-left {
                position: relative;
                background: #070d1a;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 60px;
                overflow: hidden;
            }

            .login-left-content {
                position: relative;
                z-index: 1;
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* RIGHT PANEL — Form */
            .login-right {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 60px 48px;
                background: #0c1525;
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
                color: #fff;
            }

            .login-heading p {
                font-size: 0.9rem;
                color: rgba(255,255,255,0.4);
                margin-top: 6px;
                margin-bottom: 32px;
            }

            .login-form-card {
                background: #111827;
                border: 1px solid rgba(255,255,255,0.08);
                border-radius: 20px;
                padding: 36px;
                box-shadow: 0 24px 64px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.05);
            }

            .form-group label {
                display: block;
                font-size: 0.75rem; font-weight: 600;
                color: rgba(255,255,255,0.45);
                letter-spacing: 0.08em; text-transform: uppercase;
                margin-bottom: 8px;
            }

            .input-icon-wrap {
                position: relative;
            }

            .input-icon-wrap .icon {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: rgba(255,255,255,0.45);
                font-size: 1rem;
                pointer-events: none;
            }

            .input-icon-wrap input {
                width: 100%;
                background: rgba(255,255,255,0.04);
                border: 1px solid rgba(255,255,255,0.1);
                border-radius: 12px;
                color: #fff;
                font-family: 'Inter', sans-serif;
                font-size: 0.9rem;
                padding: 13px 14px 13px 42px;
                outline: none;
                transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
            }
            .input-icon-wrap input::placeholder { color: rgba(255,255,255,0.22); }
            .input-icon-wrap input:focus {
                border-color: rgba(79, 142, 247, 0.6);
                box-shadow: 0 0 0 3px rgba(79, 142, 247, 0.1);
                background: rgba(255,255,255,0.07);
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
                color: rgba(255,255,255,0.35);
                font-size: 0.78rem;
            }

            .login-divider::before,
            .login-divider::after {
                content: '';
                flex: 1;
                border-top: 1px solid rgba(255,255,255,0.1);
            }

            .demo-creds {
                background: rgba(79, 142, 247, 0.06);
                border: 1px dashed rgba(79, 142, 247, 0.25);
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 0.8rem;
                color: rgba(255,255,255,0.45);
                text-align: center;
            }

            .demo-creds strong {
                color: #58a6ff;
            }

            .emp-portal-link {
                text-align: center;
                margin-top: 20px;
                font-size: 0.82rem;
                color: rgba(255,255,255,0.35);
            }

            .emp-portal-link a {
                color: #58a6ff;
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
                    <div class="image-composition" style="position: relative; width: 100%; max-width: 500px; aspect-ratio: 1; margin: 0 auto;">
                        <!-- Frame Image (Background Layer - Smaller Offset) -->
                        <img src="${pageContext.request.contextPath}/public/images/frame.png" alt="Frame" style="position: absolute; bottom: 0; right: 0; width: 85%; height: 85%; object-fit: contain; z-index: 1; opacity: 0.8;" />
                        <!-- Admin Image (Foreground Layer - Much Larger) -->
                        <img src="${pageContext.request.contextPath}/public/images/admin.jpg" alt="Admin" style="position: absolute; top: 0; left: 0; width: 88%; height: 88%; object-fit: cover; z-index: 2; border-radius: 20px; box-shadow: 12px 12px 30px rgba(0,0,0,0.4);" />
                    </div>
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