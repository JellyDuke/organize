package com.movieProject.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
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
	public @ResponseBody String memberLogin_kakao(String id, HttpSession session, String profile) {
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
			session.setAttribute("loginProfile", profile);
			session.setAttribute("loginState", loginMember.getMstate());
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
		mem.setMstate("YC");
		
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
			System.out.println(mem);
		
		return mav;
	}
	@RequestMapping(value = "/memberLogin")
	public ModelAndView memberLogin(@Param("userId")String userId, @Param("userPw")String userPw, HttpSession session, RedirectAttributes ra) {
		System.out.println("로그인 처리 요청 - /memberLogin");
		ModelAndView mav = new ModelAndView();
		
		System.out.println("mid : " + userId);
		System.out.println("mpw : " + userPw);
		
		Member loginMember = msvc.getLoginMemberInfo(userId, userPw);
		
		if(loginMember == null) {
			System.out.println("로그인 실패");
			ra.addFlashAttribute("msg","아이디 또는 비밀번호가 일치하지 않습니다.");
			mav.setViewName("redirect:/memberLoginForm");
		}else {
			String mstate = loginMember.getMstate().substring(0,1);
			System.out.println(mstate);
			System.out.println(mstate.equals("Y"));
			System.out.println(mstate.equals("N"));

			
			System.out.println("로그인 성공");
			session.setAttribute("loginId", loginMember.getMid());
			session.setAttribute("loginName", loginMember.getMname());
			session.setAttribute("loginProfile", loginMember.getMprofile());
			session.setAttribute("loginState", loginMember.getMstate());
			ra.addFlashAttribute("msg","로그인 성공");
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/memberLogout")
	public String memberLogout(RedirectAttributes ra, HttpSession session) {
		System.out.println("로그아웃 요청");
//		session.removeAttribute("loginId");
		session.invalidate();
		ra.addFlashAttribute("msg","로그아웃 되었습니다.");
		
		return "redirect:/";
	}
	@RequestMapping(value="/reserveList")
	public ModelAndView reserveList(HttpSession session, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		String loginId = (String) session.getAttribute("loginId");
		if(loginId == null) {
			ra.addFlashAttribute("msg","로그인 후 이용가능 합니다.");
			mav.setViewName("redirect:/memberLoginForm");
			return mav;
		}
		
		ArrayList<HashMap<String, String>> reserveList = msvc.getReserveList(loginId);
		
		mav.addObject("reserveList", reserveList);
		mav.setViewName("member/MemberReserveList");
		
		System.out.println(reserveList);
		
		return mav;
	}
	@RequestMapping(value = "/cancleReserve")
	public ModelAndView cancleReserve(String recode,RedirectAttributes ra, HttpSession session) {
		System.out.println("예매 취소 요청");
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId == null) {
			ra.addFlashAttribute("msg","로그인 후 이용가능 합니다.");
			mav.setViewName("redirect:/memberLoginForm");
			return mav;
		}
		
		int cancleReserve = msvc.getCancleReserve(recode,loginId);
		if(cancleReserve > 0) {
			ra.addFlashAttribute("msg","예매를 취소 하였습니다.");
			mav.setViewName("redirect:/MemberReserveList");
			return mav;
		}
		else {
			ra.addFlashAttribute("msg","예매를 취소 실패 하였습니다.");
			mav.setViewName("redirect:/MemberReserveList");
			return mav;
		}
	}
}
