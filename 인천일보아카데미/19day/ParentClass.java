package p0517;
public class ParentClass {
	int parentInt;
	String parentStr;
	
	public ParentClass(int parentInt, String parentStr) {
		this.parentInt = parentInt;
		this.parentStr = parentStr;
	}
	public ParentClass() { //이렇게 기본 생성자가 만들어 져야 상속받는 childclass가 오류가 나지 않는다
		super();//부모 클래스에서 spuer(); 를 굳이 사용하지 않아도 됨.
	}
	
}
