package p0512;
import java.util.Scanner;
public class MemberService {
	
	//기능 정의 클래스
	Scanner scan = new Scanner(System.in);
	//회원 목록(DB)
	//메뉴 출력 기능 메소드
	public void showMenu() {
		System.out.println("***********************");
		System.out.println("[1]회원가입 [2]로그인 [3]종료");
		System.out.println("***********************");
		System.out.println("메뉴선택>>");
	}
	Member[] memberList = new Member[5];
	//회원가입 기능 메소드
	void memberJoin() {
		System.out.println("[회원가입]");
		//memberList 배열의 비어있는 인덱스 검색
		int idx = -1;
		for(int i = 0; i <= memberList.length; i++) { //i <= memberList.length Error 22 line error
			if(memberList[i] == null) { //배열에 널(비어있음)일때
				idx = i;
				break;
			}
		}
		if(idx == -1){
			System.out.println("더이상 회원가입 할 수 없습니다.");
			return; //멈춤	
		}
		//회원가입 처리
		//1. 가입정보 입력
		System.out.println("ID>>");
		String InputId = scan.next();
		for(int i = 0; i < memberList.length; i++) {
			if(memberList[i] != null) {
				if(InputId.equals(memberList[i].getMid())) {
					System.out.println("중복된 아이디입니다.\n다시 가입해주세요!");
					return;
				}
			}
		}
		System.out.println("Password>>");
		String InputPw = scan.next();
		System.out.println("name>>");
		String Inputname = scan.next();
		
		//2. 입력단 정보를 하나로 모으고
		Member mem = new Member();//mem에 저장을한다.
		mem.setMid(InputId); //정보 불러오기
		mem.setMpw(InputPw); 
		mem.setMname(Inputname);
		//3. 회원 목록에 저장
		memberList[idx] = mem;
		System.out.println("가입되었습니다.");
	}
	//아이디 중복확인 기능 메소드
	
	//로그인 기능 메소드
}
