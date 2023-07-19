package com.springProject01.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springProject01.dto.Member;
import com.springProject01.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService msvc;
	
	@RequestMapping(value = "/memberJoin")
	public ModelAndView MemberJoin(Member member) {
		System.out.println("/MemberJoin 요청");
		System.out.println(member);
//		1.SERVICE 회원가입 기능 호출
		int joinResult = msvc.memberJoin_svc(member);
//		2.결과 값에 따른 페이지 포워딩
		if(joinResult > 0) {
			System.err.println("가입 성공");
		} else {
			System.out.println("가입 실패");
		}
		return null;
	}
	@RequestMapping(value = "/memberList")
	public ModelAndView memberList() {
		System.out.println("/memberList 요청");
		ArrayList<Member> mList = msvc.getMemberList();
		System.out.println("mList ");
		System.out.println(mList);
		
		return null;
	}
	
}
