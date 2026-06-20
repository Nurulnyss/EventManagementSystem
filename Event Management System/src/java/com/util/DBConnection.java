package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/event";

    private static final String USER = "root";
    private static final String PASSWORD = "admin";

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("DB CONNECTED SUCCESSFULLY");

        } catch (ClassNotFoundException e) {
            System.out.println("JDBC DRIVER NOT FOUND");
            e.printStackTrace();

        } catch (SQLException e) {
            System.out.println("DB CONNECTION FAILED");
            e.printStackTrace();
        }

        return con;
    }
}