package com.lcomputer.example.service;

import java.util.List;
import com.lcomputer.example.domain.Under;

public interface UnderService {
	public void underInsert(Under under);
	
	public List<Under> underList(Under under);
	
	public int underCount(Under under);
	
	public void underComment(Under under);
	
	public void underEdit(Under under);
	
	public void underDelete(Under under);
}
