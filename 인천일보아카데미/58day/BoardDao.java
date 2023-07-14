package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Board;

public class BoardDao {
	
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

	public ArrayList<Board> selectBoardList() {
		// TODO Auto-generated method stub
		
		System.out.println("dao - selectBoardList() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
			return null;
		}
		
		Board board = null;
		ArrayList<Board> boardList = new ArrayList<Board>();
		
		String sql = "SELECT * FROM BOARD WHERE BSTATE = '1' ORDER BY BNO DESC";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				board = new Board();
				board.setBNO(rs.getInt(1));
				board.setBWRITER(rs.getString(2));
				board.setBTITLE(rs.getString(3));
				board.setBCONTENTS(rs.getString(4));
				board.setBHITS(rs.getInt(5));
				board.setBSTATE(rs.getString(6));
				boardList.add(board);
			}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return boardList;
	}

	public int selectbno() {
		
		System.out.println("dao - selectbno() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		
		int result = 0;
		String sql = "SELECT MAX(BNO) FROM BOARD";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	public int insertBoard(int bno, String bwiter, String title, String content) {
		
		System.out.println("dao - selectbno() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
		}
		
		int result = 0;
		String sql = "INSERT INTO BOARD(BNO, BWRITER, BTITLE, BCONTENTS, BHITS, BSTATE) "
				   + "VALUES(?, ?, ?, ?, 0, 1)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, bwiter);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public Board selectBoard(int viewBno) {
		
		System.out.println("dao - selectBoard() 호출");
		
		Connection con = getConnection();
		
		if(con == null) {
			System.out.println("접속 실패");
			return null;
		}
		
		Board board = null;
		String sql = "SELECT * FROM BOARD WHERE BNO = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, viewBno);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				board = new Board();
				board.setBNO(rs.getInt(1));
				board.setBWRITER(rs.getString(2));
				board.setBTITLE(rs.getString(3));
				board.setBCONTENTS(rs.getString(4));
				board.setBHITS(rs.getInt(5));
				board.setBSTATE(rs.getString(6));
			}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return board;
	}

	public void updateBoardHits(int viewBno) {
		System.out.println("dao - selectBoard() 호출");
		BoardDao bdao = new BoardDao();
		bdao.updateBoardHits(viewBno);
	}
}
