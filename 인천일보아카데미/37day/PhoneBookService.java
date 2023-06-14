package P0614_1;

import java.util.Scanner;

public class PhoneBookService {

	PhoneBookDao pdao = new PhoneBookDao();
	Scanner scan = new Scanner(System.in);
	
	public void insertPhoneBook() {
		System.out.println("[등록]");
		//1. 등록한 이름, 전화번호 입력
		System.out.println("등록할 이름 입력>>");
		String name = scan.next();
		
		System.out.println("등록할 전화번호 입력>>");
		String phonenum = scan.next();
		
		PhoneBook pb = new PhoneBook();
		pb.setName(name);
		pb.setPhonenum(phonenum);
		
		//2. DAO insert 기능 메소드 호출
		int insertResult = pdao.insert(pb);
		//3. 결과 확인 및 처리
		if (insertResult > 0) {
			System.out.println("새 연락처가 등록 되었습니다.");
		}else {
			System.out.println("새 연락처 등록을 실패하였습니다.");
		}
	}
}
