package com.spring_memberBoard.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.dto.Bus;
import com.spring_memberBoard.service.ApiService;

@Controller
public class ApiController {
	
	@Autowired
	private ApiService apisvc;
	
	@RequestMapping(value= "/busapi")
	public ModelAndView busapi() throws Exception {
		System.out.println("버스 도착정보 페이지 이동요청 - /busapi");
		ModelAndView mav = new ModelAndView();
		//1. 버스 도착 정보 조회
		ArrayList<Bus> result = apisvc.getBusArrive();
		mav.addObject("busList",result);
		//2. 버스 도착정보 페이지
		mav.setViewName("BusList");
		return mav;
	}
}
