package p0517;

public class Student extends Person{
	
	String univName;
	String major;
	
	@Override
	public void myJob() {
		System.out.println("나는 student입니다.");
	}
	
//	public Student(String name, int age, String addr) {
//		super(name,age,addr);
//	}
//	public Student(String name, int age, String addr, String univName, String major) {
//		super(name,age,addr);
//		this.univName = univName;
//		this.major = major;
//	}
}
