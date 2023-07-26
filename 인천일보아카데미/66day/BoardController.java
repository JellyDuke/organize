package com.spring_memberBoard.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService bsvc;
	
	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView boardWriteForm() {
		System.out.println("글작성 페이지 이동요청 /boardWriteForm");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/BoardWriteForm");
		return mav;
	}
	@RequestMapping(value = "/boardWrite")
	public ModelAndView boardWrite(Board board, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("글 들록 요청 - /boardWrite");
		ModelAndView mav = new ModelAndView();
	
		String bwriter = (String)session.getAttribute("loginMemberId");
		board.setBwriter(bwriter);
		
		System.out.println(board);//등록할 글 정보
		
		//첨부파일 이름
		System.out.println("파일명 : " + board.getBfile().getOriginalFilename());
		System.out.println(session.getServletContext().getRealPath("/resources/boardUpload"));
		
		//SERVICE - 글등록 기능 호출
		int writeReslt = bsvc.registBoard(board, session);
		if(writeReslt > 0) {
			System.out.println("등록 성공");
			mav.setViewName("");//성공 후 이동할 페이지
		}else {
			System.out.println("등록 실패");
			mav.setViewName("");//실패 후 이동할 페이지
		}
		return mav;
	}
	// /boardView?bno=1
	//글 상세보기 요청
	@RequestMapping(value = "/boardView")
	public ModelAndView boardView(int bno) {
		System.out.println("글 상세 보기 요청 - /boardView");
		ModelAndView mav = new ModelAndView();
		System.out.println("상세보기 글번호 : " + bno);
		
		//1.글 정보 조회
		Board board = bsvc.getBoardView(bno);
		System.out.println(board);
		//2 글 상세보기 페이지
		mav.setViewName("board/BoardView");
		mav.addObject("board", board);
		return mav;
	}
}
