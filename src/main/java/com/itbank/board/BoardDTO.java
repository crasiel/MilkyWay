package com.itbank.board;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class BoardDTO {

//	TABLE : GALLERY
//	IDX              NOT NULL NUMBER        
//	ORIGINALFILENAME NOT NULL VARCHAR2(500) 
//	STOREDFILENAME   NOT NULL VARCHAR2(500) 
//	UPLOADDATE                VARCHAR2(500)
	
	private int idx;
	private String originalFileName, storedFileName, uploadDate, content, writer, hashtag;
	private MultipartFile uploadFile; 
	private String[] fileList;
	


	public String[] getFileList() {
		return fileList;
	}

	public void setFileList(String[] fileList) {
		this.fileList = fileList;
	}

	public boolean ready(MultipartHttpServletRequest req) {
		// uploadFile을 이용하여, originalFileName과 storedFileName값을 만든다
		
		 List<MultipartFile> mf = req.getFiles("uploadFile");
	     String uploadFile2 = "";
	    
		if(mf != null) {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
			String now = sdf.format(new Date());
			
		    for(MultipartFile m : mf) {
	        	System.out.println("--------------------------------------");
	        	if(mf.indexOf(m) == (mf.size()-1)) {
	        		originalFileName = uploadFile.getOriginalFilename();
	        		uploadFile2 = uploadFile2 + now + m.getOriginalFilename();
	        	}else {
	        		originalFileName = uploadFile.getOriginalFilename();
	        		uploadFile2 = uploadFile2 + now + m.getOriginalFilename() + "/";
	        	}
	        	System.out.println("123 : "+m.getOriginalFilename());
	        }
			
			storedFileName = uploadFile2;
			System.out.println("uploadFile2 : " + uploadFile2);
			return true;
		}
		
		return false;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getStoredFileName() {
		return storedFileName;
	}
	public void setStoredFileName(String storedFileName) {
		this.storedFileName = storedFileName;
	}
	public String getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	
	
}
