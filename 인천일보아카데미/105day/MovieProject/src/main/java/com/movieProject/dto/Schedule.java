package com.movieProject.dto;

public class Schedule {
	private String mvcode;	//영호코드
	private String thcode;	//극장코드
	private String schall;	//상영관
	private String scdate; 	//날짜 및 시간
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
	@Override
	public String toString() {
		return "Schedule [mvcode=" + mvcode + ", thcode=" + thcode + ", schall=" + schall + ", scdate=" + scdate + "]";
	}
	
	
}
