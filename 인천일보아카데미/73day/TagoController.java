package com.spring_memberBoard.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.service.TagoService;

@Controller
public class TagoController {
	
	@Autowired
	private TagoService tagosvc;
	
	@RequestMapping(value = "/tagoBus")
	public ModelAndView tagoBus() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("TagoBus");
		return mav;
	}
	@RequestMapping(value = "/getTagoSttnList")
	public @ResponseBody String getTagoSttnList(String lati, String longti) throws IOException{
		System.out.println("정류소 목록 조회 요청 - /getTagoSttnList 요청");
		System.out.println(lati+ " : " + longti);
		//SERVICE - 국토교통부_(TAGO)_버스정류소정보 조회 기능 요청
		String result = tagosvc.getBusSttnList(lati, longti);
		return result;
	}
	@RequestMapping(value = "/getTagoBusArrList")
	public @ResponseBody String getTagoBusArrList(String citycode, String nodeid) throws IOException{
		System.out.println("버스 도착 예정 정보 조회 요청 - /getTagoBusArrList");
		System.out.println(citycode+" : "+nodeid);
		
		//SERVICE - 국토교통부_(TAGO)_버스도착정보 조회 요청
		String result = tagosvc.getBusArrList(citycode, nodeid);
		return result;
	}
} 
