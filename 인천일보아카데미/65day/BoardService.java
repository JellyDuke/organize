package com.spring_memberBoard.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring_memberBoard.dao.BoardDao;
import com.spring_memberBoard.dto.Board;

@Service
public class BoardService {
	@Autowired
	private BoardDao bdao;
	
	public int registBoard(Board board) {
		System.out.println("SERVICE - registBoard() 호출");
		//업로드 된 파일 저장 - 저장경로 설정, 파일명 처리
		MultipartFile bfile = board.getBfile(); //첨부파일
		String bfilename = "";//파일명 저장할 변수
		String savePath = ""; //파일을 저장할 경로
		\
		
		
		//업로드된 파일의 이름 추출 -bfilename

		//글번호 생성 (최대값 + 1 )
		int bno = bdao.selectbno();
		bno += 1;
		
		
		//DAO - INSERT INTO BOARDS
		
		//INSERT 결과 반환
		return 0;
	}
	
}
