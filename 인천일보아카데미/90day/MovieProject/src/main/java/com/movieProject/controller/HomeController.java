package com.movieProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.Service.MovieService;
import com.movieProject.dto.Movie;

@Controller
public class HomeController {
	
	@Autowired
	private MovieService mvsvc;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		
		System.out.println("메인 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		
		//1. 영화 랭킹(1~6) 목록 조회
		//SELECT * FROM MOVIES ORDER BY MVOPEN DESC;
		ArrayList<Movie> rankMovList = mvsvc.getMovieList();
		mav.addObject("rankMovList",rankMovList);
		System.out.println(rankMovList);
		
		//2. 이동 할 페이지 설정
		mav.setViewName("home");
		
		return mav;
	}
	@RequestMapping(value = "/detailMovie")
	public ModelAndView detailMovie(String mvcode) {
		System.out.println("영화 상세 정보 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		
		//1.SERVICE - 영화정보 조회 메소드 호출
		Movie mov = mvsvc.getDetailMovie(mvcode);
		System.out.println(mov);

		return mav;
	}
}
