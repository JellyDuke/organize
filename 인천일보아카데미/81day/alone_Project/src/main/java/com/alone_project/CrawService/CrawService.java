package com.alone_project.CrawService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class CrawService {
	public ArrayList<HashMap<String, String>> getOliveRankItem() throws IOException {
		System.out.println("올리브영 랭킹 아이템 수집 기능 호출");

		// Jsoup 파이썬은 뷰티풀soup사용
		// 1.https://www.oliveyoung.co.kr/store/main/getBestList.do 접속
		String oliveRankUrl = "https://www.oliveyoung.co.kr/store/main/getBestList.do";

		// 2. 랭킹 페이지 문서 리턴 <HTML> ~ </HTML>
		Document oliveRankDoc = Jsoup.connect(oliveRankUrl).get();
//		System.out.println(oliveRankDoc);

		// 3. 필요한 정보가 있는 부분 선택 ( css 선택자 )
		Elements itemsDiv = oliveRankDoc.select("div.TabsConts");
		Elements items = itemsDiv.get(0).select("ul.cate_prd_list li");
		System.out.println(items.get(1));
		System.out.println(items.size());

		// 4. 데이터 수집
		// 브랜드명, 상품이름, 상품가격, 상품이미지, 리뷰수
		// 상품리뷰수 : 상품 상세페이지 이동 >> 리뷰수 수집
		ArrayList<HashMap<String, String>> prdList = new ArrayList<HashMap<String, String>>();

		for (int i = 0; i < items.size(); i++) {
			HashMap<String, String> prd_map = new HashMap<String, String>();

			String imgUrl = items.get(i).select("div.prd_info>a>img").attr("src");
			prd_map.put("prdImg", imgUrl);
			System.out.println("상품 이미지 : " + imgUrl);

			String brandName = items.get(i).select(("span.tx_brand")).text();
			prd_map.put("prdBrd", brandName);
			System.out.println("브랜드명: " + brandName);

			String prdName = items.get(i).select(("p.tx_name")).text();
			prd_map.put("prdName", prdName);
			System.out.println("상품명: " + prdName);

			String prdPrice = items.get(i).select(("span.tx_cur>span")).text();
			prd_map.put("prdPrice", prdPrice);
			prdPrice = prdPrice.replace(",","");
			System.out.println("상품가격: " + prdPrice);

			// 상세 페이지 URL
			String detailUrl = items.get(i).select("div.prd_info>a").attr("href");
			// 상세 페이지 Document
			Document detailDoc = Jsoup.connect(detailUrl).get();
			// #repReview > em
			String reviewCount = detailDoc.select("#repReview > em").text();

			reviewCount = reviewCount.replace("(", "").replace(")", "");
			prd_map.put("prdRev", reviewCount);
			System.out.println("리뷰 수 : " + reviewCount);

			prdList.add(prd_map);

		}
		return prdList;

//		for(Element item : items) {
//			System.out.println(item.select("div.prd_info>a>img"));
//			String imgUrl = item.select("div.prd_info>a>img").attr("src");
//			System.out.println("상품 이미지: " + imgUrl);
//			
//			String brandName = item.select(("span.tx_brand")).text();
//			System.out.println("브랜드명: " + brandName);
//			
//			String prdName =  item.select(("p.tx_name")).text();
//			System.out.println("상품명: "+prdName);
//			
//			String prdPrice = items.select(("span.tx_cur>span")).text();
//			System.out.println("상품가격: " +prdPrice);

//			System.out.println(items.select("div.prd_info>a").attr("href"));
//		}
		// 5. DB에 저장
	}

	public ArrayList<HashMap<String, String>> getPrdList_11st(String searchText) throws IOException {
		System.out.println("SERVICE - getPrdList_11st()");
		// 접속할 페이지 url
		// https://search.11st.co.kr/Search.tmall?kwd=keyboard

		// String connectUrl = "https://search.11st.co.kr/Search.tmall?kwd="+searchText;
		// Document targetPage = Jsoup.connect(connectUrl).get();

		String connectUrl = "https://search.11st.co.kr/Search.tmall";
		HashMap<String, String> paramList = new HashMap<String, String>();
		paramList.put("kwd", searchText);

		Document targetPage = Jsoup.connect(connectUrl).data(paramList).get();
		System.out.println(targetPage.select("section.search_section"));

		return null;
	}

	public ArrayList<HashMap<String, String>> getPrdList_coopang(String searchText) throws IOException {
		System.out.println("SERVICE - getPrdList_coopang()");
		// 접속할 페이지 url
		// https://www.coupang.com/np/search?component=keyboard&channel=user
		String connectUrl = "https://www.coupang.com/np/search";
		HashMap<String, String> paramList = new HashMap<String, String>();

		paramList.put("cpmponent", "");
		paramList.put("q", searchText);
		paramList.put("channel", "user");

		Document targetPage = Jsoup.connect(connectUrl).data(paramList).cookie("auth", "token").get();

		Elements items = targetPage.select("li.search-product");

//		System.out.println(items);
		System.out.println(items.size());

		ArrayList<HashMap<String, String>> prdList_coupang = new ArrayList<HashMap<String, String>>();
		// 상품이름 , 상품가격 수집, 상세페이지 url
		for (int i = 0; i < items.size(); i++) {
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			// 상품 이름
			String prdName = items.get(i).select(("div.name")).text();
			prdInfo.put("prdName", prdName);
			System.out.println("상품명: " + prdName);
			
			// 상품 가격
			String prdPrice = items.get(i).select(("strong.price-value")).text();
			prdPrice = prdPrice.replace(",","");
			prdInfo.put("prdPrice", prdPrice);
			System.out.println("상품가격: " + prdPrice);
			
			// 상세 페이지
			String prdUrl =items.get(i).select(("a")).attr("href");
			prdUrl = "https://www.coupang.com"+ prdUrl;
			prdInfo.put("prdUrl", prdUrl);
			System.out.println("상세페이지: " + prdUrl);
			
			prdInfo.put("prdSite", "coupang");
			
			//상품을 가격 순 정렬(높은 가격 ~ 낮은 가격)
			
			//prdList_coupang에 추가할 인덱스 번호
			int idx = -1; 
			
			String sortOption = "PRICE_DESC"; //PRICE_ASC 정렬 옵션
			
			for(int j = 0; j < prdList_coupang.size(); j++) {
				int prdPrice_int = Integer.parseInt(prdPrice);
				int listPrice = Integer.parseInt(prdList_coupang.get(j).get("prdPrice"));
				
				boolean sortType = true;
				switch (sortOption) {
				case "PRICE_DESC":
					sortType = prdPrice_int > listPrice;
					break;

				case "PRICE_ASC":
					sortType = prdPrice_int < listPrice;
					break;
				}
				
				if(sortType) {
					idx = j;
					break;
				}
				
				
//				if(prdPrice_int > listPrice) {	
//					idx = j;
//					break;
//				}
			}
			
			if(idx>-1) {
				prdList_coupang.add(idx,prdInfo);
			}else {
				prdList_coupang.add(prdInfo);
			}
			
			
//			prdList_coupang.add(prdInfo);
		}
		
//		for (org.jsoup.nodes.Element item : items) {
//		HashMap<String, String> prdInfo = new HashMap<String, String>();
//			// 상품 이름
//			String prdName = items.select(("div.descriptions-inner>div.name")).text();
//			prdInfo.put("prdName", prdName);
//			System.out.println("상품명: " + prdName);
//			// 상품 가격
//			String prdPrice = items.select(("div.descriptions-inner>strong.price-area>strong.price-value")).text();
//			prdInfo.put("prdPrice", prdPrice);
//			prdPrice = prdPrice.replace(",",""); //48,000 >> 48000
//			System.out.println("상품가격: " + prdPrice);
//			// 상세 페이지
//			String detailurl =items.select(("a")).attr("href");
//			detailurl = "https://www.coupang.com"+ detailurl;
//			prdInfo.put("detailurl", detailurl);
//			prdInfo.put("prdSite","coopang");
//			System.out.println("상세페이지: " + detailurl);
//			prdList_coopang.add(prdInfo);
//		}
		return prdList_coupang;
	}

	public ArrayList<HashMap<String, String>> getPrdList_gmarket(String searchText)throws IOException {
		System.out.println("SERVICE - getPrdList_gmarket()");
		//접속할 페이지
		//https://browse.gmarket.co.kr/search?keyword=keyboard
		String connectUrl = "https://browse.gmarket.co.kr/search";
		HashMap<String, String> paramList = new HashMap<String, String>();
		
		paramList.put("keyword", searchText);
		Document targetPage = Jsoup.connect(connectUrl).data(paramList).get();
		
		Elements items = targetPage.select("div.box__component-itemcard	");
		
		ArrayList<HashMap<String, String>> prdList_gmarket = new ArrayList<HashMap<String, String>>();
//		for(int i = 0; i < items.size(); i++) {
//			HashMap<String, String> prdInfo = new HashMap<String, String>();
//			//상품이름
//			String prdName = items.get(i).select(("div.box__item-title span.text__item")).text();
//			prdInfo.put("prdName", prdName);
//			System.out.println("상품명: " + prdName);
//			
//			//삼품가격
//			String prdPrice = items.get(i).select(("div.box__price-seller strong.text__value")).text();
//			prdInfo.put("prdPrice", prdPrice);
//			System.out.println("상품가격: " + prdPrice);
//			
//			//상품 상세 페이지 
//			String prdUrl = items.get(i).select(("a.link__item")).attr("href");
//			prdInfo.put("prdUrl", prdUrl);
//			System.out.println("상세페이지: " + prdUrl);
//			
//			prdList_gmarket.add(prdInfo);
//		}
		for(Element item : items) {
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			//상품이름
			String prdName = item.select(("div.box__item-title span.text__item")).text();
			prdInfo.put("prdName", prdName);
			System.out.println("상품명: " + prdName);
			
			//삼품가격
			String prdPrice = item.select(("div.box__price-seller strong.text__value")).text();
			prdPrice = prdPrice.replace(",","");
			prdInfo.put("prdPrice", prdPrice);
			System.out.println("상품가격: " + prdPrice);
			
			//상품 상세 페이지 
			String prdUrl = item.select(("a.link__item")).attr("href");
			prdInfo.put("prdUrl", prdUrl);
			System.out.println("상세페이지: " + prdUrl);
			
			prdList_gmarket.add(prdInfo);
		}
		return prdList_gmarket;
	}
}
