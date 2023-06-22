package jdbcShop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

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
		if(con == null) {
			System.out.println("db연결실패");
			return null;
		}
		String sql = "SELECT MID FROM MEMBERS WHERE MID = ?";
		String check = null;
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
			return null;
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
				loginMember.setMstate(rs.getString(3));
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
				
				Y.add(go);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Y;
	}
	//주문코드 최대값 조회
	public String selectMaxOdcode() {
		//1. db접속
		Connection con = getConnection();
		if(con == null) {
			System.out.println("db연결 실패");
			return null;
		}		
		//2. 쿼리문
		String sql = "SELECT NVL(MAX(ODCODE),'O0000') FROM ORDERS";
		String maxOdcode = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				maxOdcode = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return maxOdcode;
	}


	public int LCY(String odcode, String loginId, String odgcode, int odqty) {
		//1. db접속
				Connection con = getConnection();
				if(con == null) {
					System.out.println("db연결 실패");
					return 0;
				}	
		//2. 쿼리문
		String sql = "INSERT INTO ORDERS (ODCODE, ODMID, ODGCODE, ODQTY, ODDATE) VALUES(?, ?, ?, ?,SYSDATE)";
		int result = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, odcode);
			pstmt.setString(2, loginId);
			pstmt.setString(3, odgcode);
			pstmt.setInt(4, odqty);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}


	public int LAY(String odgcode, int odqty) {
		//1. db접속
		Connection con = getConnection();
		if(con == null) {
			System.out.println("db연결 실패");
			return 0;
		}	
		//2. 쿼리문
		String sql = "UPDATE GOODS SET GSTOCK = GSTOCK - ? WHERE GCODE = ?";
		int Update = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, odqty);
			pstmt.setString(2, odgcode);
			Update = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Update;
	}


	public ArrayList<Goods> selectGoods_Type() {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		String sql = "SELECT GTYPE FROM GOODS GROUP BY GTYPE";
		ArrayList<Goods> goodsList = new ArrayList<Goods>();

		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				Goods goods = new Goods();
				goods.setGtype(rs.getString(1));
				goodsList.add(goods);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goodsList;
	}


	public ArrayList<Goods> selectGoods_Type(String gtype) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		String sql = "SELECT * FROM GOODS WHERE GTYPE = ? AND GSTOCK > 0";
		ArrayList<Goods> goodsList = new ArrayList<Goods>(); //ARRAYLIST <from 테이블 명>
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gtype); //물음표 맵핑
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Goods goods = new Goods();
				goods.setGcode(rs.getString("GCODE")); //1
				goods.setGname(rs.getString(2));
				goods.setGprice(rs.getInt(3));
				goods.setGtype(rs.getString(4));
				goods.setGstock(rs.getShort(5));
				goodsList.add(goods);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goodsList;
	}

	//인기상품
	public ArrayList<Goods> selectGoods_Best() {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		ArrayList<Goods> goodsList = new ArrayList<Goods>();
		String sql = "SELECT * FROM GOODS GD INNER JOIN (SELECT ODGCODE,SUM(ODQTY) AS T "
				                                     + "FROM ORDERS "
				                                     + "GROUP BY ODGCODE) OD "
				                                     + "ON GD.GCODE = OD.ODGCODE "
				                                     + "ORDER BY OD.T DESC";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Goods goods = new Goods();
				goods.setGcode(rs.getString(1));
				goods.setGname(rs.getString(2));
				goods.setGprice(rs.getInt(3));
				goods.setGtype(rs.getString(4));
				goods.setGstock(rs.getInt(5));
				goodsList.add(goods);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goodsList;
	}


	public ArrayList<HashMap<String, String>> selectGoods_Map() {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		//2.쿼리문 실행 결과값 반환
		String sql = "SELECT * FROM GOODS";
		ArrayList<HashMap<String,String>> goodsList = new ArrayList<HashMap<String,String>>();
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String,String> goods = new HashMap<String, String>();
				goods.put("GCODE", rs.getString(1));
				goods.put("GNAME", rs.getString(2));
				goods.put("GPRICE", rs.getString(3)); //goods.put("GPRICE", rs.getInt(3)+"");
				goods.put("GTYPE", rs.getString(4));
				goods.put("GSTOCK", rs.getString(5));
				goodsList.add(goods);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return goodsList;
	}


	public int selectCountOrder(String loginId) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return 0;
		}
		int result = 0;
		String sql = "SELECT COUNT(*) FROM ORDERS WHERE ODMID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}


	public int selectTotalPrice(String loginId) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return 0;
		}
		String sql = "SELECT SUM(GD.GPRICE * OD.ODQTY) FROM ORDERS OD, GOODS GD WHERE (OD.ODGCODE = GD. GCODE) AND (OD.ODMID = ?)";
		int result = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId); //1 -> 물음표 위치, loginId -> 물음표에 들어갈 변수
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}


//	public ArrayList<HashMap<String, String>> orderList(String loginId) {
//		Connection con = getConnection();
//		if (con == null) {
//			System.out.println("접속");
//			return null;
//		}
//		String sql = "SELECT OD.ODCODE, GD.GNAME, GD.GPRICE, OD.ODQTY, (GD.GPRICE*OD.ODQTY) AS T, OD.ODDATE "
//					+"FROM GOODS GD, ORDERS OD "
//					+"WHERE (OD.ODGCODE = GD.GCODE) AND OD.ODMID = ? "
//					+"ORDER BY OD.ODDATE ASC";
//		ArrayList<HashMap<String,String>> odList = new ArrayList<HashMap<String,String>>();
//		HashMap<String,String> odL = null;
//		try {
//			PreparedStatement pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, loginId);
//			ResultSet rs = pstmt.executeQuery();
//			while(rs.next()){
//				odL = new HashMap<String,String>(); 
//				odL.put("ODCODE", rs.getString(1));
//				odL.put("GNAME", rs.getString(2));
//				odL.put("GPRICE", rs.getString(3)+"");
//				odL.put("ODQTY", rs.getString(4)+"");
//				odL.put("T", rs.getString(5)+"");
//				odL.put("ODDATE", rs.getString(6));
//				odList.add(odL);
//				
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		return odList;
//	}


	public ArrayList<HashMap<String, String>> orderList2(String loginId, int select ) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		String sql = "SELECT OD.ODCODE, GD.GNAME, GD.GPRICE, OD.ODQTY, (GD.GPRICE*OD.ODQTY) AS T, OD.ODDATE "
					+"FROM GOODS GD, ORDERS OD "
					+"WHERE (OD.ODGCODE = GD.GCODE) AND OD.ODMID = ? "
					+"ORDER BY T DESC";
		ArrayList<HashMap<String,String>> odList = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> odL = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				odL = new HashMap<String,String>(); 
				odL.put("ODCODE", rs.getString(1));
				odL.put("GNAME", rs.getString(2));
				odL.put("GPRICE", rs.getString(3)+"");
				odL.put("ODQTY", rs.getString(4)+"");
				odL.put("T", rs.getString(5)+"");
				odL.put("ODDATE", rs.getString(6));
				odList.add(odL);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return odList;
	}
	public ArrayList<HashMap<String, String>> orderList(String loginId, int select) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return null;
		}
		String sql = "SELECT OD.ODCODE, GD.GNAME, GD.GPRICE, OD.ODQTY, (GD.GPRICE*OD.ODQTY) AS T, OD.ODDATE, GD.GCODE "
					+"FROM GOODS GD, ORDERS OD "
					+"WHERE (OD.ODGCODE = GD.GCODE) AND OD.ODMID = ? ";
					
		if(select == 1) {
			sql += "ORDER BY OD.ODDATE DESC";
		} else {
			sql += "ORDER BY T DESC";
		}
		ArrayList<HashMap<String,String>> odList = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> odL = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				odL = new HashMap<String,String>(); 
				odL.put("ODCODE", rs.getString(1));
				odL.put("GNAME", rs.getString(2));
				odL.put("GPRICE", rs.getString(3)+"");
				odL.put("ODQTY", rs.getString(4)+"");
				odL.put("T", rs.getString(5)+"");
				odL.put("ODDATE", rs.getString(6));
				odL.put("GCODE", rs.getString(7));
				odList.add(odL);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return odList;
	}


	public int cancelOrder(String odcode, String gcode, int odqty) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속");
			return 0;
		}
		String delSql = "DELETE FROM ORDERS WHERE ODCODE = ?";
		int delresult = 0;
		String upSql ="UPDATE GOODS SET GSTOCK = GSTOCK + ? WHERE GCODE = ?";
		int upresult =0;
		try {
			con.setAutoCommit(false); //delete 했지만 update가 안될 수 있어서 자동커밋을 false로 둔다.
			PreparedStatement pstmt = con.prepareStatement(delSql);
			pstmt.setString(1, odcode);
			delresult = pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(upSql); 
			pstmt.setInt(1, odqty);
			pstmt.setString(2, gcode);
			upresult = pstmt.executeUpdate(); //upresult 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		int result = 0;
		try {
			if(delresult > 0 && upresult > 0) {
				con.commit();
				result = 1;
			}
			else {
				con.rollback();
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}



		




//	public int order(Order od) {
//		Connection con = getConnection();
//		if(con == null) {
//			System.out.println("db연결실패");
//			return 0;
//		}
//		String sql = "INSERT INTO ORDERS (ODCODE, ODMID, ODGCODE, ODQTY, ODDATE) VALUES(?, ?, ?, ?,SYSDATE)";
//		String sql2 = "UPDATE GOODS SET GSTOCK = GSTOCK - ? WHERE GCODE = ?";
//		int update = 0;
//		int insert = 0;
//		try {
//			PreparedStatement pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, od.odcode);
//			pstmt.setString(2, od.loginId);
//			pstmt.setString(3, od.odgcode);
//			pstmt.setInt(4, od.odqty);
//			insert = pstmt.executeUpdate(); //insert
//			PreparedStatement pstmt = con.prepareStatement(sql2);
//			pstmt.setInt(1, odqty);
//			pstmt.setString(2, odgcode);
//			update = pstmt.executeUpdate(); //update
//		} catch (SQLException e) {
//			if(insert > 0 && update > 0) {
//				con.commit();
//			} else {
//				con.rollback();
//			}
//			e.printStackTrace();
//		}
//		return 0;
//	}

}
