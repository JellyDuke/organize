package com.spring_memberBoard.dto;
import org.springframework.web.multipart.MultipartFile;

public class Board {
	private int bno;     //번호
	private String bwriter;//작성자
	private String btitle; //제목
	private String bcontents;//내용
	private int bhits;//조회수
	private String bdate;//작성일
	private String bstate;//상태
		
	private String bfilename; //파일 이름
	private MultipartFile bfile; //첨부파일
	
	private int recount; //댓글 수 저장할 필드
	
	public int getRecount() {
		return recount;
	}
	public void setRecount(int recount) {
		this.recount = recount;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getBwriter() {
		return bwriter;
	}
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcontents() {
		return bcontents;
	}
	public void setBcontents(String bcontents) {
		this.bcontents = bcontents;
	}
	public int getBhits() {
		return bhits;
	}
	public void setBhits(int bhits) {
		this.bhits = bhits;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getBstate() {
		return bstate;
	}
	public void setBstate(String bstate) {
		this.bstate = bstate;
	}
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
	@Override
	public String toString() {
		return "Board [bno=" + bno + ", bwriter=" + bwriter + ", btitle=" + btitle + ", bcontents=" + bcontents
				+ ", bhits=" + bhits + ", bdate=" + bdate + ", bstate=" + bstate + ", bfilename=" + bfilename
				+ ", bfile=" + bfile + ", recount=" + recount + "]";
	}
		
}

