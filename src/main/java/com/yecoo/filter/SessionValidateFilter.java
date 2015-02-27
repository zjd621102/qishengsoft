package com.yecoo.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.yecoo.util.Constants;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 超时过滤
 * @author zhoujd
 */
public class SessionValidateFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest httpServletRequest = (HttpServletRequest) request;

		String serverName = StrUtils.nullToStr(httpServletRequest.getServletPath());
		if (!serverName.equals("/") && !serverName.equals("/login")
				&& !serverName.equals("/loginDialog")
				&& !serverName.equals("/logout")
				&& serverName.indexOf("/images/") == -1) {
			Object obj = httpServletRequest.getSession().getAttribute(Constants.USER_INFO_SESSION);
			if (obj == null) {
				PrintWriter out = response.getWriter();
				AjaxObject ajaxObject = new AjaxObject(301, "会话超时，请重新登录", "", "", "", "closeCurrent");
				out.println(ajaxObject.toString());
				return;
			}
		}

		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}
}