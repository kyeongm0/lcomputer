package com.lcomputer.example.domain;

import java.util.List;
import java.util.Optional;

public class Board {
	private int bIdx;
	private String bTitle;
	private String bContent;
	private String bDate;
	private int bHits;
	private int bGroup;
	private int bOrder;
	private int bDepth;
	private int bOrigin;
	private int uIdx;
	private User user;
	private int rownum;
	private Pagination pagination;
	private Upload upload;
	private List<Upload> uploadList;
	
	
	


	
	public List<Upload> getUploadList() {
		return uploadList;
	}
	public void setUploadList(List<Upload> uploadList) {
		this.uploadList = uploadList;
	}
	public Upload getUpload() {
		return upload;
	}
	public void setUpload(Upload upload) {
		this.upload = upload;
	}
	public Pagination getPagination() {
		return pagination;
	}
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getuIdx() {
		return uIdx;
	}
	public void setuIdx(int uIdx) {
		this.uIdx = uIdx;
	}
	public int getbOrigin() {
		return bOrigin;
	}
	public void setbOrigin(int bOrigin) {
		this.bOrigin = bOrigin;
	}
	public int getbGroup() {
		return bGroup;
	}
	public void setbGroup(int bGroup) {
		this.bGroup = bGroup;
	}
	public int getbOrder() {
		return bOrder;
	}
	public void setbOrder(int bOrder) {
		this.bOrder = bOrder;
	}
	public int getbDepth() {
		return bDepth;
	}
	public void setbDepth(int bDepth) {
		this.bDepth = bDepth;
	}
	public int getbHits() {
		return bHits;
	}
	public void setbHits(int bHits) {
		this.bHits = bHits;
	}
	public int getbIdx() {
		return bIdx;
	}
	public void setbIdx(int bIdx) {
		this.bIdx = bIdx;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	
	
}
