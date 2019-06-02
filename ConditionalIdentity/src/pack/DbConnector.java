package pack;


import java.sql.Connection;
import java.sql.DriverManager;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ibn
 */
public class DbConnector {
    
    public static Connection getConnection() {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/";
        String dbName = "pri_multiKey";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "sneha";
        try {
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url + dbName, userName, password);
            System.out.println("Connected to the database");
    } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
     public static void main(String arg[]){
        DbConnector.getConnection();
    }
}
