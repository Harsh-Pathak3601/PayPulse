# 🚀 PayPulse Deployment Guide

This document provides a step-by-step guide to deploying the **PayPulse Employee Payroll Management System** (Frontend, Backend, and Database).

---

## 🏗️ 1. Prerequisites
Before starting, ensure you have the following installed:
*   **Java JDK 11 or higher**
*   **Maven 3.6+**
*   **MySQL Server 8.0+**
*   **Apache Tomcat 9.0+** (Servlet Container)

---

## 🗄️ 2. Database Setup (MySQL)
1.  **Create Database:**
    ```sql
    CREATE DATABASE payroll_db;
    ```
2.  **Import Schema:**
    Import the SQL schema provided in the project (usually `schema.sql` or similar). If you don't have one, ensure the tables for `employees`, `attendance`, `leaves`, `departments`, and `payroll` are created.
3.  **Update Connection Settings:**
    Open `src/main/java/com/payroll/util/DBConnection.java` and update the database credentials:
    ```java
    private static final String URL = "jdbc:mysql://localhost:3306/payroll_db";
    private static final String USER = "your_username";
    private static final String PASS = "your_password";
    ```

---

## 📦 3. Packaging the Application
The frontend (JSP/CSS/JS) and backend (Servlets/DAOs) are bundled into a single `.war` file.

1.  Open your terminal in the project root.
2.  Run the Maven build command:
    ```bash
    mvn clean package
    ```
3.  Once successful, the deployable file will be located at:
    `target/PayPulse.war`

---

## 🚀 4. Deployment Options

### Option A: Local / VPS Deployment (Apache Tomcat)
1.  Download and install **Apache Tomcat**.
2.  Copy the `PayPulse.war` file from the `target` folder.
3.  Paste it into the `webapps` directory of your Tomcat installation:
    *   *Path example:* `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\`
4.  Start the Tomcat server.
5.  Access the app at: `http://localhost:8080/PayPulse/`

### Option B: Railway.app (Recommended — Best for MySQL + Java)
Railway is the easiest platform for this project because it provides both a Tomcat environment and a free MySQL database in one place.

1.  **Create a New Project:**
    *   Go to [Railway.app](https://railway.app/) and sign up.
    *   Click **New Project** -> **Deploy from GitHub repo**.
    *   Select your `PayPulse` repository.
2.  **Add a MySQL Database:**
    *   In your Railway project dashboard, click **Add Service** -> **Database** -> **MySQL**.
    *   Railway will create a fresh MySQL instance for you.
3.  **Import your Data:**
    *   Click on the **MySQL service** -> **Connect** tab.
    *   Copy the `MYSQL_URL` or use the `mysql` CLI command provided to import your local SQL tables into Railway.
4.  **Connect App to Database:**
    *   Click on your **PayPulse App service** -> **Variables**.
    *   Click **New Variable** -> **Reference**.
    *   Map your app's variables to the MySQL service variables:
        *   `DB_URL`: `jdbc:mysql://${{MySQL.MYSQLHOST}}:${{MySQL.MYSQLPORT}}/${{MySQL.MYSQLDATABASE}}`
        *   `DB_USER`: `${{MySQL.MYSQLUSER}}`
        *   `DB_PASSWORD`: `${{MySQL.MYSQLPASSWORD}}`
5.  **Deploy:**
    *   Railway will automatically use the `Dockerfile`, build the image, and start your Tomcat server.
    *   Find your live URL under **Settings** -> **Public Networking**.
### Option C: Render (via Docker)
Render can run this project as a **Web Service** using the provided `Dockerfile`.

1.  **Prepare Database:**
    *   **Aiven Setup Guide (Free MySQL):**
        1.  Go to [aiven.io](https://aiven.io/) and sign up.
        2.  Click **Create Service** and select **MySQL**.
        3.  Choose the **Free Plan** (available in specific regions like AWS North Virginia).
        4.  Once the service is "Running", look at the **Connection Details** section.
        5.  **Important:** Copy the `Service URI`, `User`, and `Password`.
        6.  Your `DB_URL` for Render will look like this (copy from Aiven):
            `jdbc:mysql://mysql-your-id.aivencloud.com:port/defaultdb?ssl-mode=REQUIRED`
        7.  **Import your Data:** Use a tool like **MySQL Workbench** or **DBeaver** to connect to Aiven and run your SQL scripts to create tables.
    *   Keep your DB credentials (URL, User, Password) ready.
2.  **Create New Service on Render:**
    *   Click **New +** -> **Web Service**.
    *   Connect your GitHub repository.
    *   Render will automatically detect the `Dockerfile`.
3.  **Configure Service:**
    *   **Runtime:** `Docker`
    *   **Region:** Choose the one closest to you.
4.  **Environment Variables:**
    In the Render dashboard, go to the **Env Vars** tab and add:
    *   `DB_URL`: Your production database URL.
    *   `DB_USER`: Your production database user.
    *   `DB_PASSWORD`: Your production database password.
5.  **Deploy:**
    Render will build the Docker image and deploy the Tomcat server. Your app will be live at `https://your-app-name.onrender.com`.

---

## 🛠️ 5. Common Troubleshooting
*   **404 Error:** Ensure the `.war` filename matches the context path in the URL. If you rename `PayPulse.war` to `ROOT.war`, it will be available at the base URL (`/`).
*   **Database Connection Refused:** Verify that the database server is running and the credentials in `DBConnection.java` are correct.
*   **CSS Not Loading:** Clear your browser cache or perform a "Hard Refresh" (Ctrl+Shift+R).

---

## 📝 6. Post-Deployment Checklist
- [ ] Verify Admin login works.
- [ ] Test Employee login and attendance marking.
- [ ] Generate a test payslip to ensure PDF generation works in the production environment.
- [ ] Check if images in `/public/` are rendering correctly.

---

**Developed with ❤️ by the PayPulse Team**
