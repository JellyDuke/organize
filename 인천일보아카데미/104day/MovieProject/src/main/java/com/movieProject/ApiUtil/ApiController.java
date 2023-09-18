package com.movieProject.ApiUtil;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.Service.ApiService;
import com.movieProject.dto.Reserve;

@Controller
public class ApiController {
	
	@Autowired
	private ApiService apisvs;

	@RequestMapping(value = "/kakaoPay_ready")
	public @ResponseBody String kakaopay_ready(Reserve reInfo, HttpSession session) {
		System.out.println("카카오 결제 준비 요청 - / kakaoPay_ready");
		System.out.println(reInfo);
		
		String result = apisvs.kakaoPay_ready(reInfo,session);
		
		return result;
	}
	@RequestMapping(value = "/kakaoPay_approval")
	public ModelAndView kakaoPay_approval(String pg_token,HttpSession session) {
		System.out.println("카카오 결제 승인 요청");
		System.out.println("pg : " + pg_token);
		String tid = (String)session.getAttribute("tid");
		System.out.println("tid: " + tid);
		return null;
	}
}
