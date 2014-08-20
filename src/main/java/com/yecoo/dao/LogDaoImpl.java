package com.yecoo.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 日志管理
 * @author zhoujd
 */
public class LogDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 日志数量
	 * @param form
	 * @return
	 */
	public int getLogCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM slog t WHERE 1 = 1";
		String cond = getLogListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 日志列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getLogList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getUserName(t.operater) operatername FROM slog t WHERE 1 = 1";
		String cond = getLogListCondition(form);
		sql += cond;
		sql += " ORDER BY t.operatetime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 日志列表-条件
	 * @param form
	 * @return
	 */
	public String getLogListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String logtype = StrUtils.nullToStr(form.getValue("logtype"));
		String operatername = StrUtils.nullToStr(form.getValue("operatername"));
		String fromTime = StrUtils.nullToStr(form.getValue("fromTime"));
		String toTime = StrUtils.nullToStr(form.getValue("toTime"));
		String remark = StrUtils.nullToStr(form.getValue("remark"));
		
		if(!logtype.equals("")) {
			cond.append(" AND t.logtype like '%").append(logtype).append("%'");
		}
		if(!operatername.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM suser m WHERE m.userid = t.operater AND m.username LIKE '%")
				.append(operatername).append("%')");
		}
		if(!fromTime.equals("")) {
			cond.append(" AND t.operatetime >= '").append(fromTime).append("'");
		}
		if(!toTime.equals("")) {
			cond.append(" AND t.operatetime <= '").append(toTime).append("'");
		}
		if(!remark.equals("")) {
			cond.append(" AND t.remark like '%").append(remark).append("%'");
		}
		
		return cond.toString();
	}
	
	/**
	 * 保存日志
	 * @param request
	 * @param logtype	日志类型
	 * @param remark	备注
	 */
	public static void saveLog(HttpServletRequest request, String logtype, Object remark) {
		try {
			DbUtils dbUtils = new DbUtils();
			CodeTableForm user = (CodeTableForm) request.getSession().getAttribute(Constants.USER_INFO_SESSION);
			CodeTableForm log = new CodeTableForm();
			log.setValue("logtype", logtype);
			log.setValue("operater", user.getValue("userid"));
			log.setValue("operatetime", DateUtils.getNowDateTime());
			log.setValue("remark", remark);
			dbUtils.setInsert(log, "slog");
		} catch(Exception e) {
			StrUtils.WriteLog("StrUtils.saveLog()", e);
		}
	}
	/**
	 * 获取日志信息
	 * @param userid
	 * @return
	 */
	public CodeTableForm getLogById(String logid) {
		
		String sql = "SELECT a.*, func_getUserName(a.operater) operatername FROM slog a WHERE a.logid = '" + logid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		return codeTableForm;
	}
}