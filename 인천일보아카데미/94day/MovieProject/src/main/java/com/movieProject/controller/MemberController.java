package com.movieProject.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movieProject.Service.MemberService;
import com.movieProject.dto.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService msvc;

	@RequestMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인 페이지 이동요청 - /memberLoginForm");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberLoginForm");
		return mav;
	}

	@RequestMapping(value = "/memberLogin_kakao")
	public @ResponseBody String memberLogin_kakao(String id, HttpSession session) {
		System.out.println("카카오 로그인 요청");
		System.out.println("카카오 id : " + id);

		Member loginMember = msvc.getLoginMemberInfo_kakao(id);

		if (loginMember == null) {
			System.out.println("카카오 계정 정보 없음");
			
			return "N";
			
		} else {
			
			System.out.println("카카오 계정 정보 있음");
			System.out.println("로그인 처리");
			
			session.setAttribute("loginId", loginMember.getMid());
			session.setAttribute("loginName", loginMember.getMname());
			
			return "Y";
		}
	}
	@RequestMapping(value = "/memberJoin_kakao")
	public @ResponseBody String memberJoin_kakao(Member member){
		System.out.println("카카오 계정 - 회원가입요청 - /memberJoin_kakao");
		System.out.println(member);
		
		int result = msvc.registMember_kakao(member);
		
		return result+"";
	}
	@RequestMapping(value = "/memberJoinForm")
	public ModelAndView memberJoinForm() {
		System.out.println("로그인 페이지 이동요청 - /memberJoinForm");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberJoinForm");
		
		return mav;
	}
	@RequestMapping(value="/memberIdCheck")
	public @ResponseBody String memIdCheck(String inputId) {
		System.out.println("memberIdCheck - 호출");
		
		System.out.println("iputId : " + inputId);
		
		String checkResult = msvc.midCheck(inputId);
		
		return checkResult;
	}
	@RequestMapping(value = "/memberJoin")
	public ModelAndView memberJoin(Member mem, String memailId, String memailDomain, HttpSession session, RedirectAttributes ra)throws IllegalStateException, IOException {
		System.out.println("MemberController - /memberJoin 호출");
		ModelAndView mav = new ModelAndView();
		
		//이메일
		String memail = memailId + "@" + memailDomain;
		mem.setMemail(memail);
		mem.setMstate("DO");
		
		//회원가입 기능
			int joinResult = msvc.memJoin(mem,session);
			
			if(joinResult > 0) {
				mav.setViewName("redirect:/");
				ra.addFlashAttribute("msg", "회원가입 되었습니다.");
			}else {
				System.out.println("가입 실패");
				mav.setViewName("member/MemberJoinForm");
				ra.addFlashAttribute("msg","회원가입에 실패하였습니다.");
			}
		
		return mav;
	}
}
