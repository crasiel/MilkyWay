package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.reply.R_ReplyDTO;
import com.itbank.reply.ReplyDAO;
import com.itbank.reply.ReplyDTO;
@Service
public class ReplyService {
	@Autowired private ReplyDAO dao;

	public int insertReply(ReplyDTO dto) {
		return dao.insertReply(dto);
	}

	public List<ReplyDTO> selectReplyAll(int idx) {
		return dao.selectReplyAll(idx);
	}

	public int delete(int reply_idx) {
		return dao.delete(reply_idx);
	}

	public int insertR_Reply(R_ReplyDTO r_dto) {
		return dao.insertR_Reply(r_dto);
	}

	public List<R_ReplyDTO> selectR_ReplyAll(int idx) {
		return dao.selectR_ReplyAll(idx);
	}

	public int deleteR_Reply(int r_reply_idx) {
		return dao.deleteR_Reply_idx(r_reply_idx);
	}

	public List<ReplyDTO> selectAll() {
		return dao.selectAll();
	}
	
}
