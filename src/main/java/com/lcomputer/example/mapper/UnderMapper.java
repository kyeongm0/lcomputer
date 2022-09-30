package com.lcomputer.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.lcomputer.example.domain.Under;

@Mapper
public interface UnderMapper {
	public void underInsert(Under under);
	
	public List<Under> underList(Under under);
	
	public int underCount(Under under);
	
	public void underGroupUpdate(Under under);
	
	public void underComment(Under under);
	
	public void underOrderUpdate(Under under);
	
	public void underDepthUpdate(Under under);
	
	public void underEdit(Under under);
	
	public void underDelete(Under under);
}
