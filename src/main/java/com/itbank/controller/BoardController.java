package com.itbank.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.board.BoardDTO;
import com.itbank.board.Hashtag;
import com.itbank.member.MemberDTO;
import com.itbank.recommend.RecommendDTO;
import com.itbank.reply.R_ReplyDTO;
import com.itbank.reply.ReplyDTO;
import com.itbank.service.BoardService;
import com.itbank.service.RecommendService;
import com.itbank.service.ReplyService;

@Controller
@RequestMapping("/")
public class BoardController {
	
	@Autowired private BoardService bs;
	@Autowired private ReplyService rs;
	@Autowired private RecommendService rcs;
	
	@GetMapping("/{hashtag}")
	public ModelAndView hashtag2(@PathVariable String hashtag) {
		ModelAndView mav = new ModelAndView();
		List<BoardDTO> b = bs.getSearchList(hashtag);
		for(BoardDTO m : b) {
			m.setFileList(m.getStoredFileName().split("/"));
			}
		List<Hashtag> hashList = bs.selectHashList();

		mav.addObject("hashList", hashList);
		mav.addObject("list", b);
		mav.addObject("hashtag", hashtag);
		mav.setViewName("hashtag");
		
		return mav;
	}
	
	
	@GetMapping("/hashSearch")
	public ModelAndView hashtag(@RequestParam String search) {
		ModelAndView mav = new ModelAndView();
		List<BoardDTO> b = bs.getSearchList(search);
		for(BoardDTO m : b) {
//			System.out.println(m.getStoredFileName());
//			String[] file = m.getStoredFileName().split("/");
			m.setFileList(m.getStoredFileName().split("/"));
//			for(int i=0; i < m.getFileList().length; i++) {
//				System.out.println(m.getFileList()[i]);
			}
		List<Hashtag> hashList = bs.selectHashList();

		mav.addObject("hashList", hashList);
		mav.addObject("list", b);
		mav.addObject("hashtag", search);
		mav.setViewName("hashtag");
		
		return mav;
	}
	
	
	@PostMapping("")
	@ResponseBody
	public String board(BoardDTO dto, MultipartHttpServletRequest req) {
		System.out.println("content : " + dto.getContent());
		System.out.println("hashtag : " + dto.getHashtag());
		String[] hash = dto.getHashtag().split("#");
		for(int i =1; i < hash.length; i++) {
			bs.hashInsert(hash[i]);
		}
		int row = bs.insert(dto, req);
		return row+"";
	}
	
	@GetMapping("")
	public ModelAndView board(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		List<BoardDTO> b = bs.getBoardList();
		for(BoardDTO m : b) {
			m.setFileList(m.getStoredFileName().split("/"));
		}
		mav.addObject("list", b);
		
//		hashtag 상위 10개
		List<Hashtag> hashList = bs.selectHashList();
		mav.addObject("hashList", hashList);
		
		mav.setViewName("home");
		
	      List<ReplyDTO> reList = rs.selectAll();
	  		MemberDTO dto=(MemberDTO) session.getAttribute("login");
			RecommendDTO Rdto=new RecommendDTO();
			Rdto.setNick(dto.getMember_nick());
			List<ReplyDTO> reList1 = new ArrayList<ReplyDTO>();
			Iterator<ReplyDTO> it = reList.iterator();
			while(it.hasNext()) {
				ReplyDTO redto=it.next();
				Rdto.setReply_idx(redto.getReply_idx());
				redto.setCount(rcs.count(Rdto));
				if(rcs.selecOne(Rdto)!=null) {
					redto.setRecommend(true);
				}
				reList1.add(redto);
				}

				mav.addObject("reList", reList1);

				return mav;
	      }
		
	@GetMapping("/read/{idx}")
	   public ModelAndView read(@PathVariable int idx,HttpSession session) {
	      ModelAndView mav = new ModelAndView("read");
	      BoardDTO read = bs.selectOne(idx);
	      read.setFileList(read.getStoredFileName().split("/"));
	      mav.addObject("read", read);
	      
	      // ----- reply 댓글 -----
	      List<ReplyDTO> reList = rs.selectReplyAll(idx);
	  		MemberDTO dto=(MemberDTO) session.getAttribute("login");
			RecommendDTO Rdto=new RecommendDTO();
			Rdto.setNick(dto.getMember_nick());
			List<ReplyDTO> reList1 = new ArrayList<ReplyDTO>();
			if(reList != null) {
				Iterator<ReplyDTO> it = reList.iterator();
				while(it.hasNext()) {
					ReplyDTO redto=it.next();
					Rdto.setReply_idx(redto.getReply_idx());
					redto.setCount(rcs.count(Rdto));
					if(rcs.selecOne(Rdto)!=null) {
						redto.setRecommend(true);
					}
					reList1.add(redto);
				}

				mav.addObject("reList", reList1);

	      }
	      
	      
	      
	      //------ r_reply 대댓글 ------------   
//	      for(ReplyDTO rdto : reList) {
//	         
//	      }
	      List<R_ReplyDTO> r_reList = rs.selectR_ReplyAll(idx);
	      if(r_reList != null) {
	         mav.addObject("r_reList", r_reList);
	      }
	      return mav;
	   }
	   
	   @PostMapping("/read/{idx}")
	   public String insertReply(@PathVariable int idx, ReplyDTO dto, R_ReplyDTO r_dto) {
	      int row = 0;
	      if(dto.getType() == 1) {
	         row = rs.insertR_Reply(r_dto);
	      }else {
	         row = rs.insertReply(dto);
	      }
	      
	      return "redirect:/read/" + idx;
	   }
	   
	   @GetMapping("read/deleteReply/{reply_idx}")
	   public String delete(@PathVariable int reply_idx, int idx, int r_reply_idx) {
	      if(r_reply_idx == 0) {
	         int row = rs.delete(reply_idx);
	      }else {
	         int row = rs.deleteR_Reply(r_reply_idx);
	      }

	      return "redirect:/read/" + idx;
	   }
	   
		@PostMapping("/recommend/")
		@ResponseBody
		public String recommend(RecommendDTO dto) {
			RecommendDTO One = rcs.selecOne(dto);
			if(One==null) {
				int row = rcs.insert(dto);
				int count = rcs.count(dto);
				return count+"";
			}
			int count = rcs.count(dto);
			return count+"";
		}
		
		@PostMapping("recommend/discount/")
		@ResponseBody
		public String discount(RecommendDTO dto) {
			RecommendDTO One = rcs.selecOne(dto);
			if(One==null) {
				int count = rcs.count(dto);
				return count+"";
			}
			int row = rcs.delete(dto);
			int count = rcs.count(dto);
			return count+"";
		}
	   
}
