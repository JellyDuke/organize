package com.spring_memberBoard.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring_memberBoard.dao.MemberDao;
import com.spring_memberBoard.dto.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberDao mdao;
	public String midCheck(String inputId) {
		System.out.println("SERVICE - midCheck() 호출");
		System.out.println("아이디: " + inputId);
		//DAO - SELECT MID FROM MEMBERS WHERE MID = #{변수명 inputId};
		Member member = mdao.selectMemberInfo(inputId);
		Member member_mapper = mdao.selelctMemberInfo_mapper(inputId);
		System.out.println(member);
		System.out.println(member_mapper);
		String result = "N";
		if(member == null) {
			result = "Y";
		}
		return result;
	}
	public int signupSvc(Member mem) {
		System.out.println("signupSvc - 호출");
		int result = mdao.signup(mem);
		if(result<= 0 ) {
			return 0;
		}
		return result;
	}
}
