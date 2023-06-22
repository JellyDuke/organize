package jdbcShop;

public class Order {
	private String odcode;  //주문코드
	private String odmid;	//주문자 아이디
	private String odgcode; //주문한 상품코드	
	private int odqty;	//주문수량
	public String getOdcode() {
		return odcode;
	}
	public void setOdcode(String odcode) {
		this.odcode = odcode;
	}
	public String getOdmid() {
		return odmid;
	}
	public void setOdmid(String odmid) {
		this.odmid = odmid;
	}
	public String getOdgcode() {
		return odgcode;
	}
	public void setOdgcode(String odgcode) {
		this.odgcode = odgcode;
	}
	public int getOdqty() {
		return odqty;
	}
	public void setOdqty(int odqty) {
		this.odqty = odqty;
	}

	
}
//ODCODE NVARCHAR2(5), --주문코드 PK
//ODMID NVARCHAR2(10), --주문아이디 FK
//ODGCODE NVARCHAR2(5),--주문상품 FK
//ODQTY NUMBER,        --주문수량
//ODDATE DATE          --주문일시