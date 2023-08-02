package com.spring_memberBoard.dto;

public class Bus {
	private String nodenm; 			  //정류소명
	private String routeid;			  //노선번호
	private String arrprevstationcnt; //남은 정류장 수
	private String arrtime; 		  //도착예정시간

	public String getNodenm() {
		return nodenm;
	}
	public void setNodenm(String nodenm) {
		this.nodenm = nodenm;
	}
	public String getRouteid() {
		return routeid;
	}
	public void setRouteid(String routeid) {
		this.routeid = routeid;
	}
	public String getArrprevstationcnt() {
		return arrprevstationcnt;
	}
	public void setArrprevstationcnt(String arrprevstationcnt) {
		this.arrprevstationcnt = arrprevstationcnt;
	}
	public String getArrtime() {
		return arrtime;
	}
	public void setArrtime(String arrtime) {
		this.arrtime = arrtime;
	}
	@Override
	public String toString() {
		return "Bus [nodenm=" + nodenm + ", routeid=" + routeid + ", arrprevstationcnt=" + arrprevstationcnt
				+ ", arrtime=" + arrtime + "]";
		
	}
}
