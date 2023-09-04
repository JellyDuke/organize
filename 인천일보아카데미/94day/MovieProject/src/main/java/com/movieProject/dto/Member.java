package com.movieProject.dto;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private String mid;
	private String mpw;
	private String mname;
	private String memail;
	private String mdate;
	private String mprofile;
	private String mstate;
	
	private MultipartFile bfile;//첨부파일
	private String bfilename; //파일 이름

	
	
	
	public String getBfilename() {
		return bfilename;
	}
	public void setBfilename(String bfilename) {
		this.bfilename = bfilename;
	}
	public MultipartFile getBfile() {
		return bfile;
	}
	public void setBfile(MultipartFile bfile) {
		this.bfile = bfile;
	}
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
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getMprofile() {
		return mprofile;
	}
	public void setMprofile(String mprofile) {
		this.mprofile = mprofile;
	}
	public String getMstate() {
		return mstate;
	}
	public void setMstate(String mstate) {
		this.mstate = mstate;
	}
	
	@Override
	public String toString() {
		return "Member [mid=" + mid + ", mpw=" + mpw + ", mname=" + mname + ", memail=" + memail + ", mdate=" + mdate
				+ ", mprofile=" + mprofile + ", mstate=" + mstate + ", bfile=" + bfile + ", bfilename=" + bfilename
				+ "]";
	}
	
}
