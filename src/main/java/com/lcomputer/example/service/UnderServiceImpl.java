package com.lcomputer.example.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lcomputer.example.mapper.UnderMapper;
import com.lcomputer.example.domain.Under;

@Service("UnderServiceImpl")
public class UnderServiceImpl implements UnderService {
	
	@Autowired UnderMapper undermapper;
	
	@Override
	public void underInsert(Under under) {
		undermapper.underInsert(under);
		undermapper.underGroupUpdate(under);
	}
	
	@Override
	public List<Under> underList(Under under) {
		return undermapper.underList(under);
	}
	
	@Override
	public int underCount(Under under) {
		return undermapper.underCount(under);
	}
	
	@Override
	public void underComment(Under under) {
		undermapper.underComment(under);
		undermapper.underOrderUpdate(under);
		undermapper.underDepthUpdate(under);
	}
	
	@Override
	public void underEdit(Under under) {
		undermapper.underEdit(under);
	}
	
	@Override
	public void underDelete(Under under) {
		undermapper.underDelete(under);
	}
}
