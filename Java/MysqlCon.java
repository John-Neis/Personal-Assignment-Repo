import java.sql.*;

public class MysqlCon
{
    public static void main(String[] args)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = 
                DriverManager.getConnection("jdbc:mysql://localhost:3306/f19db", 
                "root", "pass260word");
            Statement sql = con.createStatement();
            ResultSet rs = sql.executeQuery("select * from library;");
            while(rs.next())
            {
                System.out.println(rs.getString(1) + "|" + rs.getString(2));
            }

            con.close();
        }
        catch(Exception e)
        {
            System.err.println(e);
        }
    }
}