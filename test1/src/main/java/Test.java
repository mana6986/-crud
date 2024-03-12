import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // 데이터베이스 URL
        String username = "system"; // 데이터베이스 사용자 이름
        String password = "qwer1234"; // 데이터베이스 암호

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT * FROM T_USER";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String userPassword = rs.getString("password");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String addressDetail = rs.getString("address_detail");
                    String postalCode = rs.getString("postal_code");
                    String note = rs.getString("note");

                    System.out.println("Name: " + name);
                    System.out.println("Email: " + email);
                    System.out.println("Password: " + userPassword);
                    System.out.println("Phone: " + phone);
                    System.out.println("Address: " + address);
                    System.out.println("Address Detail: " + addressDetail);
                    System.out.println("Postal Code: " + postalCode);
                    System.out.println("Note: " + note);
                    System.out.println();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
