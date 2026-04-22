-- ============================================================
-- PayPulse v2.0 — Enterprise Database Schema
-- MySQL 8.x compatible
-- ============================================================

CREATE DATABASE IF NOT EXISTS payroll_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE payroll_db;

-- 1. Departments Table
CREATE TABLE IF NOT EXISTS departments (
    dept_id    INT          NOT NULL AUTO_INCREMENT,
    dept_name  VARCHAR(100) NOT NULL UNIQUE,
    dept_head  VARCHAR(100),
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (dept_id)
) ENGINE=InnoDB;

-- 2. Designations Table
CREATE TABLE IF NOT EXISTS designations (
    desig_id    INT          NOT NULL AUTO_INCREMENT,
    desig_name  VARCHAR(100) NOT NULL,
    dept_id     INT          NOT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (desig_id),
    CONSTRAINT fk_desig_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Employees Table (Updated)
CREATE TABLE IF NOT EXISTS employees (
    emp_id        INT           NOT NULL AUTO_INCREMENT,
    name          VARCHAR(100)  NOT NULL,
    email         VARCHAR(100)  NOT NULL UNIQUE,
    phone         VARCHAR(15),
    dept_id       INT,
    designation   VARCHAR(100)  NOT NULL,
    basic_salary  DECIMAL(12,2) NOT NULL CHECK (basic_salary > 0),
    join_date     DATE,
    employee_type ENUM('FULL_TIME', 'PART_TIME', 'CONTRACT') DEFAULT 'FULL_TIME',
    password_hash VARCHAR(255)  NOT NULL, -- For ESS portal login
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (emp_id),
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 4. Attendance Table
CREATE TABLE IF NOT EXISTS attendance (
    attendance_id  INT           NOT NULL AUTO_INCREMENT,
    emp_id         INT           NOT NULL,
    att_date       DATE          NOT NULL,
    status         ENUM('PRESENT', 'ABSENT', 'HALF_DAY', 'HOLIDAY') DEFAULT 'PRESENT',
    check_in       TIME,
    check_out      TIME,
    overtime_hours DECIMAL(4,2)  DEFAULT 0,
    PRIMARY KEY (attendance_id),
    UNIQUE KEY (emp_id, att_date),
    CONSTRAINT fk_att_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Leaves Table
CREATE TABLE IF NOT EXISTS leaves (
    leave_id      INT           NOT NULL AUTO_INCREMENT,
    emp_id        INT           NOT NULL,
    leave_type    ENUM('SICK', 'ANNUAL', 'CASUAL') NOT NULL,
    start_date    DATE          NOT NULL,
    end_date      DATE          NOT NULL,
    total_days    INT           NOT NULL,
    reason        TEXT,
    status        ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    admin_remarks TEXT,
    applied_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (leave_id),
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. Leave Balance Table
CREATE TABLE IF NOT EXISTS leave_balance (
    id                INT NOT NULL AUTO_INCREMENT,
    emp_id            INT NOT NULL,
    leave_type        ENUM('SICK', 'ANNUAL', 'CASUAL') NOT NULL,
    total_entitlement INT NOT NULL DEFAULT 12,
    used_days         INT NOT NULL DEFAULT 0,
    remaining_days    INT NOT NULL DEFAULT 12,
    year              INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (emp_id, leave_type, year),
    CONSTRAINT fk_lb_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. Payroll Table (Updated)
CREATE TABLE IF NOT EXISTS payroll (
    payroll_id    INT           NOT NULL AUTO_INCREMENT,
    emp_id        INT           NOT NULL,
    basic_salary  DECIMAL(12,2) NOT NULL,
    hra           DECIMAL(12,2) NOT NULL,
    da            DECIMAL(12,2) NOT NULL,
    bonus         DECIMAL(12,2) NOT NULL,
    pf_deduction  DECIMAL(12,2) NOT NULL,
    esi_deduction DECIMAL(12,2) NOT NULL,
    tds_deduction DECIMAL(12,2) NOT NULL,
    lop_deduction DECIMAL(12,2) NOT NULL,
    gross_salary  DECIMAL(12,2) NOT NULL,
    net_salary    DECIMAL(12,2) NOT NULL,
    working_days  INT           NOT NULL,
    paid_days     INT           NOT NULL,
    overtime_pay  DECIMAL(12,2) NOT NULL DEFAULT 0,
    pay_date      DATE          NOT NULL,
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (payroll_id),
    CONSTRAINT fk_payroll_emp_v2 FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Default Admin (Keep existing logic or migrate here)
-- Note: Admin login is currently hardcoded in LoginServlet.

-- 8. Seed Data (Initial Setup)
-- Departments
INSERT INTO departments (dept_id, dept_name, dept_head) VALUES 
(1, 'Information Technology', 'Arjun Mehta'),
(2, 'Human Resources', 'Sneha Kapoor'),
(3, 'Finance & Accounts', 'Rajesh Iyer'),
(4, 'Operations', 'Priya Sharma');

-- Designations (Linked to Departments)
INSERT INTO designations (desig_name, dept_id) VALUES 
('Software Engineer', 1),
('System Architect', 1),
('QA Engineer', 1),
('HR Manager', 2),
('Recruitment Specialist', 2),
('Chartered Accountant', 3),
('Financial Analyst', 3),
('Operations Head', 4),
('Logistics Coordinator', 4);
