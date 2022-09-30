package com.lcomputer.example.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.lcomputer.example.domain.Board;
import com.lcomputer.example.domain.Pagination;
import com.lcomputer.example.domain.Search;
import com.lcomputer.example.mapper.BoardMapper;

@Service("BoardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	@Autowired BoardMapper boardmapper;
	@Override
	public List<Board> boardList(Board board) {
		return boardmapper.boardList(board);
	}
	
	@Override
	public void boardInsert(Board board) {
		boardmapper.boardInsert(board);
		boardmapper.groupUpdate(board);
	}
	
	@Override
	public Board boardDetail(Board board) {
		boardmapper.boardHitscount(board);
		return boardmapper.boardDetail(board);
		
	}
	
	@Override
	public Board boardEdit(Board board) {
		return boardmapper.boardEdit(board);
	}
	
	@Override
	public void boardEditProcess(Board board) {
		boardmapper.boardEditProcess(board);
	}
	
	@Override
	public void boardDelete(Board board) {
		boardmapper.boardDelete(board);
	}
	
	@Override
	public Board boardReply(Board board) {
		return boardmapper.boardReply(board);
	}
	
	@Override
	public void boardReplyProcess(Board board) {
		boardmapper.boardReplyProcess(board);
		boardmapper.orderUpdate(board);
		boardmapper.depthUpdate(board);
	}
	
	@Override
	public int boardCount() {
		return boardmapper.boardCount();
	}
	
	@Override
	public List<Board> boardSearch(Board board) {
		return boardmapper.boardSearch(board);
	}
	
	@Override
	public int searchCount(Search search) {
		return boardmapper.searchCount(search);
	}
	
	@Override
	public Board boardInfo(Board board) {
		return boardmapper.boardInfo(board);
	}
}
