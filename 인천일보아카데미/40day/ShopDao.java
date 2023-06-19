package jdbcShop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ShopDao {

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
		String sql = "INSERT INTO MEMBERS(MID, MPW, MNAME, MPHONE, MBIRTH) VALUES(?, ?, ?, ?, ?)";
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
			e.printStackTrace();
		}
		return result;
	}

	public String select_idcheck(String inputId) {
		Connection con = getConnection();
		String check = null;
		if(con == null) {
			System.out.println("db연결실패");
			return check;
		}
		String sql = "SELECT MID FROM MEMBERS WHERE MID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inputId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				check = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return check;
	}
	
	public Member select_login(String inputMid, String inputMpw) {
		Connection con = getConnection();
		Member loginMember = null;
		if(con == null) {
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

	//회원정보 조회
	public Member seleclt_MemberInfo(String loginId) {
		Connection con = getConnection();
		if(con == null) {
			System.out.println("db연결 실패");
			return null;
		}
		String sql = "SELECT MID, MPW, MNAME, MPHONE, TO_CHAR(MBIRTH, 'YYYY-MM-DD') FROM MEMBERS WHERE MID = ?";
		Member mem = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				mem = new Member();
				mem.setMid(rs.getString(1));
				mem.setMpw(rs.getString(2));
				mem.setMname(rs.getString(3));
				mem.setMphone(rs.getString(4));
				mem.setMbirth(rs.getString(5));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mem;
	}


	public ArrayList<Goods> selectGoods_All() {
		Connection con = getConnection();
		if(con == null) {
			System.out.println("db연결 실패");
			return null;
		}		
		ArrayList<Goods> Y = new ArrayList<Goods>();
		Goods go = null;
		String sql = "SELECT * FROM GOODS WHERE GSTOCK > 0";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				go = new Goods();
				go.setGcode(rs.getString(1));
				go.setGname(rs.getString(2));
				go.setGprice(rs.getInt(3));
				go.setGtype(rs.getString(4));
				go.setGstock(rs.getInt(5));
				System.out.print("상품코드: " + go.getGcode());
				System.out.print(" 상품이름: " + go.getGname());
				System.out.print(" 상품가격: " + go.getGprice());
				System.out.print(" 상품타입: " + go.getGtype());
				System.out.println(" 상품재고: " + go.getGstock());
				Y.add(go);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Y;
	}


	public ArrayList<Goods> selectGoods_Type() {
		// TODO Auto-generated method stub
		return null;
	}


	public ArrayList<Goods> selectGoods_Best() {
		// TODO Auto-generated method stub
		return null;
	}

}
