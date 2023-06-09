package p0609;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class jdbcTest {

	public static void main(String[] args) {
		System.out.println("접속 테스트");
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String userid ="PJH_DBA";
		String userpw="1111";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con =
					DriverManager.getConnection(url ,userid,userpw);
			System.out.println("DB 접속 성공");
//			쿼리문 작성
			String sql = "SELECT * FROM EMP";
			String sql2 = "INSERT,UPDATE,DELETE문";
			
			//전송준비
			PreparedStatement pstmt = con.prepareStatement(sql);
			//실행
			ResultSet rs = pstmt.executeQuery();
			
			
			int result = pstmt.executeUpdate();
//			레코드 순서대로 위치 이동
			while(rs.next()) {
				System.out.println(rs.getString(1)+ ""+rs.getString(2));
			}
			//종료
			rs.close();
			pstmt.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB Exception");
			e.printStackTrace();
		}
	}

}
