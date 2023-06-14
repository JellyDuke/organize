package P0614_1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PhoneBookDao {
	Connection getConnection() {
		Connection con = null;
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String userid = "PJH_DBA";
		String userpw = "1111";
		try {
			Class.forName("oracle.jdbc.OracleDriver"); // 드라이버 설정
			con = DriverManager.getConnection(url, userid, userpw);
		} catch (ClassNotFoundException e) { // 드라이버 예외
			e.printStackTrace();
		} catch (SQLException e) { // db예외
			e.printStackTrace();
		}
		return con;
	}
	public int insert(PhoneBook pb) { //phonebook 테이블 insert 수행
		//1.db접속
		Connection con = getConnection();
		if (con == null) {
			System.out.println("db연결 실패");
			return 0;
		}
		//2. 쿼리문 실행
		String sql = "INSERT INTO PHONEBOOK(NAME, PHONENUM) VALUES (?, ?)";
		int result = 0;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pb.getName());
			pstmt.setString(2, pb.getPhonenum());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//결과값 반환
		return result;
		
	}
}
