-- ============================================================
-- Employee Payroll Management System — Database Schema
-- MySQL 8.x compatible
-- Run this entire file to set up the database from scratch.
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS payroll_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE payroll_db;

-- ──────────────────────────────────────────────────────────────
-- TABLE: employees
-- ──────────────────────────────────────────────────────────────
DROP TABLE IF EXISTS payroll;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id       INT          NOT NULL AUTO_INCREMENT,
    name         VARCHAR(100) NOT NULL,
    department   VARCHAR(50)  NOT NULL,
    designation  VARCHAR(80)  NOT NULL,
    basic_salary DECIMAL(12,2) NOT NULL CHECK (basic_salary > 0),
    created_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ──────────────────────────────────────────────────────────────
-- TABLE: payroll
-- ──────────────────────────────────────────────────────────────
CREATE TABLE payroll (
    payroll_id   INT           NOT NULL AUTO_INCREMENT,
    emp_id       INT           NOT NULL,
    basic_salary DECIMAL(12,2) NOT NULL,  -- Snapshot of salary at time of generation
    hra          DECIMAL(12,2) NOT NULL,  -- House Rent Allowance (20%)
    da           DECIMAL(12,2) NOT NULL,  -- Dearness Allowance (10%)
    bonus        DECIMAL(12,2) NOT NULL,  -- Performance Bonus (5%)
    deductions   DECIMAL(12,2) NOT NULL,  -- Total Deductions (5%)
    net_salary   DECIMAL(12,2) NOT NULL,  -- Net = Basic + HRA + DA + Bonus - Deductions
    pay_date     DATE          NOT NULL,
    created_at   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (payroll_id),
    CONSTRAINT fk_payroll_emp
        FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    INDEX idx_emp_id  (emp_id),
    INDEX idx_pay_date (pay_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ──────────────────────────────────────────────────────────────
-- Database is now ready for your data!
-- Add employees through the application UI or using INSERT statements.
-- ──────────────────────────────────────────────────────────────

