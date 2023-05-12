package p0512;
public class MemberMain {
	public static void main(String[] args) {
		boolean run = true;
		//객체 이름 =  생성자
		MemberService memsvc = new MemberService();
		
		while(run) {
			//메뉴 출력 기능 메소드 호출
			memsvc.showMenu();
			//메뉴 선택
			int selectMenu = memsvc.scan.nextInt(); //클래스를 memsvc로 정의 memsvc에 있는 기능을 가져와 사용.
			switch(selectMenu) {
			case 1: //회원가입 기능 메소드 호출
				memsvc.memberJoin();
				break;
			case 2: //로그인 기능 메소드 호출
				memsvc.memberLogin();
				
				break;
			default:
				run = false;
			}
		}
		System.out.println("종료");
	}
}
