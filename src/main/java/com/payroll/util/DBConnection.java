package com.payroll.util;

import io.github.cdimascio.dotenv.Dotenv;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Singleton utility class for JDBC database connection.
 * Credentials are loaded from the .env file for security.
 */
public class DBConnection {

    private static final Dotenv dotenv = Dotenv.configure()
            .ignoreIfMissing()
            .load();

    private static final String DB_URL      = getEnv("DB_URL");
    private static final String DB_USER     = getEnv("DB_USER");
    private static final String DB_PASSWORD = getEnv("DB_PASSWORD");
    private static final String DRIVER      = "com.mysql.cj.jdbc.Driver";

    private static String getEnv(String key) {
        String value = System.getenv(key);
        if (value == null || value.isEmpty()) {
            value = dotenv.get(key);
        }
        return value;
    }

    // Private constructor prevents instantiation
    private DBConnection() {
    }

    /**
     * Returns a new JDBC Connection on each call.
     * Callers are responsible for closing the connection (use try-with-resources).
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found. Add mysql-connector to classpath.", e);
        }
        
        try {
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.err.println("CRITICAL: Failed to connect to database at " + DB_URL);
            System.err.println("Error: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Silently closes a connection — safe to call with null.
     */
    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ignored) {
            }
        }
    }
}
