package com.movieProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.movieProject.Service.MovieService;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Theater;

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
		Movie movie = mvsvc.getDetailMovie(mvcode);
		
		mav.addObject("movie",movie);
		mav.setViewName("movie/detailMovie");

		System.out.println(movie);
		
		return mav;
	}
	@RequestMapping(value = "/movieList")
	public ModelAndView movieList() {
		System.out.println("영화 목록 출력 페이지 이동요청");
		
		ModelAndView mav = new ModelAndView();
		ArrayList<Movie> movieList = mvsvc.getMovieList2("ALL");
		
		mav.addObject("movieList",movieList);
		mav.setViewName("movie/movieList");
		
		return mav;
	}
	@RequestMapping(value = "/reserveMovie")
	public ModelAndView reserveMovie() {
		System.out.println("영화 예매 페이지 이동요청 - /reserveMovie");
		ModelAndView mav = new ModelAndView();
		//영화 목록
		ArrayList<Movie> reserveMovie = mvsvc.getMovieList2("ALL");
		mav.addObject("reserveMovie",reserveMovie);
		
		//극장 목록
		ArrayList<Theater> reserveTheater = mvsvc.getReserveTheater("ALL");
		mav.addObject("reserveTheater",reserveTheater);
		
		mav.setViewName("movie/ReservePage");
		
		return mav;
	}
	@RequestMapping(value = "/getMovieList_json")
	public @ResponseBody String getMovieList_json(String selThCode) {
		System.out.println("예매페이지_영화 목록 조회 요청");
		
		ArrayList<Movie> movList = mvsvc.getMovieList2(selThCode);
		System.out.println(movList);
		return new Gson().toJson(movList);
	}
	@RequestMapping(value="/getTheaterList_json")
	public @ResponseBody String getTheaterList_json(String selMvcode) {
		System.out.println("예매페이지_극장 목록 조회 요청");
		System.out.println("선택한 영화 코드 : " + selMvcode);
		
		ArrayList<Theater> thList = mvsvc.getReserveTheater(selMvcode);
		System.out.println(thList);
		System.out.println(thList.size());
		return new Gson().toJson(thList) ;
	}
}
