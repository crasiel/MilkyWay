package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itbank.board.BoardDAO;
import com.itbank.board.BoardDTO;
import com.itbank.board.Hashtag;

@Service
public class BoardService {

	
	@Autowired private BoardDAO dao;
	
	private final String uploadPath = "C:\\upload";
	
	
	public BoardService() {
		File dir = new File(uploadPath);
		if(dir.exists() == false) {
			dir.mkdirs(); 		
		}
	}
	
	public List<String> getList() {
		File dir = new File(uploadPath);
		if(dir.exists()) {
			String[] fileNames = dir.list();
			List<String> list = Arrays.asList(fileNames);	
			System.out.println(list);
			return list;
		}
		return null;
	}

	public boolean upload(MultipartFile uploadFile) {
		
		File target = new File(uploadPath, uploadFile.getOriginalFilename());
		
		if(uploadFile.getContentType().contains("image")) {
			try {
				uploadFile.transferTo(target);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		return target.exists(); 	
	}

	public int insert(BoardDTO dto, MultipartHttpServletRequest req) {
		int row = 0;
		if(dto.ready(req)) {
			System.out.println("dto.getStoredFileName(): "+dto.getStoredFileName());
			String[] file = dto.getStoredFileName().split("/");
			
			try {
				List<MultipartFile> mf = req.getFiles("uploadFile");
				for(MultipartFile m : mf) {
					dto.setUploadFile(m);
					String s = file[mf.indexOf(m)];
					System.out.println("mf.index : "+ mf.indexOf(m));
					System.out.println("s : "+s);
					File target = new File(uploadPath, s);	
					dto.getUploadFile().transferTo(target);
				}
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			row = dao.insert(dto);
		}
		return row;
	}

	public  List<BoardDTO> getBoardList() {
		return dao.selectBoardList();
	}

	public int hashInsert(String hashtag) {
		List<Hashtag> hashtagList = dao.getHash();
		for(Hashtag tag : hashtagList) {
			System.out.println("service hash : " + tag.getHashtag());
			if(tag.getHashtag().equals(hashtag) ) {
				System.out.println("plustCnt 실행");
				return dao.plusCnt(hashtag);
			}
		}
		return dao.hashInsert(hashtag);
	}

	public BoardDTO selectOne(int idx) {
		return dao.selectOne(idx);
	}

	public List<Hashtag> selectHashList() {
		return dao.selectHashList();
	}

	public List<BoardDTO> getSearchList(String hashtag) {
		return dao.getSearchList(hashtag);
	}
	
}
