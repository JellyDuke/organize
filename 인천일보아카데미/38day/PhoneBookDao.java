package P0614_1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

	public int insert(PhoneBook pb) { // phonebook 테이블 insert 수행
		// 1.db접속
		Connection con = getConnection();
		if (con == null) {
			System.out.println("db연결 실패");
			return 0;
		}
		// 2. 쿼리문 실행
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
		// 결과값 반환
		return result;

	}

	public ArrayList<PhoneBook> select() {
		// 1. db접속 (connection)
		Connection con = getConnection();
		// 2. 쿼리문 실행 결과값 반환
		if (con == null) {
			System.out.println("접속 실패");
			return null;
		}
		String sql = "SELECT * FROM PHONEBOOK"; // 쿼리문 작성
		ArrayList<PhoneBook> pbList = new ArrayList<PhoneBook>(); // 결과값 저장할 변수
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);// 쿼리문 준비
			ResultSet rs = pstmt.executeQuery();// 쿼리문 실행 결과값 반환
			while (rs.next()) { // ResultSet>>ArrayList 변환
				PhoneBook pb = new PhoneBook();
				pb.setName(rs.getString(1));
				pb.setPhonenum(rs.getString(2));
				pbList.add(pb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pbList;
	}

	public ArrayList<PhoneBook> select_name(String inputName) {
		// 1. db접속 (connection)
		Connection con = getConnection();
		// 2. 쿼리문 실행 결과값 반환
		if (con == null) {
			System.out.println("접속 실패");
			return null;
		}
		String sql = "SELECT * FROM PHONEBOOK WHERE name = ?"; // 쿼리문 작성
		ArrayList<PhoneBook> pbList = new ArrayList<PhoneBook>(); // 결과값 저장할 변수
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);// 쿼리문 준비
			pstmt.setString(1, inputName); // ? 에 맵핑 처리
			ResultSet rs = pstmt.executeQuery();// 쿼리문 실행 결과값 반환
			while (rs.next()) { // ResultSet>>ArrayList 변환
				PhoneBook pb = new PhoneBook();
				pb.setName(rs.getString(1));
				pb.setPhonenum(rs.getString(2));
				pbList.add(pb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pbList;
	}

	public int update(PhoneBook pb, String inputPhoneNum) {
		// 1. db접속 (connection)
		Connection con = getConnection();
		// 2. 쿼리문 실행 결과값 반환
		if (con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		String sql = "UPDATE PHONEBOOK SET PHONENUM = ? WHERE NAME = ? AND PHONENUM = ?"; // 쿼리문 작성
		int result = 0 ;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);// 쿼리문 준비
			pstmt.setString(1, inputPhoneNum); // ? 에 맵핑 처리
			pstmt.setString(2, pb.getName());
			pstmt.setString(3, pb.getPhonenum());
			result = pstmt.executeUpdate();// 쿼리문 실행 결과값 반환
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public int delete(PhoneBook pb) {
		//1.db접속
		Connection con = getConnection();
		// 2. 쿼리문 실행 결과값 반환
		if (con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		String sql = "DELETE FROM PHONEBOOK WHERE NAME = ? AND PHONENUM = ?";
		int result = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pb.getName());
			pstmt.setString(2, pb.getPhonenum());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}