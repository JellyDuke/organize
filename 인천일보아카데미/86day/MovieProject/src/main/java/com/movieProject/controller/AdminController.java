package com.movieProject.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.Service.AdminService;

@Controller
public class AdminController {

	@Autowired
	private AdminService adsvc;
	
	@RequestMapping(value = "/getCgvMovieInfo")
	public ModelAndView getCgvMovieInfo() throws IOException{
		System.out.println("영화정보 수집요청 - /getCgvMovieInfo");
		
		//추가된 영화 개수
		int addCount = adsvc.addCgvMovie();
		System.out.println("추가 :" + addCount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		
		return mav;
	}
	@RequestMapping(value = "/getCgvTheaterInfo")
	public ModelAndView getCgvTheaterInfo() {
		System.out.println("CGV 극장 정보 수집 요청 - /getCgvTheaterInfo");
		
		int addCount = adsvc.addCgvTheaters();
		System.out.println("추가 :" + addCount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		
		return mav;
		
	}
}
