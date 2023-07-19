package com.springProject01.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springProject01.dao.MemberDao;
import com.springProject01.dto.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao mdao;
	
	public int memberJoin_svc(Member member) {
		System.out.println("service - memberJoin_svc() 호출");
		//1.dao - INSERT INTO MEMBERS
		int insertResult = mdao.insertMember(member);
		return insertResult;
	}

	public ArrayList<Member> getMemberList() {
		System.out.println("service - memberList_svc() 호출");
		ArrayList<Member> mList = mdao.selectMemberList(); 
		return mList;
	}

}
