package com.movieProject.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.MemberDao;
import com.movieProject.dto.Member;

@Service
public class MemberService {

	@Autowired
	private MemberDao memdao;
	
	public Member getLoginMemberInfo_kakao(String id) {
		
		System.out.println("SERVICE - getLoginMemberInfo_kakao(String id)");
		
		return memdao.selectMemberInfo(id);
	}

	public int registMember_kakao(Member member) {
		System.out.println("SERVICE - registMember_kakao(Member member)");
		
		return memdao.insertMember_kakao(member);
	}

}
