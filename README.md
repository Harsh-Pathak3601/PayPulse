# <p align="center">💳 PayPulse — Enterprise Payroll Management System</p>

<p align="center">
  <img src="src/main/webapp/public/images/logo.webp" alt="PayPulse Logo" width="120" onerror="this.style.display='none'">
</p>

<p align="center">
  <strong>A modern, glassmorphic, and high-performance Employee Management and Payroll automation system.</strong>
</p>

---

## 🌟 Overview

**PayPulse** is a production-grade payroll management solution designed with a focus on high-end aesthetics and operational efficiency. It provides a dual-portal experience for Administrators and Employees, featuring a state-of-the-art **Glassmorphic UI** and automated business logic for payroll processing.

---

## ✨ Key Features

### 🏢 Administrator Portal
- **Dashboard Analytics**: Instant visibility into total employees, department distribution, and monthly payroll expenses.
- **Employee Management**: Full lifecycle management (CRUD) of employee records with secure profile handling.
- **Departmental Logic**: Organize teams by departments with custom roles and hierarchies.
- **Attendance Control**: Manual and automated attendance marking with status tracking (Present, Absent, Half-Day).
- **Automated Payroll**: 
  - Proportional salary calculation based on attendance.
  - Automatic calculation of HRA, DA, Bonus, and Deductions.
  - **PDF Generation**: One-click generation of professional PDF payslips.

### 👤 Employee Portal (greytHR Inspired)
- **Personal Dashboard**: View individual stats and attendance overview at a glance.
- **Attendance History**: **[NEW]** Filter and view attendance records for any previous month and year.
- **Leave Management**: Apply for leaves and track approval status in real-time.
- **Payslip Access**: Download monthly salary slips directly from the portal.

---

## 🎨 Design Philosophy
- **Modern Aesthetics**: Utilizes a premium **Dark-Glass UI** for the landing page and high-contrast **Light Theme** (greytHR style) for internal portals.
- **Responsive Layout**: Seamless experience across Mobile, Tablet, and Desktop viewports.
- **Micro-Animations**: Smooth transitions and hover effects using optimized CSS3 animations.

---

## 🛠️ Technical Stack
- **Backend**: Java 11 (Jakarta Servlet 5.0)
- **Frontend**: JSP, JSTL, Vanilla CSS3 (Custom Variables)
- **Database**: MySQL 8.0 (Optimized with PreparedStatements for security)
- **Security**: 
  - Environment-based configuration (`.env`)
  - Session-based Authentication & Authorization
  - Protection against SQL Injection and XSS
- **DevOps**: Maven (Build Tool), Docker (Containerization)

---

## 🚀 Deployment

PayPulse is fully optimized for cloud deployment (Railway, Render, Tomcat). 

- **Ready-to-use Dockerfile**: Included for containerized environments.
- **Cloud Configuration**: Environment variable support for DB connections.
- **Detailed Guide**: Check [deployment.md](deployment.md) for step-by-step instructions.

---

## 🔐 Setup & Installation

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/Harsh-Pathak3601/PayPulse.git
    ```
2.  **Database Configuration**:
    - Import the SQL schema from the `/database` folder.
    - Create a `.env` file and add your MySQL credentials.
3.  **Build the Project**:
    ```bash
    mvn clean package
    ```
4.  **Run with Tomcat**:
    Deploy the generated `PayPulse.war` to your Tomcat `webapps/` folder.

---

<p align="center">
  Built with ❤️ for Harsh Pathak3601
</p>
