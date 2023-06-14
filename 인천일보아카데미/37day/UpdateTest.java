package p0614;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class UpdateTest {

	public static void main(String[] args) {
		// 2. DB 접속
		Scanner scan = new Scanner(System.in);
		System.out.print("where numtest 값 >>");
		int inputNum = scan.nextInt();
		System.out.print("chartest 컬럼 수정할 값>>");
		String inputStr = scan.next();
		
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String userid = "PJH_DBA";
		String userpw = "1111";
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver"); // 드라이버 설정
			con = DriverManager.getConnection(url, userid, userpw);
		} catch (ClassNotFoundException e) { // 드라이버 예외
			e.printStackTrace();
		} catch (SQLException e) { // db예외
			e.printStackTrace();
		}
		if (con == null) {
			System.out.println("db접속 실패");
			return;
		} else {
			System.out.println("db접속 성공");
		}
		String sql = "UPDATE CRUDTEST SET CHARTEST = ? WHERE NUMTEST = ?";
		int updateResult = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inputStr);
			pstmt.setInt(2, inputNum);
			updateResult = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//결과 확인
		if (updateResult > 0) {
			System.out.println("수정성공");
		} else {
			System.out.println("수정실패");
		}
	}
}
