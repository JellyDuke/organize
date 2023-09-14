package com.movieProject.dto;

public class Theater {
	private String thcode;	//코드
	private String thname;	//이름
	private String thaddr;	//주소
	private String thtel;	//전화번호
	private String thinfo;	//정보
	private String thimg;	//이미지URL
	public String getThcode() {
		return thcode;
	}
	public void setThcode(String thcode) {
		this.thcode = thcode;
	}
	public String getThname() {
		return thname;
	}
	public void setThname(String thname) {
		this.thname = thname;
	}
	public String getThaddr() {
		return thaddr;
	}
	public void setThaddr(String thaddr) {
		this.thaddr = thaddr;
	}
	public String getThtel() {
		return thtel;
	}
	public void setThtel(String thtel) {
		this.thtel = thtel;
	}
	public String getThinfo() {
		return thinfo;
	}
	public void setThinfo(String thinfo) {
		this.thinfo = thinfo;
	}
	public String getThimg() {
		return thimg;
	}
	public void setThimg(String thimg) {
		this.thimg = thimg;
	}
	
	@Override
	public String toString() {
		return "Theater [thcode=" + thcode + ", thname=" + thname + ", thaddr=" + thaddr + ", thtel=" + thtel
				+ ", thinfo=" + thinfo + ", thimg=" + thimg + "]";
	}
}
