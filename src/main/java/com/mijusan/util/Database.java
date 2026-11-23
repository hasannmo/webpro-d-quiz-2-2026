package com.mijusan.util;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private static String dbPath = null;

    static {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static synchronized void init(String path) {
        if (path != null && !path.trim().isEmpty()) {
            dbPath = path;
        }
    }

    public static synchronized String getDbPath() {
        if (dbPath == null) {
            // Default discovery fallback
            File f = new File("src/main/webapp/WEB-INF/database.sqlite");
            if (f.exists()) {
                dbPath = f.getAbsolutePath();
            } else {
                File f2 = new File("midterm-src/database/database.sqlite");
                if (f2.exists()) {
                    dbPath = f2.getAbsolutePath();
                } else {
                    dbPath = "database.sqlite";
                }
            }
        }
        return dbPath;
    }

    public static Connection getConnection() throws SQLException {
        String url = "jdbc:sqlite:" + getDbPath();
        return DriverManager.getConnection(url);
    }
}
