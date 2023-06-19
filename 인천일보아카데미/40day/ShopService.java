package jdbcShop;

import java.util.ArrayList;
import java.util.Scanner;

public class ShopService {
	private String loginId = null; // 로그인 상태인지 아닌지 체크 변수선언
	Scanner scan = new Scanner(System.in);
	Member mb = new Member();
	ShopDao shopdao = new ShopDao(); // shopdao 클래스 객체하나

	public String getLoginId() { // 로그인 넘겨 받을 getter 하나만
		return loginId;
	}

	public void memberJoin() {
		System.out.println("[회원가입]");
		// 1. 가입정보 입력
		// 아이디 중복 체크
		// db select mid from members where mid = ?
		System.out.print("아이디 입력>>");
		String inputID = scan.next();
		// 아이디 중복 확인
		String idCheck = shopdao.select_idcheck(inputID);
		if (idCheck != null) {
			System.out.println("사용할 수 없는 아이디입니다.");
			return;
		} else {
			System.out.println("사용 가능한 아이디입니다.");
		}

		System.out.print("패스워드 입력>>");
		String inputPw = scan.next();

		System.out.print("이름 입력>>");
		String inputName = scan.next();

		System.out.print("전화번호 입력>>");
		String inputphone = scan.next();

		System.out.print("생년월일 입력>>");
		String inputBirth = scan.next();

		mb.setMid(inputID);
		mb.setMpw(inputPw);
		mb.setMname(inputName);
		mb.setMphone(inputphone);
		mb.setMbirth(inputBirth);

		int insertResult = shopdao.insert(mb);
		if (insertResult > 0) {
			System.out.println("회원가입이 등록되었습니다.");
		} else {
			System.out.println("회원가입 등록을 실패하였습니다.");
		}
	}

	public void memberLogin() {
		System.out.println("[로그인]");
		System.out.print("로그인할 아이디>>");
		String inputMid = scan.next();
		System.out.print("비밀번호 >>");
		String inputMpw = scan.next();
		Member loginMember = shopdao.select_login(inputMid, inputMpw);
		
		if (loginMember != null) {
			System.out.println("로그인 성공");
			loginId = loginMember.getMid();
		} else {
			System.out.println("아이디/비밀번호가 일치하지 않습니다.");
			System.out.println("로그인 실패");
		}
		System.out.println("loginId : " + loginId);
	}

	public void memberLogout() {
		loginId = null;
		System.out.println("로그아웃 되었습니다.");
	}
	// 내정보 확인

	public void memberInfo() {
		System.out.println("[내정보 확인]");
		// 회원정보 출력, 주문 정보 출력
//		1.회원정보 조회 (select * from members mid = ?)
//		- 현재 로그인 중인 회원의 정보를 조횡
		Member memInfo = shopdao.seleclt_MemberInfo(loginId);
		if (memInfo == null) {
			System.out.println("회원정보를 찾을 수 없습니다.");
		} else {
			System.out.print("[아이디]" + memInfo.getMid());
			System.out.print("[비밀번호]" + memInfo.getMpw());
			System.out.print("[이름]" + memInfo.getMname());
			System.out.print("[전화번호]" + memInfo.getMphone());
			System.out.println("[생년월일]" + memInfo.getMbirth());

		}
	}

	ArrayList<Goods> getGoodsList(){
		ArrayList<Goods> goodsList = null; //저장 goodsL
		System.out.println("[1]전체상품 [2]종류별상품 [3]인기상품");
		System.out.print("선택>>");
		int selectList = scan.nextInt();
		switch(selectList) {
		
		case 1: //select * from goods where gstock > 0;
			System.out.println("[전체상품목록]");
			goodsList = shopdao.selectGoods_All();
			break;
			
		case 2:
			System.out.println("[종류별상품목록]");
//			goodsList = shopdao.selectGoods_Type();
			break;
			
		case 3:
			System.out.println("[인기상품목록]");
//			goodsList = shopdao.selectGoods_Best();
			break;
		}
		
		return goodsList;
	}

//	상품주문
	public void goodsOrder() {
		ArrayList<Goods> goodsList = getGoodsList();
		if(goodsList == null || goodsList.size()<= 0) {
			System.out.println("다시 선택해 주세요.");
			return;
		}
		for(int i = 0; i < goodsList.size(); i ++) {
			System.out.println("["+i+"]"+goodsList.get(i).getGname()+ ", [가격]"
								+ goodsList.get(i).getGprice() + "원, [재고]"
								+ goodsList.get(i).getGstock()+ "개, ");
		}
		System.out.print("상품선택 >>");
		int selectGoods = scan.nextInt();
		
		Goods goods = goodsList.get(selectGoods);
	
		
		System.out.println(goods.getGname() + " [가격]" + goods.getGprice() + " 선택");
		System.out.println("상품을 선택했습니다.");
		String odgcode = goods.getGcode();
		
		System.out.print("주문할 수량 입력>>");
		int odqty = scan.nextInt();//주문수량
		
		if(odqty > goods.getGstock()) { 
			System.out.println("상품재고가 부족합니다.");
			System.out.println("다시 선택 해주세요.");
			return;
		}
		
		//주문자 아이디odmid = 로그인아이디loginId, 주문시간oddate = SYSDATE
		//주문코드 생성 '00001','00002','00003'
		//1. 현재 주문코드 최대값 조회('00001')
		//2. 문자를 >> 숫자로 변환 'A' '0001' >> 1, 'A0001' >> 'A', '0001' 분리
		//3. '0001'을 숫자 1로 변환
		//4. 숫자 1에 +1
		//5. 숫잘즐 4자리의 '0002'형식으로 변환
		//6.'A' + '0002' >> 'A0002'
		//
		
	
	}
//		1. 판매중인 상품 목록 출력
//		 -전체상품목록, 종류별상품목록, 인기상품목록
//		2. 구매할 상품 선택(상품코드선택)
//		3. 구매 수량 입력(주문수량입력)
//			--주문 코드 생성 (orders - select)
//		주문코드, 주문자아이디, 상품코드, 주문수량
//		4. 주문 처리 후 결과 출력 orders - insert 후 
//			--goods(update)  -  상품재고 수정
//		    --orders(insert) -  주문정보 입력
}
		