package com.movieProject.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

public interface AdminDao {

	String selectMaxMvCode();

	int insertMovie(Movie mov);

	String selectMaxThCode();

	int insertTheater(Theater th);

	int insertSchedule(Schedule sc);

	ArrayList<Movie> selectMapperTest(String thcode);

	int failReserve(@Param("recode")String recode, @Param("loginId")String loginId);
	
}
