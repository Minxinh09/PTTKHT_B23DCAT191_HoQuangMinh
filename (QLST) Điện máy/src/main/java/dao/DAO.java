package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/shopman?useUnicode=true&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            String dbUser = "root";
            String dbPass = "123456"; // Đổi thành mật khẩu MySQL của bạn nếu khác

            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                System.out.println("Kết nối CSDL MySQL shopman thành công!");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
