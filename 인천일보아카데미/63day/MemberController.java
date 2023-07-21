package com.spring_memberBoard.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService msvc;
	
	@RequestMapping(value = "/MemberJoinForm")
	public ModelAndView MemberJoinForm() {
		System.out.println("/MemberJoinFrom 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/MemberJoinForm");
		return mav;
	}
	@RequestMapping(value = "/memberIdCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
		System.out.println("아이디 중복 확인 요청");
		System.out.println("중복 확인 할 아이디 : " +inputId);
		//1. 서비스 호출 - 아이디 중복 확인 기능
		// MEMBERS 테이블의 MID 컬럼에 저장된 아이디 인지 확인
		// SELECT * FROM MEMBERS WHERE MID = #{};
		String checkResult = msvc.midCheck(inputId);
		//2. 중복 확인 결과 반환 Y: 사용가능 N: 사용불가(중복)
		return checkResult;
	}
	
	@RequestMapping(value = "/memberJoin")
	public ModelAndView MemberJoin(Member mem, String memailId, String memailDomain) {
		System.out.println("회원가입 요청");
		ModelAndView mav = new ModelAndView();
		String memail = memailId + "@" + memailDomain;
		
		mem.setMemail(memail);
		mem.setMstate("1");
		System.out.println(memailId + memailDomain);
		System.out.println(mem);
		int joinResult = msvc.signupSvc(mem);
		if(joinResult > 0) {
			System.out.println("회원가입 성공");
			mav.setViewName("MainPage"); //redirect:/ 가입페이지 재 요청.
		}else {
			System.out.println("회원가입 실패");
			mav.setViewName("Fail");
		}
		return null;
		
	}
}
