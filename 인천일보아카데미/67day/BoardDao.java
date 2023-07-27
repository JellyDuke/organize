package com.spring_memberBoard.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

public interface BoardDao {
	
//	@Select("SELECT NVL(MAX(BNO),0) FROM BOARDS")
	int selectbno();

	int insertBoard(@Param("board")Board board);

	Board selectBoard(@Param("bno")int bno);

	ArrayList<Board> selectBoardList();

	
	
	int selectMaxRenum();

	int insertReply(@Param("re")Reply re);

}
