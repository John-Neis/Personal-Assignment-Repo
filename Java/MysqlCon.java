import java.sql.DriverManager;
import java.sql.Connection;

public class MysqlCon {

    private static final String url = "jdbc:mysql://localhost:3306/bankusers?autoReconnect=true&useSSL=false";
    private static final String user = "root";
    private static final String password = "pass260word";

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(url, user, password);
            System.out.println("Connected Successfully");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}