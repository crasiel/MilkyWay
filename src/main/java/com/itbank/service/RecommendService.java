package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.recommend.RecommendDAO;
import com.itbank.recommend.RecommendDTO;

@Service
public class RecommendService {

	@Autowired private RecommendDAO dao;
	
	public RecommendDTO selecOne(RecommendDTO dto) {
		return dao.selectOne(dto);
	}

	public int insert(RecommendDTO dto) {
		return dao.insert(dto);
	}

	public int count(RecommendDTO dto) {
		return dao.count(dto);
	}

	public int delete(RecommendDTO dto) {
		return dao.delete(dto);
	}

	public int count1(int reply_idx) {
		return dao.count1(reply_idx);
	}

}
