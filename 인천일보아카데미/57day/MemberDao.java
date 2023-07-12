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
			Class.forName("oracle.jdbc.OracleDriver"); // 드라이버 설정
			con = DriverManager.getConnection(url, userid, userpw);
		} catch (ClassNotFoundException e) { // 드라이버 예외
			e.printStackTrace();
		} catch (SQLException e) { // db예외
			e.printStackTrace();
		}
		return con;
	}

	public Member selectMemberInfo(String checkId) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("db연결 실패");
			return new Member();
		}
		Member member = null;
		System.out.println("dao - selectMemberInfo() 호출");
		String sql = "SELECT * FROM MEMBERS WHERE MID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, checkId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				member = new Member();
				member.setMid(rs.getString(1));
				member.setMpw(rs.getString(2));
				member.setMname(rs.getString(3));
				member.setMbirth(rs.getString(4));
				member.setMaddr(rs.getString(5));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(member);
		return member;
	}

	public int insert(Member joinMember) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("db연결 실패");
			return 0;
		}
		String sql = "INSERT INTO MEMBERS(MID, MPW, MNAME, MBIRTH, MADDR) VALUES(?, ?, ?, ? , ?)";
		int result = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, (joinMember.getMid()));
			pstmt.setString(2, (joinMember.getMpw()));
			pstmt.setString(3, (joinMember.getMname()));
			pstmt.setString(4, (joinMember.getMbirth()));
			pstmt.setString(5, (joinMember.getMaddr()));
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public Member select_login(String loginId, String loginPw) {
		Connection con = getConnection();
		Member loginMember = null;
		if (con == null) {
			System.out.println("db연결 실패");
			return loginMember;
		}
		String sql = "SELECT * FROM MEMBERS WHERE MID = ? AND MPW =?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, loginPw);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				loginMember = new Member();
				loginMember.setMid(rs.getString(1));
				loginMember.setMpw(rs.getString(2));
				loginMember.setMname(rs.getString(3));
				loginMember.setMbirth(rs.getString(4));
				loginMember.setMaddr(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return loginMember;
	}

}
