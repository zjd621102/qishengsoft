package com.yecoo.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
/**
 * 编码过滤器
 * @author zhoujd
 */
public class EncodingFilter implements Filter {

	private String encoding = null;
	
	@Override
	public void destroy() {
		encoding = null;
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		request.setCharacterEncoding(encoding);
		response.setCharacterEncoding(encoding);
		chain.doFilter(request, response);
	}
	
	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
		encoding = arg0.getInitParameter("encoding");
		if (encoding == null || encoding.equals("")) {
			encoding = "UTF-8";
		}
	}
}