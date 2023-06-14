package p0614;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

public class SelectTest2 {

	public static void main(String[] args) {
		//CRUDTEST 테이블의 모든 데이터 조회(SELECT)
		Scanner scan = new Scanner(System.in);
		System.out.print("numtest input >> ");
		int inputNum = scan.nextInt();
		
		// 2. DB 접속
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
		//2.쿼리문 실행 및 결과 값 반환
		String sql = "Select NUMTEST, CHARTEST, TO_CHAR(DATETEST, 'YYYY-MM-DD') FROM CRUDTEST WHERE NUMTEST = ?";
		
		// 결과 값을 저장할 변수
		ArrayList<CrudDto> crudList = new ArrayList<CrudDto>();
		// where절
		CrudDto cruddto = null;
		try {
			// 접속된 db에 쿼리문 전송 준비
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, inputNum);
			// 쿼리문 실행 및 결과 값 반환
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				System.out.println("출력");
				cruddto = new CrudDto();
				cruddto.setNumtest(rs.getInt(1));
				cruddto.setChartest(rs.getString("CHARTEST")); 
				cruddto.setDatetest(rs.getString(3));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 3. 확인
		if (cruddto == null) {
			System.out.println("조회된 정보가 없습니다.");
		}
	}
}
