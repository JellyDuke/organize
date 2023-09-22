package com.movieProject.dto;

public class Review {
	private String rvcode;
	private String recode;
	private String mid;
	private String rvcomment;
	private String rvdate;
	public String getRvcode() {
		return rvcode;
	}
	public void setRvcode(String rvcode) {
		this.rvcode = rvcode;
	}
	public String getRecode() {
		return recode;
	}
	public void setRecode(String recode) {
		this.recode = recode;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getRvcomment() {
		return rvcomment;
	}
	public void setRvcomment(String rvcomment) {
		this.rvcomment = rvcomment;
	}
	public String getRvdate() {
		return rvdate;
	}
	public void setRvdate(String rvdate) {
		this.rvdate = rvdate;
	}
	@Override
	public String toString() {
		return "Review [rvcode=" + rvcode + ", recode=" + recode + ", mid=" + mid + ", rvcomment=" + rvcomment
				+ ", rvdate=" + rvdate + "]";
	}
	
	
}
