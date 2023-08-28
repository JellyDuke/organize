package com.movieProject.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		System.out.println("메인 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		//1. 영화 랭킹(1~6) 목록 조회
		//ArrayList<Movie> rankMovList = .....
		//mav.addObject("","");
		//2. 이동 할 페이지 설정
		mav.setViewName("home");
		return mav;
	}
}
