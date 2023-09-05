package com.movieProject.dao;

import java.util.ArrayList;

import com.movieProject.dto.Movie;

public interface MovieDao {

	ArrayList<Movie> selectRankList();

	Movie selectDetailMovie(String mvcode);

	ArrayList<Movie> selectMovieList();

}
