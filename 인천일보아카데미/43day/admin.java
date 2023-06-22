package admin;

import java.util.Scanner;

public class admin {

	public static void main(String[] args) {
		AdminService asv = new AdminService();
		Scanner scan = new Scanner(System.in);
		System.out.println("[1]회원관리 [2]상품관리");
		System.out.print("선택>>");
		int select = scan.nextInt();
		
		switch(select) {
		case 1:
			System.out.println("[회원관리]");
			asv.member();
			break;
		case 2:
			asv.manageGoods();
			break;
		default:
			break;
		}
	}
}
