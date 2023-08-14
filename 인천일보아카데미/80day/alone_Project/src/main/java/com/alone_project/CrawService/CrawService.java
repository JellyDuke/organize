package com.alone_project.CrawService;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class CrawService {
	public ArrayList<HashMap<String, String>> getOliveRankItem() throws IOException {
		System.out.println("올리브영 랭킹 아이템 수집 기능 호출");
		
		//Jsoup 파이썬은 뷰티풀soup사용
		//1.https://www.oliveyoung.co.kr/store/main/getBestList.do 접속
		String oliveRankUrl = "https://www.oliveyoung.co.kr/store/main/getBestList.do";
		
		//2. 랭킹 페이지 문서 리턴 <HTML> ~ </HTML>
		Document oliveRankDoc = Jsoup.connect(oliveRankUrl).get();
//		System.out.println(oliveRankDoc);
		
		//3. 필요한 정보가 있는 부분 선택 ( css 선택자 )
		Elements itemsDiv = oliveRankDoc.select("div.TabsConts");
		
		Elements items = itemsDiv.get(0).select("ul.cate_prd_list li");
		System.out.println(items.get(1));
		System.out.println(items.size());
		
		//4. 데이터 수집
		// 브랜드명, 상품이름, 상품가격, 상품이미지, 리뷰수
		// 상품리뷰수 : 상품 상세페이지 이동 >> 리뷰수 수집
		ArrayList<HashMap<String, String>> prdList = new ArrayList<HashMap<String,String>>();
		
		for(int i = 0; i<items.size(); i++) {
		HashMap<String, String> prd_map = new HashMap<String, String>();
			
		String imgUrl = items.get(i).select("div.prd_info>a>img").attr("src");
		prd_map.put("prdImg", imgUrl);
		System.out.println("상품 이미지 : " + imgUrl);
		
		String brandName = items.get(i).select(("span.tx_brand")).text();
		prd_map.put("prdBrd",brandName);
		System.out.println("브랜드명: " + brandName);
		
		String prdName =  items.get(i).select(("p.tx_name")).text();
		prd_map.put("prdName",prdName);
		System.out.println("상품명: "+prdName);
		
		String prdPrice = items.get(i).select(("span.tx_cur>span")).text();
		prd_map.put("prdPrice",prdPrice);
		System.out.println("상품가격: " +prdPrice);
		
		// 상세 페이지 URL
		String detailUrl = items.get(i).select("div.prd_info>a").attr("href");
		// 상세 페이지 Document
		Document detailDoc = Jsoup.connect(detailUrl).get();
		//#repReview > em
		String reviewCount = detailDoc.select("#repReview > em").text();

		reviewCount = reviewCount.replace("(", "").replace(")", "");
		prd_map.put("prdRev",reviewCount);
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
		//5. DB에 저장
		}
}
