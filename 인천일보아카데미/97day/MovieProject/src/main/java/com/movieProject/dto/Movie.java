package com.movieProject.dto;


public class Movie {
	private String mvcode;		//코드
	private String mvtitle;		//제목
	private String mvdirector;	//감독
	private String mvactors;	//배우
	private String mvgerne;		//장르
	private String mvinfo;		//정보
	private String mvopen;		//개봉
	private String mvposter;	//포스터
	private String mvstate;		//상태
	
	public String getMvtitle() {
		return mvtitle;
	}
	public void setMvtitle(String mvtitle) {
		this.mvtitle = mvtitle;
	}
	public String getMvcode() {
		return mvcode;
	}
	public void setMvcode(String mvcode) {
		this.mvcode = mvcode;
	}
	public String getMvdirector() {
		return mvdirector;
	}
	public void setMvdirector(String mvdirector) {
		this.mvdirector = mvdirector;
	}
	public String getMvactors() {
		return mvactors;
	}
	public void setMvactors(String mvactors) {
		this.mvactors = mvactors;
	}

	public String getMvinfo() {
		return mvinfo;
	}
	public void setMvinfo(String mvinfo) {
		this.mvinfo = mvinfo;
	}
	public String getMvopen() {
		return mvopen;
	}
	public void setMvopen(String mvopen) {
		this.mvopen = mvopen;
	}
	public String getMvposter() {
		return mvposter;
	}
	public void setMvposter(String mvposter) {
		this.mvposter = mvposter;
	}
	public String getMvstate() {
		return mvstate;
	}
	public void setMvstate(String mvstate) {
		this.mvstate = mvstate;
	}
	public String getMvgerne() {
		return mvgerne;
	}
	public void setMvgerne(String mvgerne) {
		this.mvgerne = mvgerne;
	}
	
	@Override
	public String toString() {
		return "Movie [mvcode=" + mvcode + ", mvtitle=" + mvtitle + ", mvdirector=" + mvdirector + ", mvactors="
				+ mvactors + ", mvgerne=" + mvgerne + ", mvinfo=" + mvinfo + ", mvopen=" + mvopen + ", mvposter="
				+ mvposter + ", mvstate=" + mvstate + "]";
	}
	
}
