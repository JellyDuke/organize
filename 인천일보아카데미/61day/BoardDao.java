package com.springProject01.dao;

import org.apache.ibatis.annotations.Insert;

import com.springProject01.dto.Board;

public interface BoardDao {
	
	int insertBoard(Board board);
}
