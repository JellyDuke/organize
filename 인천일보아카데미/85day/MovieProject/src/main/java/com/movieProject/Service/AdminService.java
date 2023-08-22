package com.movieProject.Service;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.AdminDao;
import com.movieProject.dto.Movie;

@Service
public class AdminService {
	
	@Autowired
	private AdminDao adminDao;
	
	public int addCgvMovie() throws IOException {
		System.out.println("SERVICE - addCgvMovie");
		// 1.cgv 영화 정보 수집 >> 무비차트 접속
		String movieChartUrl = "http://www.cgv.co.kr/movies/?lt=1&ft=0";

		// 1-1. cgv 문서 리턴
		Document chartDoc = Jsoup.connect(movieChartUrl).get();
		// System.out.println(movieDoc);

		// 1-2. 필요한 정보가 있는 부분 선택
		Elements urlItems = chartDoc.select("div.sect-movie-chart  div.box-image > a");

		// 배열 생성
		ArrayList<Movie> movieList = new ArrayList<Movie>();

		// 2.영화 상세 페이지 URL 정보 수집
		for (Element urlItem : urlItems) {
			// 3.영화 상세 페이지 접속>> 영화 상세 정보 수집
			String detailUrl = "https://www.cgv.co.kr" + urlItem.attr("href");
			Document detailDoc = Jsoup.connect(detailUrl).get();

			Movie movie = new Movie();

			String mvtitle = detailDoc.select("div.box-contents > div.title > strong").text();
			System.out.println("영화제목: " + mvtitle);
			movie.setMvtitel(mvtitle);

			String mvdirector = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd:nth-child(2)")
					.text();
			System.out.println("영화감독: " + mvdirector);
			movie.setMvdirector(mvdirector);

			String mvactors = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0)
					.text().replace(" , ", ", ");
			System.out.println("영화배우: " + mvactors);
			movie.setMvactors(mvactors);

			String mvgenre = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0)
					.nextElementSibling().text().replace("장르 : ", "").trim();// 공백제거
			System.out.println("영화장르: " + mvgenre);
			movie.setMvgenre(mvgenre);

			String mvinfo = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(1)
					.text();
			System.out.println("영화기본내용: " + mvinfo);
			movie.setMvinfo(mvinfo);

			String mvopen = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(2)
					.text().substring(0, 10);// 0번 인덱스부터 10번 인덱스까지 자르기
			System.out.println("영화개봉: " + mvopen);
			movie.setMvopen(mvopen);

			String mvposter = detailDoc.select("#select_main > div.sect-base-movie > div.box-image > a > span > img")
					.attr("src");
			System.out.println("영화포스터: " + mvposter);
			movie.setMvposter(mvposter);

			System.out.println();

			//movieList >> 영화정보 19개
			movieList.add(movie);
		}
		//DB - MOVIES 테이블 INSERT
		//MOVIES 테이블 MVCODE 최대값 조회
		
		String maxMvcode = adminDao.selectMaxMvCode();
		System.out.println("maxMvcode: " + maxMvcode);
		
		int insertCount = 0;
		for(Movie mov : movieList) {
			
			//1. 영화코드 생성
			
			
			//2. MOVIES 테이블 INSERT
			
			insertCount++;
		}
		
		return 0;
	}

}
