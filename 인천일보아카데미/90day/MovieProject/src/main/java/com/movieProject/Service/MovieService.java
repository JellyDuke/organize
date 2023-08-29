package com.movieProject.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.MovieDao;
import com.movieProject.dto.Movie;

@Service
public class MovieService {
	
	@Autowired
	private MovieDao mvdao;
	
	public ArrayList<Movie> getMovieList() {
		System.out.println("SERVICE - getMovieList");
		
		ArrayList<Movie> rankMovieList = mvdao.selectRankList();
		
		return rankMovieList;
	}

	public Movie getDetailMovie(String mvcode) {
		System.out.println("SERVICE - getDetailMovie");
		
		return mvdao.selectDetailMovie(mvcode);
	}

}
