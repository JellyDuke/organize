package service;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDao;
import dto.Board;

public class BoardService {
	
	BoardDao bdao = new BoardDao();

	public ArrayList<Board> getBoardList() {
		// TODO Auto-generated method stub
		
		System.out.println("service - getBoardList() 호출");
		
		ArrayList<Board> boardList = bdao.selectBoardList();
		
		return boardList;
	}

	public int getBoard(String bwiter, String title, String content) {
		
		System.out.println("service - getBoard 호출");
		
		int bno = bdao.selectbno();
		bno += 1;
		
		int result = bdao.insertBoard(bno, bwiter, title, content);
		
		return result;
	}

	public Board getBoardView(int viewBno) {
		
		System.out.println("service - getBoardView 호출");
		
		Board board = bdao.selectBoard(viewBno);
		
		return board;
	}
	
	

}
