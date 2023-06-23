package admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class Admindao {
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
	public ArrayList<HashMap<String, String>> select () {
		Connection con = getConnection();
		if(con == null) {
			System.out.println("db연결 실패");
			return null;
		}
		String sql = "SELECT * FROM MEMBERS";
		ArrayList<HashMap<String,String>> List = new ArrayList<HashMap<String,String>>();
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, String> member = new HashMap<String, String>();
				member.put("MID", rs.getString(1));
				member.put("MPW", rs.getString(2));
				member.put("MNAME", rs.getString(3));
				member.put("MPHONE", rs.getString(4));
				member.put("MBIRTH", rs.getString(5));
				member.put("MSTATE", rs.getString(6));
				List.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return List;
	}
	public int updateR(String mid, String mstate) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return 0;
		}
		String sql = "UPDATE MEMBERS ";
		int result = 0;
		if(mstate.equals("Y")) {
			sql += "SET MSTATE = 'N' WHERE MID = ?";
		} else {
			sql += "SET MSTATE = 'Y' WHERE MID = ?";
		}
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public ArrayList<HashMap<String, String>> goodsList() {

		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		String sql = "SELECT GNAME, GPRICE, GSTOCK, GSTATE, GCODE FROM GOODS";
		ArrayList<HashMap<String, String>> goods = new ArrayList<HashMap<String, String>>();
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, String> good = new HashMap<String,String>();
				good.put("GNAME", rs.getString(1));
				good.put("GPRICE", rs.getString(2));
				good.put("GSTOCK", rs.getString(3));
				good.put("GSTATE", rs.getString(4));
				good.put("GCODE", rs.getString(5));
				goods.add(good);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
	public int upateA(String gstate, String gname, String gcode) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return 0;
		}
		String sql = "UPDATE GOODS ";
		int result = 0;
		if(gstate.equals("Y")) {
			sql += "SET GSTATE = 'N' WHERE GCODE = ?";
		} else {
			sql += "SET GSTATE = 'Y' WHERE GCODE = ?";
		}
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gcode);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
