package com.alone_project.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alone_project.CrawService.CrawService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@Autowired
	private CrawService csvc;
	
	@RequestMapping(value = "/olive")
	public ModelAndView olive()throws IOException {
		ModelAndView mav = new ModelAndView();
		System.out.println("올리브영");
		ArrayList<HashMap<String, String>> prdList = csvc.getOliveRankItem();
		
		mav.addObject("prdList",prdList);
		mav.setViewName("OliveBest"); //OliveBest.jsp
		
		return mav;
	}
	@RequestMapping(value = "/prdSearch")
	public ModelAndView prdSearch(String searchText)throws IOException {
		System.out.println("CONTROLLER - prdSearch");
		ModelAndView mav = new ModelAndView();
		System.out.println("searchText : " + searchText);
		
//		ArrayList <HashMap<String, String>> prdList_list = csvc.getPrdList_11st(searchText);
		
		ArrayList <HashMap<String, String>> prdList_coupang = csvc.getPrdList_coopang(searchText);
		mav.addObject("prdList_coupang",prdList_coupang);
		
		ArrayList <HashMap<String, String>> prdList_gmarket = csvc.getPrdList_gmarket(searchText);
		mav.addObject("prdList_gmarket",prdList_gmarket);
		
		mav.setViewName("PrdSearchResult");//PrdSearchResult.jsp
		
		return mav;
	}
}
