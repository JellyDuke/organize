package com.movieProject.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.PageLoadStrategy;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.AdminDao;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

@Service
public class AdminService {

	@Autowired
	private AdminDao adminDao;

	// addCgvMovies() 시작
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
			movie.setMvtitle(mvtitle);

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

			// movieList >> 영화정보 19개
			movieList.add(movie);

		}

		// DB - MOVIES 테이블 INSERT

		// MOVIES 테이블 MVCODE 최대값 조회
		String maxMvcode = adminDao.selectMaxMvCode();

		System.out.println("maxMvcode: " + maxMvcode);// MV00000
		int insertCount = 0;

		for (Movie mov : movieList) {
			// 1. 영화코드 생성
			String mvcode = genCode(maxMvcode);

			// System.out.println("mvcode : " + mvcode);// MV00001

			mov.setMvcode(mvcode);
			System.out.println(mov);

			// 2. MOVIES 테이블 INSERT
			try {

				int insertResult = adminDao.insertMovie(mov);
				insertCount += insertResult;
				maxMvcode = mvcode;

			} catch (Exception e) {
				continue; // 중복 영화 일 경우 다음 반복
			}
		}

		return insertCount;
	}
	// addCgvMovies()종료

	// 코드 생성 메소드 시작
	private String genCode(String currentCode) {
		System.out.println("genCode() 호출 : " + currentCode);
		// currentCode = MV00000 :: 앞2자리 영문, 뒤 5자리 숫자

		String strCode = currentCode.substring(0, 2); // "MV00000" >> "MV" 0,1번까지
		int numCode = Integer.parseInt(currentCode.substring(2)); // "MV00000 >> 00000" 0,1번인덱스부터

		String newCode = strCode + String.format("%05d", numCode + 1);
		// MV + 00000+1
		return newCode;

	}

	public ArrayList<String> getTheatersUrls() {
		System.out.println("AdminService - getTheatersUrls 호출");

		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		// options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);

		String cgvtheaterUrl = "http://www.cgv.co.kr/theaters/";
		driver.get(cgvtheaterUrl);

		List<WebElement> theaterElements = driver.findElements(By.cssSelector("div.sect-city>ul>li>div.area>ul>li>a"));

		ArrayList<String> thUrls = new ArrayList<String>();

		for (WebElement theaterElement : theaterElements) {
			thUrls.add(theaterElement.getAttribute("href"));
		}

		driver.quit();
		return thUrls;

	}

	public int addCgvTheaters() {
		System.out.println("AdminService - addCgvTheaters 호출");

		// 극장 페이지 URL 수집 기능 호출
		ArrayList<String> theaterUrls = getTheatersUrls();
		System.out.println(theaterUrls.size());

		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		// options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);

		ArrayList<Theater> thList = new ArrayList<Theater>();

		for (String url : theaterUrls) {
			driver.get(url);

			try {
				Theater th = new Theater();
				WebElement titleElement = driver
						.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"));
				String thname = titleElement.getText();
				th.setThname(thname);
				System.out.println("극장: " + thname);

				WebElement addrElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > strong"));
				String thaddr = addrElement.getText();
				thaddr = thaddr.replace("위치/주차 안내 >", "");
				thaddr = thaddr.split("\n")[0];
				th.setThaddr(thaddr);
				System.out.println("주소 : " + thaddr);

				WebElement thtelElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(1)"));
				String thtel = thtelElement.getText();
				th.setThtel(thtel);
				System.out.println("전화번호 : " + thtel);

				WebElement thinfoElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(2)"));
				String thinfo = thinfoElement.getText();
				th.setThinfo(thinfo);
				System.out.println("기본정보 : " + thinfo);

				WebElement thimgElement = driver.findElement(By.cssSelector("#theater_img_container > img"));
				String thimg = thimgElement.getAttribute("src");
				th.setThimg(thimg);
				System.out.println("이미지 : " + thimg);
				System.out.println();

				thList.add(th);

			} catch (Exception e) {

				continue;

			}

		}
		// cgv 극장정보 202개 수집
		System.out.println(thList.size());

		// DB -THEATERS 테이블 INSERT
		String maxThcode = adminDao.selectMaxThCode();

		// THEATERS 테이블 THCODE 최대값 조회 >> TH00000
		int insertCount = 0;

		for (Theater theater : thList) {
			String thcode = genthCode(maxThcode);
			theater.setThcode(thcode);
			System.out.println(theater);

			try {
				int insertResult = adminDao.insertTheater(theater);
				insertCount += insertResult;
				maxThcode = thcode;

			} catch (Exception e) {
				continue;
			}
		}

		driver.quit();

		return insertCount;

	}

	private String genthCode(String currentCode) {
		System.out.println("genCode() 호출 : " + currentCode);
		// currentCode = TH00000 :: 앞2자리 영문, 뒤 5자리 숫자

		String strCode = currentCode.substring(0, 2); // "TH00000" >> "TH" 0,1번까지
		int numCode = Integer.parseInt(currentCode.substring(2)); // "TH00000 >> 00000" 0,1번인덱스부터

		String newCode = strCode + String.format("%05d", numCode + 1);
		// Th + 00000+1
		return newCode;
	}

	public int addCgvSchedules() {
		System.out.println("AdminService - addCgvSchedules() 호출");

		// 극장 페이지 URL 수집 기능 호출
		ArrayList<String> theaterUrls = getTheatersUrls();

		// SELENIUM 옵션
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		// options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);

		
		ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
		
		for (String thurl : theaterUrls) { // 극장 - for문 시작

			// SELENIUM - Chrom 극장 페이지로 접속
			driver.get(thurl);

			try { // 극장별 스케쥴 수집 - try문 시작

				// SELENIUM - 극장페이지 내부에 있는 스케쥴 프레임으로 변경
				String thname = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span")).getText();
				System.out.println("극장 : " + thname);

				driver.switchTo().frame(driver.findElement(By.cssSelector("#ifrm_movie_time_table")));

				// SELENIUM - 예약 가능 날짜 목록 수집
				List<WebElement> dayList = driver.findElements(By.cssSelector("#slider > div:nth-child(1) > ul > li"));

				for (int i = 0; i < dayList.size(); i++) { // 날짜별 스케쥴 수집 - for문 시작
					if (i > 0) {

						driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on+li")).click();

					}

					String mm = driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > span")).getText().replace("월", "");
					String dd = driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > strong")).getText();
					System.out.println(mm + "월 " + dd + "일");

					// showtimes : 상영스케쥴표 영화 목록
					List<WebElement> showtimes = driver.findElements(By.cssSelector("div.sect-showtimes > ul > li"));

					for (WebElement showtime : showtimes) { // 영화별 스케쥴 수집 - for문 시작

						// 예매 가능한 영화 제목
						String mvtitle = showtime.findElement(By.cssSelector("div > div.info-movie > a > strong")).getText();

						// 예매 가능한 상영관
						List<WebElement> type_Halls = showtime.findElements(By.cssSelector("div.col-times > div.type-hall"));

						for(WebElement hall : type_Halls) {
							
							//예매 가능한 상영관 이름
							String hallName = hall.findElement(By.cssSelector("div.info-hall > ul > li:nth-child(2)")).getText();
							System.out.println("상영관 : " + hallName);
							
							//예매 가능한 시간 리스트
							//div.info-timetable > ul > li:nth-child(1) > a > em
							List<WebElement> timeList = hall.findElements(By.cssSelector("div.info-timetable > ul > li > a > em"));
							
							for(WebElement time : timeList) {
								
								//예매 가능한 시간
								String hallTime = time.getText();
								System.out.println(thname + " : " + mm + dd + " : " + mvtitle + " : " + hallName + " : " + hallTime);
							
								//데이터 저장하기
								Schedule schedule = new Schedule();
								schedule.setMvcode(mvtitle); 	//영화 이름
								schedule.setThcode(thname);  	//cgv이름
								schedule.setSchall(hallName);	//몇호관
								schedule.setScdate("2023"+mm+dd+" "+hallTime); //상영 시간
								scheduleList.add(schedule);
							}
						}
						
					} // 영화별 스케쥴 수집 - for문 끝

					System.out.println();
					
				} // 날짜별 스케쥴 수집 - for문 끝

			} catch (Exception e) {
				
				continue;
				
			} // try - catch 끝

		} // 극장 - for문 끝

		System.out.println(scheduleList.size());
		//insert
		int insertCount = 0;
		
		for(Schedule sc : scheduleList) {
			try {
				
				int insertResult = adminDao.insertSchedule(sc);
				insertCount += insertResult;

			} catch (Exception e) {

				continue;

			}
		}
		
		driver.quit(); // SELENIUM - CHROM 종료
		return insertCount;
	}
	
	public void mapperTest_Movie(String thcode) {
		System.out.println("SERVICE ");
		ArrayList<Movie> movList = adminDao.selectMapperTest(thcode);
		System.out.println("극장선택O: "+movList.size());
		
		ArrayList<Movie> movList2 = adminDao.selectMapperTest(null);
		System.out.println("극장선택X: "+movList2.size());
	}
}
