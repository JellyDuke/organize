package p0516;
import java.util.ArrayList;
public class Ex02_ArrayList {
	public static void main(String[] args) {
		ArrayList<String> strList = new ArrayList<String>();
		strList.add("A"); //0번 인덱스에 "A"저장
		strList.add("B"); //1번 인덱스에 "B"저장
		strList.add("C"); //2번 인덱스에 "A"저장
		System.out.println("0번 인덱스 " +strList.get(0));
		System.out.println("1번 인덱스 " +strList.get(1));
		System.out.println("2번 인덱스 " +strList.get(2));
		System.out.println("size : " +strList.size());
		strList.add(1, "D"); //add 추가의 개념
		System.out.println("size : " +strList.size());
		System.out.println("0번 인덱스 " +strList.get(0));
		System.out.println("1번 인덱스 " +strList.get(1));
		System.out.println("2번 인덱스 " +strList.get(2));
		System.out.println("3번 인덱스 " +strList.get(3)); //add 1번인덱스에 만들었더니 기존 C가 밀려서 출력
//		System.out.println("4번 인덱스 " +strList.get(4)); error 
		//그래서 size를 보면 4로 나옴
		strList.remove(2);
		System.out.println("strList.remove(2) 실행 후 ");
		System.out.println("size : " +strList.size()); //3size가 나옴
		System.out.println("0번 인덱스 " +strList.get(0));
		System.out.println("1번 인덱스 " +strList.get(1));
		System.out.println("2번 인덱스 " +strList.get(2));

		strList.remove("D");
		System.out.println("strList.remove(\"D\") 실행후 ");
		System.out.println("size : " +strList.size());
		System.out.println("0번 인덱스 " +strList.get(0));
		System.out.println("1번 인덱스 " +strList.get(1));
		
		System.out.println("for문");
		for(int i = 0; i< strList.size(); i++) {
			System.out.println(i+"번인덱스: " + strList.get(i));
		}
		ArrayList<Member> memList = new ArrayList<Member>();
		Member[] memArr = new Member[5];
		System.out.println("ArrayList 시작");
		for(int i = 0; i< memList.size(); i++) {
			System.out.println(memList.get(i).getMid());
		}
		
		System.out.println("Array 시작");
		for(int i = 0; i< memArr.length; i++) {
			System.out.println(memArr[i].getMid());
		}
		System.out.println("Array 종료");
	}
}
