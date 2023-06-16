package jdbcMember;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.spi.DirStateFactory.Result;

public class MemberDao {
	
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
	public int insert(Member mb) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("db연결 실패");
			return 0;
		}
		// 2. 쿼리문 실행
		String sql = "INSERT INTO MEMBERS(MID, MPW, MNAME, MPHONE, MBIRTH) VALUES (?, ?, ?, ? ,?)";
		int result = 0;

		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, (mb.getMid()));
			pstmt.setString(2, (mb.getMpw()));
			pstmt.setString(3, (mb.getMname()));
			pstmt.setString(4, (mb.getMphone()));
			pstmt.setString(5, (mb.getMbirth()));
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 결과값 반환
		return result;
	}
	public String select_idcheck(String inputID) {
		Connection con = getConnection();
		String check = null;
		if (con == null) {
			System.out.println("db연결 실패");
			return check;
		}
		// 2. 쿼리문 실행
		String sql = "SELECT MID FROM MEMBERS WHERE MID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inputID);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				check = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return check;
	}
	public Member select_login(String inputMid, String inputMpw) {
		Connection con = getConnection();
		Member loginMember = null;
		if (con == null) {
			System.out.println("db연결 실패");
			return loginMember;
		}
		String sql = "SELECT * FROM MEMBERS WHERE MID = ? AND MPW = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inputMid);
			pstmt.setString(2, inputMpw);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				loginMember = new Member();
				loginMember.setMid(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return loginMember;
	}
}
