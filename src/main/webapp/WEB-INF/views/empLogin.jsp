<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Employee Portal — PayPulse</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            background: #070d1a;
            color: #e8f0fe;
            min-height: 100vh;
            overflow: hidden;
            -webkit-font-smoothing: antialiased;
        }
        .login-root {
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 100vh;
        }

        /* ══ LEFT: Form Panel ══ */
        .form-side {
            position: relative;
            background: #0c1525;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 56px;
        }
        .form-side::before {
            content: '';
            position: absolute;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(34,197,94,0.07) 0%, transparent 70%);
            top: -60px; left: -60px;
            border-radius: 50%;
        }
        .form-wrap { width: 100%; max-width: 400px; position: relative; z-index: 1; }

        .form-logo { display: flex; align-items: center; gap: 12px; margin-bottom: 36px; }
        .form-logo img {
            height: 44px; width: auto;
            filter: drop-shadow(0 0 12px rgba(0,201,167,0.45));
        }

        .form-heading { margin-bottom: 28px; }
        .form-heading h1 { font-size: 1.75rem; font-weight: 800; color: #fff; margin-bottom: 6px; }
        .form-heading p  { font-size: 0.875rem; color: rgba(255,255,255,0.4); }

        .form-card {
            background: #111827;
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 20px;
            padding: 36px;
            box-shadow: 0 24px 64px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.05);
        }

        .field { margin-bottom: 20px; }
        .field label {
            display: block;
            font-size: 0.75rem; font-weight: 600;
            color: rgba(255,255,255,0.45);
            letter-spacing: 0.08em; text-transform: uppercase;
            margin-bottom: 8px;
        }
        .input-wrap { position: relative; }
        .input-wrap .ico {
            position: absolute; left: 14px; top: 50%;
            transform: translateY(-50%);
            font-size: 1rem; pointer-events: none; opacity: 0.45;
        }
        .input-wrap input {
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
        .input-wrap input::placeholder { color: rgba(255,255,255,0.22); }
        .input-wrap input:focus {
            border-color: rgba(34,197,94,0.6);
            box-shadow: 0 0 0 3px rgba(34,197,94,0.1);
            background: rgba(255,255,255,0.07);
        }

        .error-box {
            background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.3);
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 0.82rem; color: #f87171;
            margin-bottom: 20px;
            display: flex; align-items: center; gap: 8px;
        }

        .submit-btn {
            width: 100%; padding: 14px; border: none; border-radius: 12px;
            background: linear-gradient(135deg, #00c9a7 0%, #22c55e 100%);
            color: #fff;
            font-family: 'Inter', sans-serif;
            font-size: 0.95rem; font-weight: 700; cursor: pointer;
            letter-spacing: 0.02em; margin-top: 8px;
            box-shadow: 0 4px 24px rgba(34,197,94,0.3);
            transition: all 0.3s ease;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 36px rgba(34,197,94,0.45);
        }

        .security-note {
            margin-top: 20px;
            background: rgba(34,197,94,0.04);
            border: 1px solid rgba(34,197,94,0.12);
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 0.79rem; color: rgba(255,255,255,0.35);
            text-align: center;
        }
        .bottom-link {
            text-align: center; margin-top: 24px;
            font-size: 0.82rem; color: rgba(255,255,255,0.35);
        }
        .bottom-link a { color: #00c9a7; text-decoration: none; font-weight: 600; }
        .bottom-link a:hover { text-decoration: underline; }

        /* ══ RIGHT: Brand Panel ══ */
        .brand-side {
            position: relative;
            background: linear-gradient(160deg, #030d0a 0%, #061210 40%, #082018 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 56px;
            overflow: hidden;
        }
        .blob { position: absolute; border-radius: 50%; filter: blur(90px); opacity: 0.5; }
        .blob-1 { width: 450px; height: 450px; background: radial-gradient(circle, #00c9a7 0%, transparent 70%); top: -120px; right: -120px; animation: drift 12s ease-in-out infinite alternate; }
        .blob-2 { width: 300px; height: 300px; background: radial-gradient(circle, #22c55e 0%, transparent 70%); bottom: -80px; left: -80px; animation: drift 16s ease-in-out infinite alternate-reverse; }
        @keyframes drift { from { transform: translate(0,0) scale(1); } to { transform: translate(25px, 18px) scale(1.07); } }
        .brand-side::before {
            content: '';
            position: absolute; inset: 0;
            background-image:
                linear-gradient(rgba(0,201,167,0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,201,167,0.03) 1px, transparent 1px);
            background-size: 48px 48px;
        }
        .brand-content { position: relative; z-index: 2; text-align: center; width: 100%; max-width: 420px; }

        .brand-logo { margin-bottom: 28px; }
        .brand-logo img {
            height: 80px; width: auto;
            filter: drop-shadow(0 0 30px rgba(0,201,167,0.55)) brightness(1.1);
        }
        .brand-title {
            font-size: 2rem; font-weight: 900;
            background: linear-gradient(90deg, #00c9a7 0%, #22c55e 50%, #58a6ff 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }
        .brand-sub {
            font-size: 0.78rem; font-weight: 600;
            color: rgba(255,255,255,0.28);
            letter-spacing: 0.12em; text-transform: uppercase;
            margin-bottom: 44px;
        }
        .benefit-cards { display: flex; flex-direction: column; gap: 12px; text-align: left; }
        .bc {
            background: rgba(255,255,255,0.025);
            border: 1px solid rgba(0,201,167,0.12);
            border-radius: 14px;
            padding: 16px 20px;
            display: flex; align-items: center; gap: 16px;
            backdrop-filter: blur(8px);
            transition: border-color 0.3s, background 0.3s;
        }
        .bc:hover { border-color: rgba(0,201,167,0.3); background: rgba(0,201,167,0.04); }
        .bc-icon {
            width: 40px; height: 40px; flex-shrink: 0;
            background: linear-gradient(135deg, rgba(0,201,167,0.15), rgba(34,197,94,0.1));
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.15rem;
        }
        .bc-info strong { display: block; font-size: 0.84rem; font-weight: 700; color: rgba(255,255,255,0.85); margin-bottom: 3px; }
        .bc-info span { font-size: 0.75rem; color: rgba(255,255,255,0.38); }

        @media (max-width: 900px) {
            .login-root { grid-template-columns: 1fr; }
            .brand-side { display: none; }
            .form-side { padding: 40px 24px; }
        }
    </style>
</head>
<body>
<div class="login-root">

    <!-- ══ LEFT: Login Form ══ -->
    <div class="form-side">
        <div class="form-wrap">
            <div class="form-logo">
                <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="PayPulse"/>
            </div>

            <div class="form-heading">
                <h1>Employee Portal 🪪</h1>
                <p>Sign in to view your payslips, leaves & attendance</p>
            </div>

            <div class="form-card">
                <% if (request.getAttribute("error") != null) { %>
                <div class="error-box">⚠️ <%= request.getAttribute("error") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/emp-login" method="POST" novalidate>
                    <div class="field">
                        <label>Email Address</label>
                        <div class="input-wrap">
                            <span class="ico">📧</span>
                            <input type="email" name="email" id="email"
                                   placeholder="you@company.com"
                                   autocomplete="email" required/>
                        </div>
                    </div>
                    <div class="field">
                        <label>Password</label>
                        <div class="input-wrap">
                            <span class="ico">🔑</span>
                            <input type="password" name="password" id="password"
                                   placeholder="Enter your password"
                                   autocomplete="current-password" required/>
                        </div>
                    </div>
                    <button type="submit" class="submit-btn">Access My Portal →</button>
                </form>
            </div>

            <div class="security-note">🔒 You can only view your own personal records.</div>
            <div class="bottom-link">
                Admin? <a href="${pageContext.request.contextPath}/login">Go to Admin Login →</a>
            </div>
        </div>
    </div>

    <!-- ══ RIGHT: Brand Panel ══ -->
    <div class="brand-side">
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
        <div class="brand-content">
            <div class="brand-logo">
                <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="PayPulse"/>
            </div>
            <div class="brand-title">PayPulse ESS</div>
            <div class="brand-sub">Employee Self-Service Portal</div>
            <div class="benefit-cards">
                <div class="bc">
                    <div class="bc-icon">📄</div>
                    <div class="bc-info">
                        <strong>Download Payslips</strong>
                        <span>Access all your monthly salary slips anytime</span>
                    </div>
                </div>
                <div class="bc">
                    <div class="bc-icon">📅</div>
                    <div class="bc-info">
                        <strong>Track Attendance</strong>
                        <span>See daily records and monthly summary</span>
                    </div>
                </div>
                <div class="bc">
                    <div class="bc-icon">🍃</div>
                    <div class="bc-info">
                        <strong>Apply for Leaves</strong>
                        <span>Submit sick, casual & annual leave requests</span>
                    </div>
                </div>
                <div class="bc">
                    <div class="bc-icon">⚖️</div>
                    <div class="bc-info">
                        <strong>Tax Breakdown</strong>
                        <span>View PF, ESI, TDS & LOP deductions clearly</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('email').focus();
    });
</script>
</body>
</html>