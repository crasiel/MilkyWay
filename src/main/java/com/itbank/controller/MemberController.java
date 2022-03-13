package com.itbank.controller;

import java.util.HashMap;
import java.util.Random;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.member.MemberDTO;
import com.itbank.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired private MemberService ms;
	
	
	@GetMapping(value = {(""),("/")})
	public ModelAndView member(@CookieValue(value ="login", required = false) String email) {
		ModelAndView mav=new ModelAndView("/member/member");
		if(email != null) {
			mav.addObject("email", email);
		}
		
		return mav;
	}
	
	@PostMapping(value = "/login/", consumes="application/json; charset=utf-8")
	@ResponseBody
	public String login(@RequestBody HashMap<String, String> param,HttpSession session, HttpServletResponse response) {
		MemberDTO login = ms.selectOne(param);
		if(login!=null) {
			session.setAttribute("login", login);
			if(param.containsKey("cookie")) {
				Cookie cookie = new Cookie("login",login.getMember_email());
				cookie.setMaxAge(60*60*24*30);
				cookie.setPath("/");
				response.addCookie(cookie);
				
			}
			return "1";
		}

		
		return "0";
	}
	
	
	@PostMapping(value = "/join/", consumes="application/json; charset=utf-8")
	@ResponseBody
	public String join(@RequestBody MemberDTO dto) {
		
		int row = ms.insert(dto);		
		if(row==1) {
			
			return row+"";
		}
		
		return "0";
	}
	

	
	@GetMapping("/join/check_email/")
	@ResponseBody
	public String check_email(@RequestParam String email) {
		MemberDTO dto = ms.check_email(email);
		if(dto!=null)
			return 1+"";
		return 0+"";
	}
	
	@GetMapping("/join/check_nick/")
	@ResponseBody
	public String check_nick(@RequestParam String nick) {
		MemberDTO dto = ms.check_nick(nick);
		if(dto!=null)
			return 1+"";
		return 0+"";
	}
	
	@GetMapping("/modify/")
	public ModelAndView modify(HttpSession session) {
		ModelAndView mav=new ModelAndView("/member/modify");
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		mav.addObject("dto", dto);
		return mav;
	}
	
	@PostMapping("/modify/NickandEmail/")
	@ResponseBody
	public String modifyNickandEmail(MemberDTO dto,HttpSession session) {
		MemberDTO login= (MemberDTO) session.getAttribute("login");
		int row =ms.updateEmail(dto.getMember_email(),dto.getMember_nick(),login.getMember_nick());
		if(row==1) {
			login.setMember_email(dto.getMember_email());
			login.setMember_nick(dto.getMember_nick());
			session.setAttribute("login", login);
			return row+"";
		}
		return 2+"";
	}
	
	@PostMapping("/modify/auth/")
	@ResponseBody
	public String modify_pw(@RequestParam HashMap<String, String>param,HttpSession session,HttpServletRequest request) {
		Random random=new Random();
		int lenth=8;
		String auth="";
		for(int i=0;i<lenth;i++) {
			auth+=random.nextInt(10);
		}
		String email=param.get("email");
		session.setAttribute("auth", auth);
		session.setAttribute("email", email);
		String url ="http://localhost:8080"+request.getContextPath()+"/member/auth/";
		if(ms.sendEmail(email, url, auth))
			return 1+"";
		return "";
	}
	@GetMapping("/auth/")
	public ModelAndView auth(@RequestParam String auth,ModelAndView mav,HttpSession session) {

		String sauth=(String) session.getAttribute("auth");
		String email=(String) session.getAttribute("email");
		if(email!=null) {
			if(sauth.equals(sauth)) {
				mav.setViewName("redirect:/member/modify_pw/?auth="+auth);
				return mav;
			}else {
				mav.addObject("msg", "잘못된 접근입니다");
			}
		}else {
			mav.addObject("msg", "잘못된 접근입니다");
		}
		mav.setViewName("msg");
		return mav;
	}
	@GetMapping("/modify_pw/")
	public ModelAndView modify_pw(@RequestParam String auth,HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String sauth=(String) session.getAttribute("auth");
		String email = (String) session.getAttribute("email");
		if(sauth.equals(sauth)) {
			mav.addObject("email", email);
			mav.setViewName("member/modify_pw");
			return mav;
		}
		mav.addObject("msg", "비정상적인 접근입니다");
		mav.setViewName("msg");
		return mav;
		
	}
	@PostMapping("/modify_pw/")
	public ModelAndView modify_pw(@RequestParam HashMap<String, String>param,HttpSession session,ModelAndView mav) {
		int row =ms.updatePw(param);
		if(row==1) {
			session.invalidate();
			mav.addObject("msg", "비밀번호 수정에 성공하였습니다. 다시 로그인해주세요");
		}else{
			mav.addObject("msg", "비밀번호 수정에 실패하셨습니다");
		}
		mav.setViewName("msg");
		return mav;
	}
	
	@GetMapping("/logout/")
	public String logut(HttpSession session) {
		session.invalidate();
		return "redirect:/member";
	}
}
