package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Member;

public class MemberDao {
	
	Connection getConnection() {

		Connection con = null;

		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String userid = "JSP_BOARD";
		String userpw = "1111";

		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection(url, userid, userpw);
		}

		catch (ClassNotFoundException e) { // 드라이버 예외
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		catch (SQLException e) { // DB 예외
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}

	public Member selectMemberInfo(String checkId) {
		System.out.println("dao - selectMemberInfo() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
			return new Member();
		}
		
		String sql = "SELECT * FROM MEMBERS WHERE MID = ?";
		
		Member member = null;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, checkId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				member = new Member();
				member.setMid(rs.getString("MID"));
				member.setMpw(rs.getString("MPW"));
				member.setMname(rs.getString("MNAME"));
				member.setMbirth(rs.getString("MBIRTH"));
				member.setMaddr(rs.getString("MADDR"));
			}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}

	public int signup(Member joinMember) {
		
		System.out.println("dao - signup() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		
		int result = 0;
		String sql = "Insert INTO MEMBERS(MID, MPW, MNAME, MBIRTH, MADDR) VALUES(?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, joinMember.getMid());
			pstmt.setString(2, joinMember.getMpw());
			pstmt.setString(3, joinMember.getMname());
			pstmt.setString(4, joinMember.getMbirth());
			pstmt.setString(5, joinMember.getMaddr());
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return result;
	}

	public Member selectMemberLogin(String loginId, String loginPw) {
		
		System.out.println("dao - selectMemberLogin() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
			return null;
		}
		
		Member mem = null;
		String sql = "SELECT * FROM MEMBERS WHERE MID = ? AND MPW = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, loginPw);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mem = new Member();
				mem.setMid(rs.getString(1));
				mem.setMpw(rs.getString(2));
				mem.setMname(rs.getString(3));
				mem.setMbirth(rs.getString(4));
				mem.setMaddr(rs.getString(5));
			}
			
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mem;
	}
	
}
