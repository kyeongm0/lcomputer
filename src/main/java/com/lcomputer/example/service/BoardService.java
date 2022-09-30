package com.lcomputer.example.service;

import java.util.List;

import com.lcomputer.example.domain.Board;
import com.lcomputer.example.domain.Pagination;
import com.lcomputer.example.domain.Search;
import com.lcomputer.example.domain.Upload;

public interface BoardService {
	public List<Board> boardList(Board board);
	
	public void boardInsert(Board board);
	
	public Board boardDetail(Board board);
	
	public Board boardEdit(Board board);
	
	public void boardEditProcess(Board board);
	
	public void boardDelete(Board board);
	
	public Board boardReply(Board board);
	
	public void boardReplyProcess(Board board);
	
	public int boardCount();
	
	public List<Board> boardSearch(Board board);
	
	public int searchCount(Search search);
	
	public Board boardInfo(Board board);

}
