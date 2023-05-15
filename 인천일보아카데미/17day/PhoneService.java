package p0515;
import java.util.Scanner;
public class PhoneService {

//	기능정의 클래스
	Scanner scan = new Scanner(System.in);
	
//	메뉴출력 기능 : showMenu()
//	[1]등록 [2]검색 [3]수정 [4]삭제
	public  void showMenu() {
		System.out.println("==========================");
		System.out.println("[1]등록 [2]검색 [3]수정 [4]삭제");
		System.out.println("==========================");
		System.out.println("메뉴선택>>");
		}
//	연락처저장기능 registInfo()
	PhoneBook[] pbList = new PhoneBook[5];
	public void registInfo() {
		System.out.println("[등록]");
//		pbList 비어있는 인덱스 조회
		int idx = -1;
		for(int i = 0; i < pbList.length; i++) {
			if(pbList[i] == null) {
				idx = i;
				break;
			}
		}
		if(idx == -1) {
			System.out.println("더이상 연락처를 저장 할 수 없습니다.");
			System.out.println("연락처를 삭제 해주세요!");
			return;
		}
//		새로 등록할 연락처 정보 입력
		System.out.println("이름입력>>");
		String inputName = scan.next();
		System.out.println("번호입력>>");
		String inputPhoneNum = scan.next();
		PhoneBook newInfo = new PhoneBook();
		newInfo.setName(inputName);
		newInfo.setPhoneNum(inputPhoneNum);
		//연락처 목록(pbList) 저장
		pbList[idx] = newInfo;
		System.out.println("새 연락처가 등록 되었습니다.");
	}
//	연락처검색기능 searchInfo()
//	-이름으로 전화번호 검색
//	-전화번호로 이름검색
//	검색된 연락처를 출력("이름 : ", "전화번호 : ")
	public void searchInfo() {
		System.out.println("[검색]");
		System.out.println("검색할 이름 입력>>");
		String searchName = scan.next();
		int idx = searchIdx(searchName);
		if(idx > -1) {
			System.out.println("이름 : "+ pbList[idx].getName() +"연락처 : "+ pbList[idx].getPhoneNum() );
		}
		else {
			System.out.println("검색된 연락처가 없습니다.");
		}
	}
	public int searchIdx(String searchName) {
		int idx = -1;
		for(int i = 0; i < pbList.length; i++) {
			if(pbList[i] != null) {
				if(searchName.equals(pbList[i].getName())) {
					idx = i;
					break;
				}
			}
		}
		return idx;
	}
//	연락처수정기능: modifyInfo()
//	1.수정할 연락처를 검색 
//	2.연락처가 검색되었을 경우
//	3.검색되지 않았을 경우
//	-"등록되지 않은 연락처 입니다." 출력
//	-이름을 수정
//	-전화번호를 수정
	public void modifyInfo() {
		System.out.println("[수정]");
		System.out.println("[수정할 연락처 검색]\n이름 입력>>");
		String searchName = scan.next();
		int idx = searchIdx(searchName);
		if( idx > -1) {
			//연락처의 수정 작업
			System.out.println("수정할 연락처가 검색되었습니다.");
			System.out.println("[1]이름수정 [2]번호수정>>");
			int selectType = scan.nextInt();
			switch (selectType) {
			case 1: //이름수정
				System.out.println("수정할 이름입력>>");
				String newName = scan.next();
				String oldName = pbList[idx].getName();
				pbList[idx].setName(newName);
				System.out.println("["+oldName +"] >>" + "["+newName +"]\n으로 수정되었습니다." );
			case 2:
				System.out.println("수정할 번호입력>>");
				String newNum = scan.next();
				String oldNum = pbList[idx].getPhoneNum();
				pbList[idx].setName(newNum);
				System.out.println("["+oldNum +"] >>" + "["+newNum +"]\n으로 수정되었습니다." );
			}
			
		}else {
			System.out.println("검색된 연락처가 없습니다.");
		}
		
	}
//	연락처 삭제 기능: deleteInfo()
//	1.삭제할 연락처를 검색
//	2. 연락처가 검색되었을 경우
//	-연락처를 삭제
//	3.검색되지 않았을 경우
	public void deleteInfo() {
		System.out.println("[수정]");
		System.out.println("[수정할 연락처 검색]\n이름 입력>>");
		String searchName = scan.next();
		int idx = searchIdx(searchName);
		if( idx > -1) {
			//연락처의 삭제작업
			pbList[idx] = null;
			System.out.println("연락처가 삭제되었습니다.");
		}else {
			System.out.println("검색된 연락처가 없습니다.");
		}
		
	}
	}

