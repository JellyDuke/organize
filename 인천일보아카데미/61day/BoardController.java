package com.springProject01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springProject01.dto.Board;
import com.springProject01.service.BoardService;

@Controller 
public class BoardController {

	@Autowired
	BoardService bsvc;
	
	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView boardWriteForm() {
		System.out.println("/boardWriteFrom 요청");
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("board/boardWriteForm");
		return mav;
	}
	@RequestMapping(value = "/boardWrite")
	public ModelAndView boardWrite(Board board) {
		System.out.println("/boardWrite 요청");
		System.out.println("글 등록 요청");
		
		//1.파라미터 확인
		System.out.println(board);
		
		//2.SERVICE 호출
		int writeResult = bsvc.boardWrite_svc(board);
		System.out.println("writeResult : " + writeResult);
		return null;
	}
}
