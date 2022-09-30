package com.lcomputer.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lcomputer.example.domain.Upload;
import com.lcomputer.example.mapper.UploadMapper;

@Service("UploadServiceImpl")
public class UploadServiceImpl implements UploadService {
	
	@Autowired UploadMapper uploadmapper;
	
	@Override
	public void uploadInsert(Upload upload) {
		uploadmapper.uploadInsert(upload);
	}
	
	@Override
	public void uploadDelete(Upload upload) {
		uploadmapper.uploadDelete(upload);
	}
	
	@Override
	public List<Upload> uploadRead(Upload upload) {
		return uploadmapper.uploadRead(upload);
	}
}
