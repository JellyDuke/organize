package p0517;
public class InheritanceMain {
	public static void main(String[] args) {
		Parent prt = new Parent();
		prt.parentMethod();
		
		Child chd = new Child();
		chd.ParentField = "";
		chd.parentMethod();
		
		ParentClass parent = new ParentClass(1,"parent"); //매개변수 있어야함. parentClass에 변수가 2개 지정됨.
		ChildClass child = new ChildClass();
		
	}
}
