package com.lcomputer.example.service;

import java.util.List;

import com.lcomputer.example.domain.Upload;

public interface UploadService {
	public void uploadInsert(Upload upload);
	
	public void uploadDelete(Upload upload);
	
	public List<Upload> uploadRead(Upload upload);
}
