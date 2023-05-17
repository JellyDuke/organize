package p0517;
public class ChildClass extends ParentClass {
	// 상속을 받았기에 오류가 남
	// 이유는 기본 생성자가 없고 변수가 2개. 생성자가 있어야 호출 하고 만들어짐. 부모 객체가 먼저 있어야함.(생성자)
	// 기본 생성자가 없을경우는
	public ChildClass(int parentInt, String parentStr) {
		super(parentInt, parentStr); //spuer는 부모 클래스를 의미 
		// source 의 generate superclass를 만듦.
	}

	public ChildClass() {
		super(); //생성자의 기본 형식임 super가 상속받는 입장에서는 super 기본적으로 만들어야함.
		// 위처럼 만들어 놓을경우 부모 클래스에서는 생성자를 안만들어도 되지만 이렇게 기본형태로만 할 경우에는
//		부모클래스에서 생성자를 만들어 놔야한다.
	}
	
}
