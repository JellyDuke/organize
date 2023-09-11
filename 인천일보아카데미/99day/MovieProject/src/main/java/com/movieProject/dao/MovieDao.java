package com.movieProject.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Movie;
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


}
