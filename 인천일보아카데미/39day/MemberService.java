package jdbcMember;
import java.util.Scanner;

public class MemberService {
	MemberDao mdao = new MemberDao();
	Scanner scan = new Scanner(System.in);
	Member mb = new Member();

	public void memberJoin() { //회원가입 기능
		System.out.println("[회원가입]");
		//1. 가입할 회원정보 입력
			System.out.println("아이디 입력>>");
			String inputID = scan.next();
			//아이디 중복 체크(SELECT) members 테이블의 mid 컬럼 - select
//			select mid from members where mid = ?
			String idCheck = mdao.select_idcheck(inputID);
			if(idCheck != null) {
				System.out.println("사용할 수 없는 아이디 입니다.");
				System.out.println("회원가입을 다시 시도해주세요!");
				return;
			}else {
				System.out.println("사용 가능한 아이디 입니다.");
			}
			System.out.println("패스워드 입력>>");
			String inputPw = scan.next();

			System.out.println("이름 입력>>");
			String inputName = scan.next();

			System.out.println("전화번호 입력>>");
			String inputPhoneNum = scan.next();

			System.out.println("생년월일 입력>>");
			String inputBirth = scan.next();
		//2. 회원정보를 Members 테이블에 INSERT
			mb.setMid(inputID);
			mb.setMpw(inputPw);
			mb.setMname(inputName);
			mb.setMphone(inputPhoneNum);
			mb.setMbirth(inputBirth);
		//3. INSERT(회원가입) 결과 출력
			int insertResult = mdao.insert(mb);
			if (insertResult > 0) {
				System.out.println("회원가입이 등록 되었습니다.");
			}else {
				System.out.println("회원가입 등록을 실패하였습니다.");
		}
	}
	private String loginId = null;
	
	public String getLoginId() {
		return loginId;
	}

	public void memberLogin() {//로그인 기능 메소드
		System.out.println("[로그인]");
		//1. 로그인할 아이디, 비밀번호 입력
		System.out.println("로그인 아이디>>");
		String inputMid = scan.next();
		System.out.println("로그인 비밀번호>>");
		String inputMpw = scan.next();
		//2. 일치하는 회원정보가 있는지 조회
//		select mid from members where mid = ? and mpw = ?
		Member loginMember = mdao.select_login(inputMid, inputMpw);
		//3. 로그인 처리
		System.out.println("loginId : " + loginId);
		if(loginMember != null) {
			System.out.println("로그인 성공");
			loginId = loginMember.getMid();
//			로그인 처리
		}else {
			System.out.println("아이디/비밀번호가 일치하지 않습니다.");
			System.out.println("로그인 실패");
		}
	}

	public void memberLogout() {
		loginId = null;
		System.out.println("로그아웃 되었습니다.");
	}
	
}
