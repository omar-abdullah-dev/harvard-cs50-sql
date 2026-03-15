import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.Statement;
import java.util.Scanner;
public class Hack {
    public static void main(String[] args) throws Exception {
       Scanner in = new Scanner(System.in);
        System.out.println("Enter new password for admin:");
       String newPassword = in.nextLine();

        Connection sqliteConnection = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");

        String query = """
                UPDATE "users"
                 SET password = ? 
                 WHERE username = 'admin';
                 """;
        PreparedStatement preparedStatement = sqliteConnection.prepareStatement(query);
        preparedStatement.setString(1, newPassword);
        preparedStatement.executeUpdate();
        preparedStatement.close();

        /// here the normal statement without cleaning sql query :
//    Statement sqliteStatement = sqliteConnection.createStatement();
//    sqliteStatement.executeUpdate(
//                """
//                        UPDATE "users"
//                        SET "password" = 'hacked!'
//                        WHERE "username" = 'admin';
//                 """
//        );
//        sqliteConnection.close();
    in.close();
    }
}