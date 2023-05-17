package p0517;

public class Person {
	public void myJob() {
		System.out.println("나는 person입니다.");
	}
	
	String name;
	int age;
	String addr;
	
	public Person(String name, int age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}
	
	public Person() {
	}
}
