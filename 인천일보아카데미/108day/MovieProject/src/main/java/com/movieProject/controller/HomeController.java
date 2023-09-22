package com.movieProject.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.movieProject.Service.MovieService;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Review;
import com.movieProject.dto.Schedule;
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
		ArrayList<Movie> rankMovList = mvsvc.rankMovieList();
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
		
		//2.SERVICE - 관람평 목록 조회
		ArrayList<HashMap<String, String>> reviewList = mvsvc.getReviewList(mvcode);
		System.out.println(reviewList);
		
		mav.addObject("reviewList",reviewList);
		mav.setViewName("movie/detailMovie");

		System.out.println(movie);
		
		return mav;
	}
	
	@RequestMapping(value = "/movieList")
	public ModelAndView movieList() {
		System.out.println("영화 목록 페이지 이동요청");
		
		ModelAndView mav = new ModelAndView();
		ArrayList<Movie> movieList = mvsvc.getMovieList("ALL");
		
		mav.addObject("movieList",movieList);
		mav.setViewName("movie/movieList");
		
		return mav;
	}
	
	@RequestMapping(value = "/reserveMovie")
	public ModelAndView reserveMovie() {
		System.out.println("영화 예매 페이지 이동요청 - /reserveMovie");
		ModelAndView mav = new ModelAndView();
		
		//예매 가능한 영화 목록
		ArrayList<Movie> movList = mvsvc.getMovieList("ALL");
		mav.addObject("movList",movList);
		
		//예매 가능한 극장 목록
		ArrayList<Theater> thList = mvsvc.getTheaterList("ALL");
		mav.addObject("thList",thList);
		
		mav.setViewName("movie/ReservePage");
		
		return mav;
	}
	
	@RequestMapping(value = "/getMovieList_json")
	public @ResponseBody String getMovieList(String selThCode) {
		System.out.println("예매페이지_영화 목록 조회 요청");
		
		ArrayList<Movie> movList = mvsvc.getMovieList(selThCode);
		System.out.println(movList);
		return new Gson().toJson(movList);
	}
	
	@RequestMapping(value="/getTheaterList_json")
	public @ResponseBody String getTheaterList(String selMvcode) {
		System.out.println("예매페이지_극장 목록 조회 요청");
		System.out.println("선택한 영화 코드 : " + selMvcode);
		
		ArrayList<Theater> thList = mvsvc.getTheaterList(selMvcode);
		return new Gson().toJson(thList) ;
	}
	
	@RequestMapping(value = "/getSchduleDateList_json")
	public @ResponseBody String getSchduleDateList_json(String mvcode, String thcode) {
		System.out.println("예매페이지_예매 날짜 조회 요청");
		System.out.println("선택된 코드 : " + mvcode + " : " + thcode);
		
		ArrayList<Schedule> schList = mvsvc.getScheduleList(mvcode, thcode);
		return new Gson().toJson(schList);
	}
	@RequestMapping(value = "/getSchduleTimeList_json")
	public @ResponseBody String getSchduleTimeList_json(String mvcode, String thcode, String scdate) {
		System.out.println("예메페이지_예매 시간 조회 요청");
		ArrayList<Schedule> schList = mvsvc.getSchduleTimeList(mvcode, thcode, scdate);
		return new Gson().toJson(schList);
	}
	
	@RequestMapping(value = "/registReserveInfo")
	public @ResponseBody String registReserveInfo(Reserve reinfo, HttpSession session) {
		System.out.println("예매 처리 요청 - /registReserveInfo");
		System.out.println(reinfo);
		
		String loginId = (String) session.getAttribute("loginId");

		if(loginId == null) {
			return "login";
		}else {
			reinfo.setMid(loginId);
			String registResult = mvsvc.registReserveInfo(reinfo);
			return registResult; //null || 예매코드
		}
	}
	@RequestMapping(value="/registReview")
	public ModelAndView registReview(String recode, String rvcomment, HttpSession session, RedirectAttributes ra) {
		System.out.println("관람평 등록 요청 - /registReview");
		ModelAndView mav= new ModelAndView();
		Review review = new Review();
		
		String mid = (String)session.getAttribute("loginId");
		review.setMid(mid);
		review.setRecode(recode);
		review.setRvcomment(rvcomment);
		
		int result = mvsvc.registReview(review, session);
		
		if(result > 0 ){
			System.out.println("등록 성공");
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","작성 성공");
		}else {
			System.out.println("등록 실패");
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","작성 실패");
		}
		
		System.out.println(review);
		
		return mav;
	}
	
	@RequestMapping(value = "/reviewWriteForm")
	public ModelAndView reviewWriteForm(String recode) {
		System.out.println("관람평 작성 페이지 이동요청 -/reviewWriteForm");
		ModelAndView mav = new ModelAndView();
//		관람한 영화 정보 조회 
		
		mav.setViewName("movie/ReviewWriteForm");
		return mav;
	}
}
