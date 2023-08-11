package com.spring_memberBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

public interface BoardDao {

	int getMaxBno();

	int insertBoard(@Param("board") Board board);

	Board selectBoard(@Param("bno") int bno);

	void updatebhits(@Param("bno") int bno);

	ArrayList<Board> selectBoardList();

	int selectMaxRenum();

	int insertReply(@Param("re") Reply re);

	ArrayList<Reply> selectReplyList(@Param("rebno") int rebno);

	int deleteReply(@Param("renum") int renum);

	ArrayList<Board> selectTotalBoard(@Param("memId") String memId);

	ArrayList<Reply> selectTotalReply(@Param("memId") String memId);

	int selectBoardRecount(@Param("bno") int bno);

	ArrayList<HashMap<String, String>> selectBoards_map();

}
