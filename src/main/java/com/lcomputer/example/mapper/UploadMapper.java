package com.lcomputer.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lcomputer.example.domain.Upload;

@Mapper
public interface UploadMapper {
	public void uploadInsert(Upload upload);
	
	public void uploadDelete(Upload upload);
	
	public List<Upload> uploadRead(Upload upload);
}
