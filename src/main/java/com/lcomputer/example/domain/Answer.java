package com.lcomputer.example.domain;

public class Answer {
	private int aIdx;
	private int qIdx;
	private String value;
	private int uIdx;
	private String uName;
	private User user;
	
	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String uName) {
		this.uName = uName;
	}

	public int getaIdx() {
		return aIdx;
	}
	
	public void setaIdx(int aIdx) {
		this.aIdx = aIdx;
	}
	
	public int getqIdx() {
		return qIdx;
	}
	
	public void setqIdx(int qIdx) {
		this.qIdx = qIdx;
	}
	
	public String getValue() {
		return value;
	}
	
	public void setValue(String value) {
		this.value = value;
	}

	public int getuIdx() {
		return uIdx;
	}

	public void setuIdx(int uIdx) {
		this.uIdx = uIdx;
	}
	
	
	
}
