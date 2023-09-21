package com.movieProject.dto;

public class Reserve {
	private String recode;
	private String mid;
	private String mvcode;
	private String thcode;
	private String schall;
	private String scdate;
	private String redate;
	

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
	public String getMvcode() {
		return mvcode;
	}
	public void setMvcode(String mvcode) {
		this.mvcode = mvcode;
	}
	public String getThcode() {
		return thcode;
	}
	public void setThcode(String thcode) {
		this.thcode = thcode;
	}
	public String getSchall() {
		return schall;
	}
	public void setSchall(String schall) {
		this.schall = schall;
	}
	public String getScdate() {
		return scdate;
	}
	public void setScdate(String scdate) {
		this.scdate = scdate;
	}
	public String getRedate() {
		return redate;
	}
	public void setRedate(String redate) {
		this.redate = redate;
	}
	
	@Override
	public String toString() {
		return "Reserve [recode=" + recode + ", mid=" + mid + ", mvcode=" + mvcode + ", thcode=" + thcode + ", schall="
				+ schall + ", scdate=" + scdate + ", redate=" + redate + "]";
	}
	
}
