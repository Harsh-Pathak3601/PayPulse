# <p align="center">💳 PayPulse v2.0 — Enterprise Payroll Management System</p>

<p align="center">
  <img src="src/main/webapp/public/images/logo.webp" alt="PayPulse Logo" width="160" onerror="this.style.display='none'">
</p>

<p align="center">
  <strong>A high-performance, glassmorphic, and production-ready Employee Management & Payroll Automation System.</strong>
</p>

---

## 🌟 Project Overview

**PayPulse** is a comprehensive ERP-lite solution designed to streamline Human Resources and Financial operations for modern enterprises. Built with a focus on **Visual Excellence** and **Numerical Precision**, PayPulse automates the entire lifecycle of an employee—from onboarding and attendance tracking to complex statutory tax computations and automated payslip generation.

The system features a dual-portal architecture, providing tailored experiences for Administrators (HR/Finance) and Employees (Self-Service).

---

## ✨ Key Modules & Features

### 🛡️ Administrator Powerhouse
- **Dynamic Analytics Dashboard**: Real-time visualization of headcount, department distribution, and monthly financial burn.
- **Enterprise Employee Management**: Complete CRUD operations with secure profile handling, department assignment, and designation tracking.
- **Automated Payroll Engine**: 
  - **Prorated Salary**: Precise calculations based on monthly attendance and working days.
  - **Tax & Compliance**: Automatic calculation of **HRA (20%)**, **DA (10%)**, **PF (12%)**, and slab-based **TDS**.
  - **ESI Management**: Automatic ESI deductions for eligible salary brackets.
- **Attendance & Leaves**: Centralized control over employee presence with status tracking (Present, Absent, Half-Day, Holiday) and a streamlined leave approval workflow.
- **Document Automation**: One-click professional PDF Payslip generation and automated Email notifications.

### 👤 Employee Self-Service (ESS)
- **Personalized Portal**: Secure login for employees to manage their own professional data.
- **Attendance Transparency**: Interactive history of monthly attendance records.
- **Leave Application**: Real-time leave requests with reason tracking and status updates.
- **Payslip Vault**: Instant access to download historical and current salary slips in PDF format.

---

## 🎨 Design Aesthetics

PayPulse is built with a **Premium UI/UX** philosophy:
- **Glassmorphic Interface**: Utilizing subtle blurs, vibrant gradients, and high-contrast typography for a futuristic feel.
- **Responsive Architecture**: Fully optimized for Desktop, Tablet, and Mobile devices.
- **Micro-Animations**: Smooth CSS3 transitions and hover effects to enhance user engagement.
- **Dark/Light Harmony**: Elegant dark themes for high-impact landing pages and clean, high-readability light themes for administrative tasks.

---

## 🛠️ Technology Stack

| Layer | Technology |
| :--- | :--- |
| **Backend Core** | Java 11 (Jakarta Servlet 5.0, JSP, JSTL) |
| **Database** | MySQL 8.x (Optimized with PreparedStatements) |
| **Frontend** | Vanilla CSS3 (Custom Variables), JavaScript (ES6+), Google Fonts |
| **Security** | BCrypt/Secure Hashing, Session-based Auth, Dotenv Configuration |
| **Integrations** | Jakarta Mail (SMTP), OpenPDF (Document Generation) |
| **DevOps** | Apache Maven, Docker, Environment Injection |

---

## 📊 Database Architecture

The system utilizes a highly normalized relational schema designed for scalability:
- **`employees`**: Centralized identity and financial profile.
- **`departments` & `designations`**: Organizational hierarchy mapping.
- **`attendance`**: Daily log with overtime tracking.
- **`leaves` & `leave_balance`**: Automated accrual and deduction engine.
- **`payroll`**: Financial snapshots of all historical disbursements.

---

## 🚀 Deployment & Installation

### 1. Prerequisites
- Java 11+
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 10.1+

### 2. Local Setup
1. **Clone & Navigate**:
   ```bash
   git clone https://github.com/Harsh-Pathak3601/PayPulse.git
   cd Employee-Payroll
   ```
2. **Environment Config**:
   Create a `.env` file in the root directory:
   ```env
   DB_URL=jdbc:mysql://localhost:3306/payroll_db
   DB_USER=your_user
   DB_PASSWORD=your_password
   SMTP_HOST=smtp.gmail.com
   SMTP_PORT=587
   SMTP_USER=your_email
   SMTP_PASS=your_app_password
   ```
3. **Database Import**:
   Run the SQL script located in `/database/schema_v2.sql`.
4. **Build & Run**:
   ```bash
   mvn clean package
   # Deploy the target/PayPulse.war to your Tomcat webapps folder
   ```

### 3. Cloud Deployment (Docker)
PayPulse is container-ready. Simply set your environment variables in your cloud provider (Railway, Render, Aiven) and deploy using the provided `Dockerfile`.

---

## 🔐 Security Standards
- **SQL Injection Prevention**: 100% usage of PreparedStatements.
- **Sensitive Data Isolation**: Credentials managed via environment variables.
- **Session Guards**: Centralized `SessionUtil` to prevent unauthorized endpoint access.
- **Fail-Fast DAO**: Robust error handling that prevents silent data failure.

---

<p align="center">
  Built with ❤️ by <strong>Harsh Pathak</strong>
</p>
