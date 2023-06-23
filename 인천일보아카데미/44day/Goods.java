package jdbcShop;

public class Goods {
	private String gcode;   //상품코드
	private String gname;	//상품이름
	private int gprice;		//상품가격
	private String gtype;	//상품종류
	private int gstock;	//상품재고
	private String gstate;
	
	public String getGstate() {
		return gstate;
	}
	public void setGstate(String gstate) {
		this.gstate = gstate;
	}
	public int getGstock() {
		return gstock;
	}
	public void setGstock(int gstock) {
		this.gstock = gstock;
	}
	public String getGcode() {
		return gcode;
	}
	public void setGcode(String gcode) {
		this.gcode = gcode;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public int getGprice() {
		return gprice;
	}
	public void setGprice(int gprice) {
		this.gprice = gprice;
	}
	public String getGtype() {
		return gtype;
	}
	public void setGtype(String gtype) {
		this.gtype = gtype;
	}
}

//GCODE NVARCHAR2(5),    --상품코드PK
//GNAME NVARCHAR2(30), --상품이름NOTNULL
//GPRICE NUMBER, -- 상품가격DEFAULT 1000
//GTYPE NVARCHAR2(10), -- 상품종류
//GSTOCK NUMBER --상품 재고