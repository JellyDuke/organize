package jdbcShop;

import java.util.Scanner;

//1. Member(회원정보), Goods(상품정보), order(주문정보)
//2. shopservice(기능)
//3. shopdao (db)
//4. showmain

public class ShopMain {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		boolean run = true;
		ShopService shopsvc = new ShopService();
		while (run) {
			// 메뉴출력 (로그인상태에 따라 다른 메뉴 출력)
			String loginId = shopsvc.getLoginId(); // 로그인 확인 변수 shopsvc 클래스의 객체 안의 loginId를 불러옴 null 혹은 아이디 정보 저장이 됨.
			if (loginId == null) { // 로그인 x
				System.out.println("[1]회원가입 [2]로그인");
			} else { // 로그인 o
				System.out.println("[1]내정보확인 [2]로그아웃 [3]상품주문 [4]주문내역 [9]Map호출");
			}
			System.out.print("메뉴선택>>");
			int selectMenu = scan.nextInt();
			switch (selectMenu) {
			case 9:
				if (loginId == null) { //회원가입 기능 호출
					shopsvc.memberJoin();
				} else { //아닐경우 내정보 확인
					shopsvc.goodsList_Map();
				}
				break;
			case 1:
				if (loginId == null) { //회원가입 기능 호출
					shopsvc.memberJoin();
				} else { //아닐경우 내정보 확인
					shopsvc.memberInfo();
				}
				break;

			case 2:
				if (loginId == null) { //로그인 기능 호출
					shopsvc.memberLogin();
				} else { //로그아웃 기능 호출
					shopsvc.memberLogout();
				}
				break;

			case 3:
				if (loginId != null) {// 상품주문 기능 호출 
				shopsvc.goodsOrder();
				} 
				break;

			case 4:
				if (loginId != null) {//주문내역 기능 호출
				shopsvc.orderList();
				}
				break;

			default:
				run = false;
				
			}
		}
	}
}
