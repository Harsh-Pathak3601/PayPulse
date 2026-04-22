package com.payroll.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBTest {
    public static void main(String[] args) {
        System.out.println("--- Testing Database Connection ---");
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                System.out.println("✅ SUCCESS: Connected to payroll_db!");
                
                // Test if data exists
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM departments");
                if (rs.next()) {
                    System.out.println("📊 Departments found in DB: " + rs.getInt(1));
                }
            } else {
                System.out.println("❌ FAILURE: Connection is null.");
            }
        } catch (Exception e) {
            System.err.println("❌ DATABASE ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
