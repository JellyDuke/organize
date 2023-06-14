package p0614;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteTest {

	public static void main(String[] args) {
		// 1.db접속
		Connection con = null;
		String url = "jdbc:oracle:thin:@//localhost:1521/xe"; // 접속할 db아이피 및 정보
		String userid = "PJH_DBA"; // 접속할 db의 아이디
		String userpw = "1111"; // 접속할 db의 비밀번호

		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection(url, userid, userpw);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 드라이버 설정
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(con == null) {
			System.out.println("접속 실패");
		}else {
			System.out.println("접속 성공");
		}
		//2. 접속된 db 쿼리문 전송 결과값 반환
		String sql = "DELETE FROM CRUDTEST"; //쿼리문 작성
		int deleteResult = 0; //실행 결과 값 저장
		
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(sql); //쿼리문 실행 준비
			deleteResult = pstmt.executeUpdate(); //쿼리문 실행 후 결과 값 반환
 		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//3. 결과에 따른 처리
		if (deleteResult > 0) {
			System.out.println(deleteResult + "개의 행이 삭제 성공");
		}
		else {
			System.out.println("삭제 실패");
		}
	}
}
