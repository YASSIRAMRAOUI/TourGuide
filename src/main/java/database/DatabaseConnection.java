package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;
import java.io.IOException;

public class DatabaseConnection {
    private static String url;
    private static String user;
    private static String password;
    private static String driverClass;

    // Static block to load properties and initialize the driver
    static {
        try (InputStream input = DatabaseConnection.class.getClassLoader()
                .getResourceAsStream("databaseConnection.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find databaseConnection.properties");
            }

            Properties prop = new Properties();
            prop.load(input);

            url = prop.getProperty("db.url");
            user = prop.getProperty("db.user");
            password = prop.getProperty("db.password");
            driverClass = prop.getProperty("db.driver");

            // Load the driver class
            Class.forName(driverClass);
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to load database configuration", e);
        }
    }

    // Method to establish and return a connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
