package service;

import dao.MemberDao;
import dto.Member;

public class MemberService {
	
	MemberDao mdao = new MemberDao();

	// 아이디 중복확인 기능
	public String memberIdCheck(String checkId) {
		System.out.println("service - memberIdCheck() 호출");
		String checkReturn = "Y"; // Y이면 사용가능 N이면 중복
		// SELECT * FROM MEMBERS WHERE MID = ?
		Member mem = mdao.selectMemberInfo(checkId);
		if(mem != null) {
			checkReturn = "N";
		}
		return checkReturn;
	}

	// 회원가입 기능 - SERVICE
	public int signupSvc(Member joinMember) {
		
		System.out.println("service - signupSvc 호출");
		
		int result = mdao.signup(joinMember);
		
		if(result <= 0) {
			return 0;
		}
		return result;
	}

	// 로그인 - 회원정보 조회
	public Member memberLogin(String loginId, String loginPw) {
		
		System.out.println("service - memberLogin 호출");
		Member memInfo = mdao.selectMemberLogin(loginId, loginPw);

		return memInfo;
	}

	public Member memberInfo(String infoId) {
		
		System.out.println("service - memberInfo 호출");
		Member memInfo = mdao.selectMemberInfo(infoId);
		
		// SELECT * FROM MEMBER WHERE MID = ?
		// SELECT MID, MPW, MNAME, TO_CHAR(MBIRTH, 'YYYY-MM-DD'), MADDR FROM MEMBERS WHERE MID = ?
		
		String birthDate = memInfo.getMbirth().split(" ")[0];
		memInfo.setMbirth(birthDate);
		
		return memInfo;
	}
	
	
	
}
