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
		
		System.out.println("MemberService - midCheck() 호출");
		System.out.println("아이디 : " + inputId);
		
		// SELECT * FROM MEMBERS WHERE MID = #{아이디 }
		
		Member member = mdao.selectMemberInfo(inputId);
		
		Member member_mapper = mdao.selectMemberInfo_mapper(inputId);
		
		System.out.println(member);
		
		System.out.println(member_mapper);
		
		String result = "N"; // 중복 확인 결과 Y:사용가능 N:사용불가(중복)
		
		if(member == null) {
			result = "Y";
		}
		
		return result;
	}

	public int memJoin(Member mem) {
		
		System.out.println("MemberService - memJoin() 호출");
		
		// DAO 호출 - INSERT INTO MEMBERS()...
		
		int result = 0;
		
		try {
//			result = mdao.joinInsertInfo(mem);	
			result = mdao.joinInsertInfo_mapper(mem);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 로그인 - 회원정보 조회
	public Member getLoginMemberInfo(String mid, String mpw) {
		
		System.out.println("MemberService - getLoginMemberInfo() 호출");
		
		Member mem = new Member();
		
		// DAO - 회원정보 조회 SELECT * FROM MEMBERS WHERE MID = #{파라메터명 } AND MPW = #{파라메터명 }
		mem = mdao.selectLogin(mid, mpw);
		
		return mem;
	}
	
	// 회원정보 조회                                                          
	public Member getMemInfo(String memId) {
		
		System.out.println("MemberService - getMemInfo() 호출");
		
		Member mem = new Member();
		try {
			mem = mdao.selectMemberInfo(memId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return mem;
	}

	public int modifyMemberInfo(Member member) {
		
		System.out.println("SERVICE - modifyMemberInfo() 호출");
		
		int result = 0;
		
		try {
			// DAO - UPDATE문
			result = mdao.updateMemberInfo(member);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	

}
