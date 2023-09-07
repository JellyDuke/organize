package com.movieProject.dao;

import java.util.ArrayList;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Theater;

public interface MovieDao {

	ArrayList<Movie> selectRankList();

	Movie selectDetailMovie(String mvcode);

	ArrayList<Movie> selectMovieList();

	ArrayList<Movie> selectReserveList();


	ArrayList<Theater> selectThReserveList();

}
