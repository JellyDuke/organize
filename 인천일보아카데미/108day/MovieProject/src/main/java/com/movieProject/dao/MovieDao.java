package com.movieProject.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Review;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

public interface MovieDao {
	//영화 인기 순위 조회
	ArrayList<Movie> selectRankList();
	//영화 상세정보 조회
	Movie selectDetailMovie(String mvcode);
	//영화 목록 조회
	ArrayList<Movie> selectMovieList(String selThCode);
	//극장 목록 조회
	ArrayList<Theater> selectThReserveList(@Param("selMvcode")String selMvcode);
	//스케쥴 목록 조회
	ArrayList<Schedule> selectScheduleList(@Param("mvcode")String mvcode, @Param("thcode")String thcode);
	//스케쥴 시간 목록 조회
	ArrayList<Schedule> selectgetSchduleTimeList(@Param("mvcode")String mvcode,  @Param("thcode")String thcode, @Param("scdate")String scdate);
	//예매 코드 
	String selectMaxRecode();
	
	//예매 목록 끼워넣기
	int insertReserveInfo(@Param("reinfo")Reserve reinfo);
	
	//리뷰 코드
	String selectMaxRVCODE();
	//리뷰 인서트
	int insertReviewInfo(Review review);
	//리뷰 조회
	ArrayList<HashMap<String, String>> selectRvList(String mvcode);


}
