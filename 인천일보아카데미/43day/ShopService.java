package jdbcShop;

import java.util.ArrayList;
import java.util.HashMap;
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
			 if(loginMember.getMstate().equals("Y")) {
				loginId = loginMember.getMid();
				System.out.println("로그인 성공");
			}else {
				System.out.println("이용이 정지된 계정입니다.");
				System.out.println("관리자에게 문의해주세요.");
			}
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

			int counterOrder = shopdao.selectCountOrder(loginId);
			int totalPirce = shopdao.selectTotalPrice(loginId);
			System.out.println("[총 주문수] " + counterOrder);
			System.out.println("[총 결제금액] " + totalPirce);
		}
	}

	ArrayList<Goods> getGoodsList() {
		ArrayList<Goods> goodsList = null; // 저장 goodsL
		System.out.println("[1]전체상품 [2]종류별상품 [3]인기상품");
		System.out.print("선택>>");
		int selectList = scan.nextInt();
		switch (selectList) {

		case 1: // select * from goods where gstock > 0;
			System.out.println("[전체상품목록]");
			goodsList = shopdao.selectGoods_All();
			break;

		case 2:
			System.out.println("[종류별상품목록]");
			// 1.GTYPE 조회 SELECT GTYPE FROM GOODS GROUP BY GTYPE

			ArrayList<Goods> gtypeList = shopdao.selectGoods_Type();
//			if(gtypeList == null || gtypeList.size() == 0) {
//				return null;
//			}

			if (gtypeList != null) {
				for (int i = 0; i < gtypeList.size(); i++) {
					System.out.print("[" + i + "]" + gtypeList.get(i).getGtype() + " ");
				}
				System.out.println("\n선택>>");
				int selectType = scan.nextInt();
				String gtype = gtypeList.get(selectType).getGtype(); // scan로 숫자 선택을 gtype에 저장, 기타가 0번일때 0번을 입력시 0번을
																		// gtype에 저장
				goodsList = shopdao.selectGoods_Type(gtype); // Select * from where gtype = ? DB쿼리문
			}
			break;

		case 3:
			System.out.println("[인기상품목록]");
			goodsList = shopdao.selectGoods_Best();
			break;
		}

		return goodsList;
	}

//	상품주문
	public void goodsOrder() {
		ArrayList<Goods> goodsList = getGoodsList();
		if (goodsList == null || goodsList.size() <= 0) {
			System.out.println("다시 선택해 주세요.");
			return;
		}
		for (int i = 0; i < goodsList.size(); i++) {
			System.out.println("[" + i + "]" + goodsList.get(i).getGname() + ", [가격]" + goodsList.get(i).getGprice()
					+ "원, [재고]" + goodsList.get(i).getGstock() + "개, ");
		}
		System.out.print("상품선택 >>");
		int selectGoods = scan.nextInt(); // 선택
		if (selectGoods >= goodsList.size()) {
			System.out.println("재선택 해주세요.");
			return;
		}

		Goods goods = goodsList.get(selectGoods);

		System.out.println(goods.getGname() + " [가격]" + goods.getGprice() + " 선택");
		System.out.println("상품을 선택했습니다.");
		String odgcode = goods.getGcode(); // 변수에 저장

		System.out.print("주문할 수량 입력>>");
		int odqty = scan.nextInt();// 주문수량

		if (odqty > goods.getGstock()) {
			System.out.println("상품재고가 부족합니다.");
			System.out.println("다시 선택 해주세요.");
			return;
		}
		// 주문자 아이디odmid = 로그인아이디loginId, 주문시간oddate = SYSDATEQ
		// 주문코드 생성(JAVA)
		// 1. 현재 주문코드 최대값 조회
		// --SELECT NVL(MAX(ODCODE), 'O0000' FROM ORDERS
		String maxOdcode = shopdao.selectMaxOdcode();
		if (maxOdcode == null) {
			System.out.println("주문처리중 문제가 발생했습니다.");
			System.out.println("다시 주문해 주세요");
			return;
		}
		System.out.println("maxOdcode :" + maxOdcode); // O0000
		// 'O0000'>>[0][1][2][3][4]

		String strCode = maxOdcode.substring(0, 1);// 'O' O를 땜
		// maxOdcode.substring(1) >> '0000'
		int numCode = Integer.parseInt(maxOdcode.substring(1)) + 1; // Interger.parseInt -> 문자열을 인트형 으로.. -> 0000 문자를
																	// 0000 숫자로 선언
		String odcode = strCode + String.format("%04d", numCode); // strCode+numCode 이대로 하면 "O1" 임 만드고자 하는건 O0001임
		// 그래서 str + String.format(,)를 사용 String.format 문자열을 포멧하는 역활 의미 "O0001" %04d
		// numCode를 사용할건데 4자리를비워두고 비워둔 자리에는 0를 써줌. %0 -> 채워줌 자리수4-> 공백 숫자이면 d 문자는 s
		System.out.println("odcode: " + odcode);

		// 주문처리 (ORDERS - INSERT, GOODS - UPDATE)
		// 주문코드 (odcode),주문자 아이디(loginId),상품코드(odgcode),주문수량(odqty)
//		Order od = new Order();
//		od.setOdcode(odcode);
//		od.setOdmid(loginId);
//		od.setOdgcode(odgcode);
//		od.setOdqty(odqty);
		int result = shopdao.LCY(odcode, loginId, odgcode, odqty/* 애들 대신에 od 사용 가능 */);
		if (result < 0) {
			System.out.println("올바르지 않은 주문입니다. 재입력해주세요.");
			return;
		} else {
			int rseult = shopdao.LAY(odgcode, odqty);
			System.out.println("주문이 완료 되었습니다.");
		}
		// SELECT 'O' ||LPAD(MAX(2),4,0) FROM ORDERS; 주문자 코드 생성 (SQL)

	}

	public void orderList() {
		System.out.println("[주문내역]");
		System.out.println("[1]최근순 [2]총액이많은 순");
		System.out.print("select >>");
		int select = scan.nextInt();
		ArrayList<HashMap<String, String>> orderList = new ArrayList<HashMap<String, String>>();
		orderList = shopdao.orderList(loginId, select);
		switch (select) {
		case 1:
			System.out.println("[1]최근순");
			break;
		case 2:
			System.out.println("[2]총액이 많은순");
			break;
		default:
			System.out.println("다시 입력해 주세요.");
			return;
		}
		for (int i = 0; i < orderList.size(); i++) {
			System.out.print("["+i+"]"+orderList.get(i).get("ODCODE") + " ");
			System.out.print(orderList.get(i).get("GNAME") + " ");
			System.out.print(orderList.get(i).get("GPRICE") + " ");
			System.out.print(orderList.get(i).get("ODQTY") + " ");
			System.out.print(orderList.get(i).get("T") + " ");
			System.out.println(orderList.get(i).get("ODDATE") + " ");
		}
		
		System.out.print("취소할 주문 선택>>");
		int selectOrder = scan.nextInt(); // 0
		HashMap<String, String> order = orderList.get(selectOrder);
		String odcode = order.get("ODCODE"); //취소할 주문 코드
		int odqty = Integer.parseInt(order.get("ODQTY")); //증가 시킬 재고
		String gcode = order.get("GCODE"); //재고를 증가시킬 상품 코드
		//주문취소 - dao 호출 메소드
		int cancelResult = shopdao.cancelOrder(odcode,gcode,odqty); //주문코드, 재고, 상품코드
		if(cancelResult > 0 ) {
			System.out.println("주문이 취소 되었습니다.");
		}
		else {
			System.out.println("재선택 해주세요.");
		}
	}

	public void goodsList_Map() {
		System.out.println("[상품목록(Map)]");
		// 1. 상품목록 조회(dao-SELECT >> service 리턴
		ArrayList<HashMap<String, String>> goodsList = shopdao.selectGoods_Map();
		// 2. 조회된 상품 목록 출력
		for (int i = 0; i < goodsList.size(); i++) {
			System.out.print(goodsList.get(i).get("GCODE") + " ");
			System.out.print(goodsList.get(i).get("GNAME") + " ");
			System.out.print(goodsList.get(i).get("GPRICE") + " ");
			System.out.print(goodsList.get(i).get("GTYPE") + " ");
			System.out.println(goodsList.get(i).get("GSTOCK") + " ");
		}
	}
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

// 주문코드 생성 '00001','00002','00003'
// 1. 현재 주문코드 최대값 조회('00001')
// 2. 문자를 >> 숫자로 변환 'A' '0001' >> 1, 'A0001' >> 'A', '0001' 분리
// 3. '0001'을 숫자 1로 변환
// 4. 숫자 1에 +1
// 5. 숫잘즐 4자리의 '0002'형식으로 변환
// 6.'A' + '0002' >> 'A0002'
