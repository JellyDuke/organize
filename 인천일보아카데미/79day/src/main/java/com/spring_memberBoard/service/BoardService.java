package com.spring_memberBoard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring_memberBoard.dao.BoardDao;
import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao bdao;

	// 글 등록 기능
	public int registBoard(Board board, HttpSession session) throws IllegalStateException, IOException {
		
		System.out.println("SERVICE - registBoard() 호출");
		
		// 업로드된 파일 저장 - 저장경로 설정, 파일명 처리
		MultipartFile bfile = board.getBfile(); // 첨부 파일
		String bfilename = ""; // 파일명 저장할 변수
		String savePath = session.getServletContext().getRealPath("/resources/boardUpload"); // 파일을 저장할 경로
		
		if(!bfile.isEmpty()) { // 첨부파일 확인
			//  첨부파일이 있는 경우
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");
			
			// 임의의 코드 + img3.jpg
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : " + code);
			bfilename = code + "_" + bfile.getOriginalFilename();
			
			// 저장할 경로 resources/boardUpload 폴더에 파일 저장
			System.out.println("savePath" + savePath);
			File newFile = new File(savePath, bfilename);
			bfile.transferTo(newFile);
			
		}
		
		System.out.println("파일이름 : " + bfilename);
		board.setBfilename(bfilename);
		// 제목, 내용, 작성자, 첨부파일명
		System.out.println(board);
		
		// 글번호 생성 (최대값 + 1) - SELECT MAX(BNO) FROM BOARDS
		int bno = bdao.getMaxBno() + 1;
		board.setBno(bno);
		
		// DAO - INSERT INTO BOARDS...
		int insertResult = 0;
		try {
			insertResult = bdao.insertBoard(board);			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// INSERT 결과 반환
		return insertResult;
	}

	public Board getBoardView(int bno) {
		
		System.out.println("SERVICE - getBoardView 호출");
		
		
		Board board = null;
		
		try {
			// 1. 조회수 증가
			bdao.updatebhits(bno);
			// 2. 글 정보 조회
			board = bdao.selectBoard(bno);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		// 3. 글내용 줄바꿈 문자 >> 태그로 치환
		String bcontents = board.getBcontents();
		bcontents = bcontents.replace("\r\n", "<br>").replace(" ", "&nbsp;");
		board.setBcontents(bcontents);
		
		return board;
	}

	public ArrayList<Board> getBoardList(String mid) {
		
		System.out.println("SERVICE - getboardList 호출");
		
		// DAO - SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BDATE DESC
		ArrayList<Board> boardList = null;
		
		try {
			
			if(mid == null) {
				boardList = bdao.selectBoardList();
			}
			else {
				boardList = bdao.selectTotalBoard(mid);
			}
			
			// 글번호가 1번인 글의 댓글 수
			// SELECT COUNT(*) FROM REPLYS WHERE REBNO = ?;
			for(Board bo : boardList) { // int i=0;i<boardList.size();i++
				System.out.println(bo.getBno());
				// System.out.println(boardList.get(i).getBno());
				int recount = bdao.selectBoardRecount(bo.getBno());
				bo.setRecount(recount);
			}
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardList;
	}

	// HashMap - 글목록 조회
	public ArrayList<HashMap<String, String>> getBoardList_Map() {
		
		System.out.println("SERVICE - getBoardList_Map() 호출");
		
		return bdao.selectBoards_map();
	}
	
	// 댓글 등록 기능
	public int registReply(Reply re) {
		
		System.out.println("SERVICE - registReply() 호출");
		
		// 1. 댓글 번호 생성
		int renum = bdao.selectMaxRenum() + 1;
		re.setRenum(renum); // renum 필드에 댓글 번호 저장	
		
		// 2. DAO - INSERT문 호출
		int insertResult = 0;
		try {
			insertResult = bdao.insertReply(re);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return insertResult;
	}

	// 댓글 목록 조회 기능
	public ArrayList<Reply> getReplyList(int rebno) {
		
		System.out.println("SERVICE - getReplyList() 호출");
		
//		SELECT * FROM REPLY WHERE REBNO = #{rebno }
		return bdao.selectReplyList(rebno);
	}

	public int getDelReplyResult(int renum) {
		
		System.out.println("SERVICE - deleteReply() 호출");
		
		return bdao.deleteReply(renum);
	}

	public ArrayList<Board> getTotalBoard(String memId) {
		
		System.out.println("SERVICE - getTotalPost() 호출");
		
		ArrayList<Board> totalBoard = null;
		
		try {
			totalBoard = bdao.selectTotalBoard(memId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return totalBoard;
	}

	public ArrayList<Reply> getTotalReply(String memId) {
		
		System.out.println("SERVICE - getTotalReply() 호출");
		
		ArrayList<Reply> totalReply = null;
		
		try {
			totalReply = bdao.selectTotalReply(memId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return totalReply;
	}

	
}
