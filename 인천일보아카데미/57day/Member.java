package dto;

public class Member {
	private String mid;   //아이디
	private String mpw;	  //비밀번호
	private String mname; //이름
	private String mbirth;//생년월일
	private String maddr; //주소
	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMbirth() {
		return mbirth;
	}
	public void setMbirth(String mbirth) {
		this.mbirth = mbirth;
	}
	public String getMaddr() {
		return maddr;
	}
	public void setMaddr(String maddr) {
		this.maddr = maddr;
	}
	@Override
	public String toString() {
		return "Member [mid=" + mid + ", mpw=" + mpw + ", mname=" + mname + ", mbirth=" + mbirth + ", maddr=" + maddr
				+ "]";
	}
	
	
}
