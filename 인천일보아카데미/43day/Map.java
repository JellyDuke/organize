package jdbcShop;
import java.util.ArrayList;
import java.util.HashMap;

public class Map {
	public static void main(String[] args) {
//		String sql = "SELECT"; key는 sql 변수 value는 key의 안에 저장되는 값 실제 값 
		//key변수 이름, value 내용 쌍으로 데이터를 저장
		HashMap<String/*keyType*/, String/*String 대신 인티져 사용 가능 valueType*/> odInfo = new HashMap<String,String>();
//		put(key, value);
		odInfo.put("GNAME"/*key*/, "모니터"/*value*/);
		odInfo.put("ODQTY", "1");
//		get(key);
		System.out.println("상품이름 : " +odInfo.get("GNMAE"));
		System.out.println("주문수량 : " +odInfo.get("ODQTY"));

//      구분선 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ    
		
		//SELECT GNAME, GPRICE, ODQTY, (GPRICE *ODQTY), OODATE
		//while(rs.next()) {
		//}
		//key, value 쌍으로 저장
		//rs.next() >> 레코드가 선택
		ArrayList<Goods> goodsList = new ArrayList<Goods>();
		
		ArrayList<HashMap<String,String>> odList = new ArrayList <HashMap<String,String>>();
		
		HashMap<String, String> odod = new HashMap<String,String>();
//		odod.put("GNAME", rs.getString(1));
		odod.put("GNAME", "사이다");
//		odod.put("GPRICE", rs.getInt(2/*GPRICE*/)+"");
		odod.put("GPRICE", 1500 + "");
		odod.put("ODQTY", 2+"");
		odList.add(odod);
		
		odod = new HashMap<>();
		odod.put("GNAME", "컵라면");
//		odod.put("GPRICE", rs.getInt(2/*GPRICE*/)+"");
		odod.put("GPRICE", 1200 + "");
		odod.put("ODQTY", 5+"");
		odList.add(odod);
	}
	
}
