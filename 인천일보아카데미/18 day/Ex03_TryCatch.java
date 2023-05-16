package p0516;
import java.util.InputMismatchException;
import java.util.Scanner;
public class Ex03_TryCatch {
	public static void main(String[] args) {
		//예외처리
//		try {
//			실행할 코드
//		} catch() { //예외 상황 코드
//		}
		System.out.println("시작");
		Member[] memArr = new Member[3];
		String mid = null;
		try { //try 블럭 안에 있는 문장 실행이 되다가 catch 예외 문제는 블럭 안에서 실행 catch에서
//			만약 try 문법이 정상작동을 한다면 catch문이 작동을 안함.
			
			mid = memArr[0].getMid(); //java.lang.NullPointerException
		} catch(NullPointerException e) { //e객체 만듦
			System.out.println("catch - NullPointerException 예외 발생 ");
			mid = "te:st";
		}
		System.out.println("회원 아이디 : "+ mid); //null값이라 예외 나옴 
		System.out.println(mid.split(":")[0]);
		System.out.println("처리 후 실행");
		System.out.println("종료");

		int num = 10;
		try {
			int result = 10 / num;
			System.out.println(result);
			System.out.println(memArr[0].getMid());
			
		}catch(ArithmeticException e) {
			System.out.println("ArithmeticException 예외 발생");
		}catch(NullPointerException e) {
			System.out.println("NullPointerException 예외 발생");
		}catch(Exception e) { //모든 예외 잡기
			System.out.println("Exception 예외 발생");
		}
		System.out.println("확인 ");
		Scanner scan = new Scanner(System.in);
		System.out.println("메뉴선택>>");
		int selectMenu = 0;
		try {
			selectMenu = scan.nextInt();
		}catch (InputMismatchException e) {
			System.out.println("숫자만 입력 해주세요!");
		}finally { //무조건적인 실행
			System.out.println("무조건 실행");
		}
		System.out.println(selectMenu);
	}
}