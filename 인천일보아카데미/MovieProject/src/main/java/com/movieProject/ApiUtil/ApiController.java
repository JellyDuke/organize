package com.movieProject.ApiUtil;

import javax.servlet.http.HttpSession;

import org.checkerframework.checker.units.qual.m;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.movieProject.Service.ApiService;
import com.movieProject.dao.AdminDao;
import com.movieProject.dto.Reserve;

@Controller
public class ApiController {
	
	@Autowired
	private ApiService apisvc;

	@RequestMapping(value = "/kakaoPay_ready")
	public @ResponseBody String kakaopay_ready(Reserve reInfo, HttpSession session) {
		System.out.println("카카오 결제 준비 요청 - / kakaoPay_ready");
		System.out.println(reInfo);
		
		String result = apisvc.kakaoPay_ready(reInfo,session);
		
		return result;
	}
	@RequestMapping(value = "/kakaoPay_approval")
	public ModelAndView kakaoPay_approval(String pg_token, HttpSession session) {
		System.out.println("카카오 결제 승인 요청");
		
		ModelAndView mav = new ModelAndView();
		
		String tid = (String)session.getAttribute("tid");
		String recode = (String)session.getAttribute("recode");
		String loginId = (String)session.getAttribute("loginId");
		
		String result = apisvc.kakaoPay_approval(tid,pg_token); //recode, loginId

		if(result == null) {
			System.out.println("결제 오류");
			
			mav.addObject("payResult","N");
		}else {
			System.out.println("결제 승인");
			mav.addObject("payResult","Y");
		}
		session.removeAttribute("tid");
		mav.setViewName("PayResult");
		
		return mav;
	}
	@RequestMapping(value = "/kakaoPay_cancel")
	public ModelAndView kakaoPay_cancel() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("payResult","N");
		mav.setViewName("PayResult");
		return mav;
	}

}
