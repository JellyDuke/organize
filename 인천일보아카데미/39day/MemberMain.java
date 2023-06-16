package jdbcMember;

import java.util.Scanner;

public class MemberMain {

	public static void main(String[] args) {
		//MemberMain, MemberService, MemberDao, Member
		Scanner scan = new Scanner(System.in);
		MemberService msvc = new MemberService();
		boolean run = true;
		while(run) {
			//메뉴출력
			System.out.println("로그인 아이디:" +msvc.getLoginId());
			if(msvc.getLoginId() == null) {
				System.out.println("[1]회원가입 [2]로그인"); //로그인을 되지 않은 경우 출력
			}else {
				System.out.println("[1]정보확인 [2]로그아웃");
			}
			System.out.println("메뉴선택 >>");
			//메뉴선택
			int selectMenu = scan.nextInt();
			//선택된 메뉴 호출
			switch(selectMenu) {
			case 1:
				//로그인 x :: 회원가입 기능 호출
				if(msvc.getLoginId() == null) { //로그인이 되지 않은 경우 메뉴 출력
					msvc.memberJoin();//회원가입 기능
				}else { 
					//정보확인
				}
				break;
			case 2:
				//로그인 x :: 로그인 기능 호출
				if(msvc.getLoginId() == null) { //로그인이 되지 않은 경우 메뉴 출력
					msvc.memberLogin(); //로그인 기능
				}else { //로그아웃 기능 호출
					msvc.memberLogout();
				}
				break;
			default:
				run = false;
			}
		}
	}
}
