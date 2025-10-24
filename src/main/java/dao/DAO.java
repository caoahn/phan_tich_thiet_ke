/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author ADMIN
 */
public class DAO {
    protected Connection connection;
    
    // Thông tin kết nối database
    private static final String DB_URL = "jdbc:mysql://localhost:3306/library_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";
    

    public DAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            System.out.println("Kết nối database thành công!");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy MySQL JDBC Driver!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối database!");
            e.printStackTrace();
        }
    }

    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Đã đóng kết nối database!");
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng kết nối!");
                e.printStackTrace();
            }
        }
    }
}