package com.lcomputer.example.domain;

public class Pagination {
	int count;
	int page;
	int pageNum;
	int startPage;
	int endPage;
	int lastPage;
	int prevPage;
	int nextPage;
	public static final int pageUnit=3;
	public static final int perPage=3;
	private Search search;

	public Pagination() {
		
	}
	
	
	
	public Search getSearch() {
		return search;
	}

	public void setSearch(Search search) {
		this.search = search;
	}



	public void page() {
		pageNum = (page-1)*perPage;
		startPage=((page-1)/pageUnit)*pageUnit+1;
		endPage=startPage+pageUnit-1;
		lastPage=(int)Math.ceil(count / (float)perPage);
		endPage=endPage<lastPage ? endPage : lastPage;
		prevPage=(startPage-pageUnit);
		nextPage=(startPage+pageUnit);
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPage() {
		return page;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public int getPerPage() {
		return perPage;
	}
	public int getPrevPage() {
		return prevPage;
	}
	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	@Override
	public String toString() {
		return "Pagination [count=" + count + ", page=" + page + ", pageNum=" + pageNum + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", lastPage=" + lastPage + ", prevPage=" + prevPage + ", nextPage="
				+ nextPage + "]";
	}
}
