package com.springProject01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springProject01.dto.Member;
import com.springProject01.service.MemberService;

@Controller
public class MainController {
	MemberService msvc = new MemberService();
	@RequestMapping(value = "/")
	public ModelAndView mainPage(Model model) {
		System.out.println("controller - / 요청");
		ModelAndView mav = new ModelAndView();
		//1. 데이터 - SERVICE
//		ArrayList<Board> bList = svc.getBoardList();
		mav.addObject("maindata", "TESTDATA");
		
//		2.포워딩 - 페이지 지정
//		mav.setViewName("페이지 이름"); /WEB-INF/views/main.jsp
		mav.setViewName("MemberJoin");
		//reqest.setAttribute();
		System.out.println("/MemberJoin 요청");
		return mav; //main.jsp //페이지 반환
	}
	@RequestMapping(value = "/testPage")
	public ModelAndView testPage(int testnum, @RequestParam(value="teststr") String tstr, @RequestParam(value="testval", defaultValue ="TEST") String testval) {
		System.out.println("testPage - /요청");
		System.out.println("testnum : " + testnum);
		System.out.println("teststr : " + tstr);
		System.out.println("testval : " + testval);
		return null; 
	}
	@RequestMapping(value = "/testJoin")
	public ModelAndView testJoin(Member member) {
		System.out.println("/testJoin 요청");
		ModelAndView mav = new ModelAndView();
//		이클립스에서
//		1. 회원가입 회원정보 파라미터 확인
		System.out.println(member);
		System.out.println(member.getMid());
//		2. SERVICE 회원가입 기능 호출
//		int joinResult = msvc.memberJoin(member);
//		회원가입 성공 >> 메인페이지로 이동
		mav.setViewName("redirect:/"); // 요청
		return mav;
	}

}
