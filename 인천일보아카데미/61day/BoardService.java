package com.springProject01.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springProject01.dao.BoardDao;
import com.springProject01.dto.Board;

@Service
public class BoardService {
	@Autowired
	BoardDao bdao;
	public int boardWrite_svc(Board board) {
		System.out.println("SERVICE - boardWrite_svs() 호출");
		//DAO - INSERT
		int insertResult = bdao.insertBoard(board);
		return insertResult;
	}
	
}
