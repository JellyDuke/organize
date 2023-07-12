package service;

import dao.MemberDao;
import dto.Member;

public class MemberService {
	MemberDao mdao = new MemberDao();
	//아이디 중복 확인 기능
	public String memberIdCheck(String checkId) {
		System.out.println("service - memberIdCheck()호출");
		String result = "Y";
		//Select * FROM MEMBERS WHERE MID = ?
		Member mem = mdao.selectMemberInfo(checkId);
		
		if(mem != null) { //mem 가 null은 조회되면 아이디 중복이다.
			result = "N";
		}
		
		return result;
	}

	public int JoinForm(Member joinMember) {
		int insertResult = mdao.insert(joinMember);
		return insertResult;
	}

	public Member memberLogin(String loginId, String loginPw) {
		Member loginMember = mdao.select_login(loginId, loginPw);
		
		return loginMember;
	}

	public Member memberInfo(String infoId) {
		// 1. SELECT * FROM MEMBERS WHERE MID = ?
		
		// 2. SELECT MID, MPW, MNAME, TO_CHAR(MBIRTH, 'YYYY-MM-DD'),MADDR
		// FROM MEMBERS WHERE MID = ?
		
		System.out.println("내정보 호출");
		Member mem = mdao.selectMemberInfo(infoId);
		String birthDate = mem.getMbirth().split(" ")[0];
		mem.setMbirth(birthDate);
		return mem;
	}

}
