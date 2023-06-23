package admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class AdminService {
	Admindao addao = new Admindao();
	Scanner scan = new Scanner(System.in);
	
	public void member() {
		
		ArrayList<HashMap<String, String>> List = new ArrayList<HashMap<String, String>>();
		List = addao.select();
		
		for(int i = 0; i<List.size(); i++) {
			System.out.print("["+i+"] ["+List.get(i).get("MSTATE")+"] ");
			System.out.print("[아이디] ["+List.get(i).get("MID")+"] ");
			System.out.println("[이름] ["+List.get(i).get("MNAME")+"] ");
		}
		
		System.out.println("[회원정지]");
		System.out.print("입력>>");
		int Selecta = scan.nextInt();
		
		String mid = List.get(Selecta).get("MID");
		String mstate = List.get(Selecta).get("MSTATE");
		int update = addao.updateR(mid,mstate);
		
			if(update > 0) {
				if(mstate.equals("Y")) {
					System.out.println("["+mid +"] 회원을 이용정지 처리하였습니다.");
					return;
				}
				else {
					System.out.println("["+mid +"] 회원을 이용가능 처리하였습니다.");
					return;
				}
			}	else {
				System.out.println("회원정보 변경을 실패 했습니다.");
				return;
		}
	}
	public void manageGoods() {
		System.out.println("[상품관리]");
		ArrayList<HashMap<String, String>> goods = new ArrayList<HashMap<String, String>>();
		goods = addao.goodsList();
		if(goods == null) {
			 System.out.println("목록 불러오기 실패.");
			 return;
		}else if (goods.size() < 0 ) {
			System.out.println("조회된 상품이 없습니다.");
			return;
		}
		for(int i = 0; i < goods.size(); i ++) {
			System.out.print("["+i+"] [" + goods.get(i).get("GSTATE") + "] ");
			System.out.print("["+goods.get(i).get("GNAME") + "] ");
			System.out.print("["+goods.get(i).get("GPRICE") + "] ");
			System.out.println("["+goods.get(i).get("GSTOCK") + "] ");
		}
		System.out.println("[상품관리]");
		System.out.println("선택>>");
		int select = scan.nextInt();
		String gstate = goods.get(select).get("GSTATE");
		String gname = goods.get(select).get("GNAME");
		String gcode = goods.get(select).get("GCODE");
		
		System.out.println("선택한 상품은 ["+gname+"] 입니다.");
		if(gstate.equals("Y")) {
			System.out.println("주문 가능한 상품입니다.");
		} else {
			System.out.println("주문 불가능한 상품입니다.");
		}
		System.out.println("판매 상태를 변경하겠습니까?");
		System.out.println("[1]예 [2]아니오");
		System.out.print("선택>>");
		int selecta = scan.nextInt();
		switch(selecta) {
			case 1:
				int stateUp = addao.upateA(gstate,gname,gcode);
				if(stateUp > 0) {
					if(gstate.equals("Y")) {
						System.out.println("["+gname +"] 상품 상태를 'N'로 변경하였습니다.");
						return;
					}
					else {
						System.out.println("["+gname +"] 상품 상태를 'Y'으로 변경하였습니다.");
						return;
					}
				}
				else {
					System.out.println("판매 상태 변경 처리를 실패 하였습니다.");
				}
				break;
				
			case 2:
				break;
		}
	}
}
