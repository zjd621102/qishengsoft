package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yecoo.dao.LogDaoImpl;
import com.yecoo.model.CodeTableForm;
/**
 * 日志管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/log")
public class LogAction {

	private LogDaoImpl logDaoImpl = new LogDaoImpl();

	/**
	 * 日志列表
	 * 
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("Log:view")
	@RequestMapping(value = "/list")
	public String list(CodeTableForm form, HttpServletRequest request) {

		logDaoImpl.initAction(request);

		int totalCount = logDaoImpl.getLogCount(form);
		List<CodeTableForm> logList = logDaoImpl.getLogList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("logList", logList); // 日志列表
		request.setAttribute("sn", "log"); //授权名称
		request.setAttribute("form", form);

		return "log/list";
	}
	
	@RequiresPermissions("Log:edi")
	@RequestMapping(value = "/edi/{logid}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("logid") String logid, HttpServletRequest request) {

		CodeTableForm form = null;
		form = logDaoImpl.getLogById(logid);
		request.setAttribute("form", form);

		return "log/edi";
	}
}