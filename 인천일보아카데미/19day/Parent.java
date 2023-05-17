package p0517;
public class Parent {
	String ParentField; //private로 접근 제한
	
	protected String protectedField;
	String defaultField;
	
	void parentMethod() {
		System.out.println("부모클래스에 정의된 parentMethod()");
	}
	int testMethod() {
		System.out.println("testMethod() 호출");
		return 1;
	}
}
