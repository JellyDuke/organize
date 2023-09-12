package com.movieProject.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.MovieDao;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

@Service
public class MovieService {
	
	@Autowired
	private MovieDao mvdao;
	
	public ArrayList<Movie> rankMovieList() {
		System.out.println("SERVICE - getMovieList");
		
		ArrayList<Movie> rankMovieList = mvdao.selectRankList();
		
		for(Movie mov : rankMovieList) {
			String movGrade = mov.getMvinfo().split(",")[0].substring(0,2);
			//[15세이상관람가] [101분] [한국]
			if(movGrade.equals("전체")) {
				movGrade = "All";
			}else if(movGrade.equals("청소")) {
				movGrade = "18";
			}
//			else if(movGrade.equals("15세이상관람가"))
//				movGrade = "15";
			mov.setMvstate(movGrade);
		}
		
		return rankMovieList;
	}

	public Movie getDetailMovie(String mvcode) {
		System.out.println("SERVICE - getDetailMovie");
		
		return mvdao.selectDetailMovie(mvcode);
	}

	public ArrayList<Movie> getMovieList(String selThCode) {
		System.out.println("SERVICE - getMovieList");
		
		ArrayList<Movie> movieList = mvdao.selectMovieList(selThCode);
		
		for(Movie mov : movieList) {
			String movGrade = mov.getMvinfo().split(",")[0]; //.substring(0,2)
			//[15세이상관람가] [101분] [한국]
			if(movGrade.equals("전체")) {
				movGrade = "All";
			}else if(movGrade.equals("청소")) {
				movGrade = "18";
			}else if(movGrade.equals("15세이상관람가")) {
				movGrade = "15";
			}else {
				movGrade = "12";
			}
					
			mov.setMvstate(movGrade);
		}
		
		
		return movieList;
	}

	public ArrayList<Theater> getTheaterList(String selMvcode) {
		System.out.println("SERVICE - getReserveTheater");
		return mvdao.selectThReserveList(selMvcode);
	}

	public ArrayList<Schedule> getScheduleList(String mvcode, String thcode) {
		System.out.println("SERVICE - getScheduleList");
		return mvdao.selectScheduleList(mvcode, thcode);
	}
}
