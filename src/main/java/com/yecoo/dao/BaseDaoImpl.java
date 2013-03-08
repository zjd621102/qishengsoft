package com.yecoo.dao;

import javax.servlet.http.HttpServletRequest;
import com.yecoo.util.Constants;
import com.yecoo.util.StrUtils;
/**
 * 基础类
 * @author zhoujd
 */
public class BaseDaoImpl {

	int pageNum = 1; // 当前页
	int numPerPage = Constants.NUMPERPAGE; // 每页记录数
	/**
	 * 初始化Action
	 * @param request
	 */
	public void initAction(HttpServletRequest request) {
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request.getParameter("numPerPage"));
		String act = StrUtils.nullToStr(request.getParameter("act"));
		pageNum = 1;
		numPerPage = Constants.NUMPERPAGE;
		if (!act.equals("excel") && !sPageNum.equals("")) {
			pageNum = Integer.parseInt(sPageNum);
		}
		if (act.equals("excel")) {
			numPerPage = Constants.NUMPERPAGE_EXCEL;
		} else if (!sNumPerPage.equals("")) {
			numPerPage = Integer.parseInt(sNumPerPage);
		}
		request.setAttribute("pageNum", pageNum); // 当前页
		request.setAttribute("numPerPage", numPerPage); // 每页数量
		request.setAttribute("act", act);
	}
}