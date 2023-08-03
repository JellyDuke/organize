package com.spring_memberBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@RequestMapping(value = "/busapi_ajax")
	public ModelAndView busapi_ajax() {
		System.out.println("/busapi_ajax 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("BusArriveInfo");
		return mav;
	}
	
	@RequestMapping(value = "/getBusArr")
	public @ResponseBody String getBusArr(String nodeId) throws IOException {
		System.out.println("버스 도착정보 조회 요청 - /getBusArr");
		System.out.println("nodeId : " + nodeId);
		//1. SERVICE - 도착정보 조회 기능 호출
		String arrInfoList = apisvc.getBusArrInfoList(nodeId);
		//2. 도착정보 반환
		return arrInfoList;
	}
	
	@RequestMapping(value = "/getBusSttn")
	public @ResponseBody String getBusSttn(String lati, String longti) throws IOException{
		System.out.println("버스 좌표 조회요청 -/getBusSttn");
		//1. SERVICE - 좌표 조회 기능 호출
		String sttnList = apisvc.getBusSttn(lati, longti);
		System.out.println("lati, longti "+ lati + longti);
		//2. 좌표 조회 반환
		return sttnList;
	}
	@RequestMapping(value = "/getBusnodeList")
	public @ResponseBody String getBusnodeList(String routeid) throws IOException{
		System.out.println("버스 전체 노선조회 -/getBusSttn");
		//1. SERVICE - 좌표 조회 기능 호출
		String getBusnodeList = apisvc.getBusnodeList(routeid);
		System.out.println("routeid "+ routeid);
		//2. 좌표 조회 반환
		return getBusnodeList;
	}
	@RequestMapping(value = "/getBusLocList")
	public @ResponseBody String getBusLocList(String routeid) throws IOException{
		System.out.println("버스 지역리스트 조회 -/getBusSttn");
		//1. SERVICE - 좌표 조회 기능 호출
		String getBusLocList = apisvc.getBusLocList(routeid);
		System.out.println("routeid "+ routeid);
		//2. 좌표 조회 반환
		return getBusLocList;
	}
}
