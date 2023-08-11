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
	
	@RequestMapping(value="/busapi")
	public ModelAndView busapi() throws Exception {
		
		System.out.println("버스도착정보 페이지 이동요청 - /busapi");
		
		ModelAndView mav = new ModelAndView();
		
		// 1. 버스 도착 정보 조회
		ArrayList<Bus> result = apisvc.getBusArrive();

		mav.addObject("busList", result);
		
		// 2. 버스도착정보 페이지
		mav.setViewName("BusList"); // views/BusList.jsp
		
		return mav;
	}
	
	@RequestMapping(value="/busapi_ajax")
	public ModelAndView busapi_ajax() {
		
		System.out.println("/busapi_ajax 요청");
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("BusArriveInfo");
		
		return mav;
	}
	
	@RequestMapping(value="/getBusArr")
	public @ResponseBody String getBusArr(String nodeId) {
		
		System.out.println("버스 도착정보 조회 요청 - /getBusArr");
		System.out.println("nodeId : " + nodeId);
		
		String arrInfoList = null;
		// 1. SERVICE - 도착정보 조회 기능 호출
		try {
			arrInfoList = apisvc.getBusArrInfoList(nodeId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// 2. 도착정보 반환
		return arrInfoList;
	}
	
	@RequestMapping(value="/getBusSttn")
	public @ResponseBody String getBusSttn(String lati, String longti) {
		
		System.out.println("버스 정류소 정보 조회 요청 - getBusSttn");
		
		String BusSttnInfoList = "";
		try {
			BusSttnInfoList = apisvc.getBusSttnInfoList(lati, longti);			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return BusSttnInfoList;
	}
	
	@RequestMapping(value="/getBusNodeInfoList")
	public @ResponseBody String getBusNodeInfoList(String routeid, String cityCode) {
		
		System.out.println("버스 노선 정보 조회 요청 - getBusNodeInfoList");

		String busNodeList = "";
		
		try {
			busNodeList = apisvc.getBusNodeList(routeid, cityCode);			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return busNodeList;
	}
	
	@RequestMapping(value="/getButGpsList")
	public @ResponseBody String getButGpsInfo(String routeid, String cityCode) {
		
		System.out.println("노선 별 버스 위치 조회 요청 - getButGpsInfo");
		
		String busGpsList = "";
		
		System.out.println("노선 코드 : " + routeid);
		System.out.println("도시 코드 : " + cityCode);
		
		try {
			busGpsList = apisvc.getBusGpsInfoList(routeid, cityCode);			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return busGpsList;
	}
}
