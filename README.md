<<<<<<< HEAD
# PayPulse
=======
# <p align="center">💳 PayPulse — Employee Payroll Management System</p>

<p align="center">
  <img src="src/main/webapp/public/images/logo.png" alt="PayPulse Logo" width="120">
</p>

<p align="center">
  <strong>A modern, secure, and high-performance Employee Management and Payroll automation system.</strong>
</p>

---

## ✨ Features

- **🚀 Admin Dashboard**: Real-time stats with a beautiful dark-glass UI.
- **👥 Employee Management**: Full CRUD operations for team records.
- **💰 Smart Payroll**: Automatic calculation of HRA (20%), DA (10%), Bonus (5%), and Deductions (5%).
- **📄 Pro Salary Slips**: Generate and print professional salary slips in one click.
- **🔒 High Security**: 
  - **Environment variables** (.env) to protect database passwords.
  - **Jakarta EE** modern standards for Tomcat 10.
  - **SQL Injection protection** via PreparedStatements.
- **📱 Responsive Design**: Fully optimized for desktops and mobile viewports.

---

## 🛠️ Tech Stack

- **Languge**: Java 11+
- **Frontend**: JSP, JSTL, Modern Vanilla CSS (Dark-Glass Aesthetics)
- **Backend**: Jakarta Servlet 5.0 (Tomcat 10+)
- **Database**: MySQL 8.x
- **Build Tool**: Maven

---

## 🚀 Quick Setup

### 1. Database
Import the SQL schema to create your tables:
```bash
mysql -u root -p < database/schema_v2.sql
```

### 2. Configuration
Create a `.env` file in the root (see [.env.example](.env.example)) and add your MySQL password:
```env
DB_PASSWORD=your_password_here
```

### 3. Build & Deploy
```bash
mvn clean package
```
Move the generated `target/PayPulse.war` to your Tomcat `webapps/` folder and start the server.

---

## 🔐 Credentials
- **Default Username**: `admin`
- **Default Password**: `admin123`

---

<p align="center">
  Built with ❤️ for Harsh Pathak
</p>
>>>>>>> 4d3faed (Initial commit: PayPulse Management System — Jakarta EE 10 Modern Rebranding)
