package P0614_1;
import java.util.Scanner;
public class PhoneBookMain {

	public static void main(String[] args) {
		PhoneBookService pbsvc = new PhoneBookService();
		Scanner scan = new Scanner(System.in);
		boolean run = true;
		while(run) {
			//메뉴출력
			System.out.println("[1]등록 [2]조회 [3]수정 [4]삭제");
			System.out.println("메뉴선택>>");
			//메뉴선택
			int selectMenu = scan.nextInt();
			//기능호출
			switch (selectMenu) {
			case 1:
				pbsvc.insertPhoneBook();
				break;
			
			case 2:
			
				break;
			
			case 3:
				
				break;

			case 4:
				
				break;
			
			default:
				run = false;
			}
			break;
		}
	}
}
