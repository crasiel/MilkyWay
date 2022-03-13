package com.itbank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class loginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		String requestURL = request.getRequestURL().toString();
	
		HttpSession session = request.getSession();
		if(session.getAttribute("login") == null) {
//			response.sendRedirect(request.getContextPath() + "/member?url=" + requestURL);
			response.sendRedirect(request.getContextPath() + "/member/");
			return false;	// 컨트롤러의 메서드를 진행시키지 않는다
		}
		return true;		// 예정대로 컨트롤러의 메서드를 진행시킨다
	}
}
