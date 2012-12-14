package com.yecoo.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MyHandlerInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		//就简单判断了一下，如果要详细控制可以用spring security
		String url = request.getRequestURI();
		if(url.endsWith("login")) {
			return true;
		}
		if(request.getSession() != null && request.getSession().getAttribute(Constants.USER_INFO_SESSION) != null) {
			return true;
		}
		PrintWriter out = response.getWriter();
		out.print("<script>window.top.document.location.href='./login'</script>");
		return false;
	}
}
