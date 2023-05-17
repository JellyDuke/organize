package p0517;

public class PersonMain {

	public static void main(String[] args) {
		Person person = new Person("박주호",23,"인천");
		person.name = "박주호";
		person.age = 23;
		person.addr = "인천";
//		person.myJob();
		
		Student stu = new Student();//("박주호",23,"인천","인하공전","정보통신학과");
		stu.name = "박주호";
		stu.age = 23;
		stu.addr = "인천";
		stu.univName = "인하공전";
		stu.major = "인천";
//		stu.myJob();
		
		Developer dev = new Developer();
		dev.name = "박주호";
		dev.age = 23;
		dev.addr = "인천";
		dev.langType = "자바";
		dev.company = "인천일보";
//		dev.myJob();
		
		PersonService psvc = new PersonService();
		psvc.choiceType(dev);
		
//		Animal animalObj = new Dog() 동물은 개이다. 동물안에 개가 있다. 포함이다.
		Person personSTU = new Student();
//		if(personSTU instanceof Student) { ins + cntrl + spacebar
//		}
//		Dog dogObj = new Animal() 개는 동물이다. 개안에 동물이 있다. 그럴 수 없기에 new Person에 오류
//		Student stuPerson = new Person(); person기반으로 상속되어 있는 student이기에 person이 오류가 난다.
//		부모개체로 자식개체를 만들 수 있다.
		
		Person personDEV = new Developer();

	}
}
