package com.spring_memberBoard.dto;

public class Reply {
	private int renum;			//댓글 번호
	private int rebno;			//게시글 번호
	private String remid;		//작성자
	private String recomment;	//내용
	private String redate;		//작성일
	private String restate;		//상태
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public int getRebno() {
		return rebno;
	}
	public void setRebno(int rebno) {
		this.rebno = rebno;
	}
	public String getRemid() {
		return remid;
	}
	public void setRemid(String remid) {
		this.remid = remid;
	}
	public String getRecomment() {
		return recomment;
	}
	public void setRecomment(String recomment) {
		this.recomment = recomment;
	}
	public String getRedate() {
		return redate;
	}
	public void setRedate(String redate) {
		this.redate = redate;
	}
	public String getRestate() {
		return restate;
	}
	public void setRestate(String restate) {
		this.restate = restate;
	}
	@Override
	public String toString() {
		return "Reply [renum=" + renum + ", rebno=" + rebno + ", remid=" + remid + ", recomment=" + recomment
				+ ", redate=" + redate + ", restate=" + restate + "]";
	}
	
	
}
