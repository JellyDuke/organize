package p0517;
public class Child extends Parent{ //상속을 받겠다. extends (어떤걸?) Parent를 클래스 지정
	String childVal;
//	@Override 재정의가 아닌 새로 만든다는 개념
	void childMethod() {
		System.out.println(protectedField); //프로텍트경우는 패키지가 달라도 사용 가능함.
		System.out.println(defaultField); //패키지가 다르면 디폴트라고 되어 있는 필드는 사용할 수 없음 부모에게부터 상속 안됨
		System.out.println(childVal);
	}
	//주석과 같은 기능 override 모든 메소드에 붙일 수 없음. 재정의가 되었다는 표시임.
	@Override //상속을 받은 메소드만 가능함. 있거나 없거나, 하지만 개발자 입장에서 빠른 판단됨. 재정의 됬나 안됐나?
	void parentMethod() {
		System.out.println("자식클래스에서 재정의된 parentMethod()");
	}
//	@Override
	int testMethod() {
		System.out.println("testMethod() 호출");
		return 1;
	}
//	해당 메소드는 오버로딩 된것. 
	int testMethod(int number) {
		System.out.println("testMethod() 호출");
		return number+1;
	}
}
