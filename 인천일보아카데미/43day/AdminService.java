package admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;
import jdbcShop.Member;

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
			}
		else {
			System.out.println("["+mid +"] 회원을 이용가능 처리하였습니다.");
			}
		}	else {
			System.out.println("회원정보 변경을 실패 했습니다.");
	}
	
}
	public void manageGoods() {
		System.out.println("[상품관리]");
		addao.selectgoods();
		
	}
}
