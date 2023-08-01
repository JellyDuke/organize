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

	public Member getLoginInfo(String mid, String mpw) {
		System.out.println("MemberService - getLoginInfo() 호출");
		//DAO - 회원정보 SELECT * FROM MEMBERS WHERE MID = #{} AND MPW = {}
		Member memInfo = mdao.selectMemberLogin(mid,mpw);
		return memInfo;
	}

	public Member memberInfo(String infoId) {
		System.out.println("SERVCIE - memberInfo 호출");
		Member memInfo = null;
		try {
			memInfo = mdao.selectMemberInfo(infoId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		String birthDate = memInfo.getMbirth().split(" ")[0];
		memInfo.setMbirth(birthDate);
		
		return memInfo;
	}
	//회원정보 수정
	public int modifyMemberInfo(Member member) {
		System.out.println("SERVICE - modifyMemberInfo 호출");
		int result = 0;
		
		try {
			result = mdao.updateMemberInfo(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
