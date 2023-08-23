package com.movieProject.dao;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Theater;

public interface AdminDao {

	String selectMaxMvCode();

	int insertMovie(Movie mov);

	String selectMaxThCode();

	int insertTheater(Theater th);
	
}
