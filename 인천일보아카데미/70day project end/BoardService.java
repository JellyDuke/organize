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
	
	public int registBoard(Board board, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("SERVICE - registBoard() 호출");
		//업로드 된 파일 저장 - 저장경로 설정, 파일명 처리
		MultipartFile bfile = board.getBfile(); //첨부파일
		String bfilename = "";//파일명 저장할 변수
		String savePath = session.getServletContext().getRealPath("/resources/boardUpload"); //파일일을 저장할 변수
		if(!bfile.isEmpty()){ //첨부파일 확인
			//첨부파일이 없는 경우
			//!bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");

			//임의의 코드 + img3.jpg
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : " + code);
			bfilename = code + "_" + bfile.getOriginalFilename();
		
			//저장할 경로 resources/boardUpload 폴더에 파일저장
			System.out.println("savePath: " + savePath);
			File newFile = new File(savePath,bfilename);
			bfile.transferTo(newFile);
		}
		System.out.println("파일이름 : " + bfilename);
		board.setBfilename(bfilename); //업로드 된 이름 추출 -bfilename
		System.out.println(board); //제목, 내용, 작성자, 첨부파일 명
		

		//글번호 생성 (최대값 + 1 ) - SELECT MAX(BNO)+1 FROM BOARDS
		int bno = bdao.selectbno()+1;
		board.setBno(bno);
		
		//DAO - INSERT INTO BOARDS
		int result = 0;
		try {
			result = bdao.insertBoard(board);
		} catch (Exception e) {
		}
		
		//INSERT 결과 반환
		return result;
	}

	public Board getBoardView(int bno) {
		System.out.println("SERVICE - getBoardView 호출");
		//1. 조회수 증가
		
		
		//2. 글 정보 조회
		Board board = null;
		try {
			board = bdao.selectBoard(bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
//		bdao.updateBoardHits(bno);
		
		//3. 글 내용 줄바꿈 문자 >> 태그로 치환
		return board;
	}

	public ArrayList<Board> getBoardList() {
		System.out.println("SERVICE - getBoardList()호출");
		
		ArrayList<Board> bList = null;
		try {
			//select * from boards where bstate = '1' oreder bdate desc
			bList = bdao.selectBoardList();
			// 글번호가 1번인 글의 댓글 수
			for(Board board : bList) { //int =0; i<bList.size(); i++
										//bList.get(i).getBno();
				int recount = bdao.selectBoardRecount(board.getBno());
				board.setRecount(recount);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println("recount 추가 후 bList 출력");
		return bList;
	}

	public int registReply(Reply re) {
		System.out.println("SERVICE - registReply()호출");
//		1.댓글 번호 생성
		int renum = bdao.selectMaxRenum() + 1;
		re.setRenum(renum);//댓글번호 저장 renum필드에
		//2.DAO - INSERT문 호출ㅅㄷㅋㅌㅇㅅㅎㄷㄴㅌ  
		int insertResult = 0;
		try {
			insertResult = bdao.insertReply(re);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return insertResult;
	}

	public ArrayList<Reply> getReplyList(int rebno) {
		System.out.println("SERVICE - getReplyList() 호출");
		//1.댓글 목록 조회
		return bdao.selectReplyList(rebno);
	}

	public int deleteReply(int renum) {
		System.out.println("SERVICE - deleteReply() 호출");
		
		return bdao.deleteReply(renum);
	}

	public int getTotalPost(String infoId) {
		System.out.println("SERVICE - getTotalPost() 호출");
		
		return bdao.selectTotalPost(infoId);
	}

	public int getTotalReply(String infoId) {
		System.out.println("SERVICE - getTotalReply()호출");
		return bdao.selectTotalReply(infoId);
	}

	public ArrayList<HashMap<String, String>> getBoardList_map() {
		System.out.println("SERVICE - getBoardList_map()호출");
		return bdao.selectBoards_map();
	}

}
