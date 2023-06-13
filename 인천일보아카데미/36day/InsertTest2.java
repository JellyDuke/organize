package p0613;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class InsertTest2 {
	public static void main(String[] args) {
		//CRUDTEST 테이블이 새로운 레코드 입력
		//1. 사용자로 부터 데이터 입력
		Scanner scan = new Scanner(System.in);
		System.out.println("숫자입력>>");
		int inputNum = scan.nextInt();
		System.out.println("문자입력>>");
		String inputStr = scan.next();
		System.out.println("날짜입력(yyyymmdd)>>");
		String inputDate = scan.next();
		
		//받은 데이터를 CRUDTEST 테이블에 입력(INSERT)하는 처리
		//2. DB 접속
		String url ="jdbc:oracle:thin:@//localhost:1521/xe";
		String userid = "PJH_DBA";
		String userpw = "1111";
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver"); //드라이버 설정
			con = DriverManager.getConnection(url,userid,userpw);
		} catch (ClassNotFoundException e) { //드라이버 예외
			e.printStackTrace();
		} catch (SQLException e) { //db예외
			e.printStackTrace();
		}
		if(con == null) {
			System.out.println("db접속 실패");
			return;
		}
		else {
			System.out.println("db접속 성공");
		}
		//3. 쿼리문 작성 및 결과값 반환
		String sql = "INSERT INTO CRUDTEST(NUMTEST, CHARTEST, DATETEST)"
						+ "VALUES(?,?,?)";
		int insertResult = 0; //insert 처리 결과값 저장
		try {
			//접속된 db 쿼리문 전송 준비
			PreparedStatement pstmt = con.prepareStatement(sql);
			//?자리에 입력
			pstmt.setInt(1, inputNum);
			pstmt.setString(2, inputStr);
			pstmt.setString(3, inputDate);
			//쿼리문 실행 및 결과 값 반환
			insertResult = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("insertResult : "+insertResult);
		if(insertResult > 0) {
			System.out.println("입력 성공");
		} else {
			System.out.println("입력 실패");
		}
	}
}
