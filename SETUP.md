# 📋 PayPulse — Setup Guide

## ✅ Project Summary

| Item | Details |
|------|---------|
| **Brand** | **PayPulse** |
| **Architecture** | MVC (Model-View-Controller) |
| **Backend** | Java 11+, Jakarta Servlet 5.0 (Tomcat 10+) |
| **Database** | MySQL 8.x via JDBC |
| **Environment** | Secured via `.env` configuration |
| **Default Login** | `admin` / `admin123` |

---

## 📁 Project Structure

```
PayPulse/
├── pom.xml                ← Maven dependencies (Jakarta EE)
├── .env                   ← Private database credentials
├── database/
│   └── schema_v2.sql         ← MySQL schema for creation
├── src/main/
│   ├── java/com/payroll/
│   │   ├── model/         ← Employee & Payroll POJOs
│   │   ├── dao/           ← JDBC Data Access Objects
│   │   ├── servlet/       ← Jakarta Servlets (Controllers)
│   │   └── util/          ← DBConnection Utility (.env loader)
│   └── webapp/
│       ├── css/           ← Modern Dark-Glass UI (style.css)
│       └── WEB-INF/
│           ├── web.xml    ← Jakarta EE 5.0 Descriptor
│           └── views/     ← JSP Pages
```

---

## ⚙️ Prerequisites

1.  **JDK 11+** installed.
2.  **Apache Maven** (ensure `mvn` is in your System Path).
3.  **Apache Tomcat 10.x** installed.
4.  **MySQL Server 8.x** running.

---

## 🗄️ Step 1 — Database Setup

1.  Open MySQL Workbench or your terminal.
2.  Run the code in [schema_v2.sql](database/schema_v2.sql) to create the `payroll_db` and tables.
    ```bash
    mysql -u root -p < database/schema_v2.sql
    ```

---

## 🔐 Step 2 — Security Configuration

1.  Open the **[.env](.env)** file in the root directory.
2.  Update your `DB_PASSWORD` to match your local MySQL root password:
    ```env
    DB_PASSWORD=your_actual_password
    ```

---

## 📦 Step 3 — Build & Package

From the project root, run:
```bash
mvn clean package
```
This will generate **`target/PayPulse.war`**.

---

## 🚀 Step 4 — Deployment

1.  Copy `target/PayPulse.war`.
2.  Paste it into the **`webapps`** folder of your Tomcat 10 installation.
3.  Start Tomcat (run `bin/startup.bat`).
4.  Visit: `http://localhost:8080/PayPulse/`

---

## 🐛 Common Troubleshooting

| Issue | Solution |
|-------|----------|
| `mvn` not found | Add Maven `bin` folder to your Windows Environment Variables (Path). |
| 404 Error | Ensure you are using **Tomcat 10** (Jakarta EE) and the file is named `PayPulse.war`. |
| Login Fails | Verify MySQL is running and your `.env` password is correct. |
| Icons missing | Check your internet connection (Google Fonts/Mermaid) or `style.css` path. |
