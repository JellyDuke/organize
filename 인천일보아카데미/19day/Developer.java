package p0517;

public class Developer extends Person {
	
	@Override
	public void myJob() {
		System.out.println("나는 Developer입니다.");
	}
	
	String langType;
	String company;
	
//	public Developer(String name, int age, String addr, String langType, String company) {
//		super();
//		this.name = name;
//		this.age = age;
//		this.addr = addr;
//		this.langType = langType;
//		this.company = company;
//	}
}
