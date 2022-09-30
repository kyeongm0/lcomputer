package com.lcomputer.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;


import com.lcomputer.example.domain.Board;
import com.lcomputer.example.domain.Pagination;
import com.lcomputer.example.domain.Search;

@Mapper
public interface BoardMapper {
	public List<Board> boardList(Board board);
	
	public void boardInsert(Board board);
	
	public Board boardDetail(Board board);
	
	public Board boardEdit(Board board);
	
	public void boardEditProcess(Board board);
	
	public void boardDelete(Board board);
	
	public void boardHitscount(Board board);
	
	public Board boardReply(Board board);
	
	public void boardReplyProcess(Board board);
	
	public void groupUpdate(Board board);
	
	public void orderUpdate(Board board);
	
	public void depthUpdate(Board board);
	
	public int boardCount();
	
	public List<Board> boardSearch(Board board);
	
	public int searchCount(Search search);
	
	public Board boardInfo(Board board);
}
