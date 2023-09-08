package com.movieProject.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Theater;

public interface MovieDao {

	ArrayList<Movie> selectRankList();

	Movie selectDetailMovie(String mvcode);

	ArrayList<Movie> selectMovieList(String selThCode);

	ArrayList<Movie> selectReserveList();

	ArrayList<Theater> selectThReserveList(@Param("selMvcode")String selMvcode);


}
