package com.payroll.util;

public class TaxCalculator {

    // Standard Allowances
    public static double calculateHRA(double basic) { return basic * 0.20; }
    public static double calculateDA(double basic)  { return basic * 0.10; }
    public static double calculateBonus(double basic) { return basic * 0.05; }

    // Statutory Deductions (India)
    
    /** Provident Fund: 12% of Basic Salary */
    public static double calculatePF(double basic) {
        return basic * 0.12;
    }

    /** 
     * Employee State Insurance: 0.75% of Gross Salary.
     * Applicable only if Gross Monthly Salary <= 21,000 INR.
     */
    public static double calculateESI(double gross) {
        if (gross <= 21000) {
            return gross * 0.0075;
        }
        return 0.0;
    }

    /**
     * Tax Deducted at Source (Simplified Slab - Monthly Projection)
     * Annual Gross < 5L: 0%
     * 5L - 7L: 5% of (Annual - 5L)
     * 7L - 10L: 10%...
     * This is a simplified estimation for the demo.
     */
    public static double calculateTDS(double monthlyGross) {
        double annualGross = monthlyGross * 12;
        double tax = 0;

        if (annualGross <= 500000) {
            tax = 0;
        } else if (annualGross <= 700000) {
            tax = (annualGross - 500000) * 0.05;
        } else if (annualGross <= 1000000) {
            tax = (200000 * 0.05) + (annualGross - 700000) * 0.10;
        } else {
            tax = (200000 * 0.05) + (300000 * 0.10) + (annualGross - 1000000) * 0.20;
        }

        return tax / 12; // Return monthly TDS
    }

    /**
     * Loss of Pay Calculation:
     * (Basic Salary / Total Working Days) * Number of Days Absent
     */
    public static double calculateLOP(double basic, int totalWorkingDays, int paidDays) {
        if (totalWorkingDays <= 0 || paidDays >= totalWorkingDays) return 0.0;
        int absentDays = totalWorkingDays - paidDays;
        return (basic / totalWorkingDays) * absentDays;
    }
}
