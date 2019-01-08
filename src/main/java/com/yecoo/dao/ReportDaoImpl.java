package com.yecoo.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 报表管理
 * @author zhoujd
 */
public class ReportDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	DateUtils dateUtils = new DateUtils();
	/**
	 * 月度供应商报表
	 * @param form
	 * @param request
	 */
	public void getReportBuyList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer monthStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();
		StringBuffer dataArray = new StringBuffer();
		
		String buydateFrom = StrUtils.nullToStr(form.getValue("buydateFrom"), DateUtils.getFristDayOfCurYear());
		String buydateTo = StrUtils.nullToStr(form.getValue("buydateTo"), DateUtils.getNowDate());
		String manuName = StrUtils.nullToStr(form.getValue("manuName"));
		form.setValue("buydateFrom", buydateFrom);
		form.setValue("buydateTo", buydateTo);
		form.setValue("manuName", manuName);
		List<String> monthList = DateUtils.getMonthList(buydateFrom, buydateTo);
		for (int i = 0, montLen = monthList.size(); i < montLen; i++) {
			if(i >= 1) {
				monthStr.append(",");
			}
			monthStr.append("'").append(monthList.get(i)).append("'");
		}

		if(!manuName.equals("")) {
			String sql = "SELECT manuid, manuname FROM smanu t WHERE t.manutypeid = '1' AND t.manuname LIKE '%"
					+ manuName + "%' ORDER BY t.priority ASC";
			List<CodeTableForm> manuList = dbUtils.getListBySql(sql);
			String sum = null;
			for (int manuIndex = 0, manuLen = manuList.size(); manuIndex < manuLen; manuIndex++) {
				CodeTableForm manu = manuList.get(manuIndex);
				
				dataStr.delete(0, dataStr.length());
				for(int i = 0, monthLen = monthList.size(); i < monthLen; i++) {
					sql = "SELECT IFNULL(SUM(b.sum), 0) sum FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid"
							+ " AND a.btype = 'CGD' AND a.buydate LIKE '"
							+ monthList.get(i) + "%' AND b.manuid = '" + manu.getValue("manuid") + "'";
					sum = dbUtils.execQuerySQL(sql);
					if(i >= 1) {
						dataStr.append(",");
					}
					dataStr.append(sum);
				}
				
				if(manuIndex >= 1) {
					dataArray.append(",");
				}
				dataArray.append("{name:'").append(manu.getValue("manuname"))
					.append("', data:[").append(dataStr).append("]}");
			}
		}
		
		request.setAttribute("monthStr", monthStr.toString());
		request.setAttribute("dataArray", dataArray.toString());
	}
	
	/**
	 * 月度客户报表
	 * @param form
	 * @param request
	 */
	public void getReportSellList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer monthStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();
		StringBuffer dataArray = new StringBuffer();
		
		String selldateFrom = StrUtils.nullToStr(form.getValue("selldateFrom"), DateUtils.getFristDayOfCurYear());
		String selldateTo = StrUtils.nullToStr(form.getValue("selldateTo"), DateUtils.getNowDate());
		String manuName = StrUtils.nullToStr(form.getValue("manuName"));
		form.setValue("selldateFrom", selldateFrom);
		form.setValue("selldateTo", selldateTo);
		form.setValue("manuName", manuName);
		List<String> monthList = DateUtils.getMonthList(selldateFrom, selldateTo);
		for (int i = 0, montLen = monthList.size(); i < montLen; i++) {
			if(i >= 1) {
				monthStr.append(",");
			}
			monthStr.append("'").append(monthList.get(i)).append("'");
		}

		String sql = "SELECT manuid, manuname FROM smanu t WHERE t.manutypeid = '2' AND t.statusid = '1'"
				+ " AND t.manuname LIKE '%" + manuName + "%' ORDER BY t.priority ASC";
		List<CodeTableForm> manuList = dbUtils.getListBySql(sql);
		String sum = null;
		for (int manuIndex = 0; manuIndex < manuList.size(); manuIndex++) {
			CodeTableForm manu = manuList.get(manuIndex);
			
			dataStr.delete(0, dataStr.length());
			for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
				sql = "SELECT IFNULL(SUM(b.realsum), 0) FROM bsell a, bsellrow b"
						+ " WHERE a.sellid = b.sellid AND b.productid IS NOT NULL AND a.selldate LIKE '"
						+ monthList.get(monthIndex) + "%' AND a.manuid = '" + manu.getValue("manuid") + "'";
				sum = dbUtils.execQuerySQL(sql);
				if(monthIndex >= 1) {
					dataStr.append(",");
				}
				dataStr.append(sum);
			}
			
			if(manuIndex >= 1) {
				dataArray.append(",");
			}
			dataArray.append("{name:'").append(manu.getValue("manuname")).append("', data:[").append(dataStr).append("]}");
		}
		
		request.setAttribute("monthStr", monthStr.toString());
		request.setAttribute("dataArray", dataArray.toString());
	}
	
	/**
	 * 月度综合报表
	 * @param form
	 * @param request
	 */
	public void getReportColligateList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer monthStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();
		StringBuffer dataArray = new StringBuffer();
		String sql = null;
		String sum = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getFristDayOfCurYear());
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		List<String> monthList = DateUtils.getMonthList(dateFrom, dateTo);
		for (int i = 0, montLen = monthList.size(); i < montLen; i++) {
			if(i >= 1) {
				monthStr.append(",");
			}
			monthStr.append("'").append(monthList.get(i)).append("'");
		}
		
		// 发货统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.realsum), 0) FROM bsell a, bsellrow b"
					+ " WHERE a.sellid = b.sellid AND b.productid IS NOT NULL AND a.selldate LIKE '"
					+ monthList.get(monthIndex) + "%' AND a.currflow <> '申请'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append("{name:'发货统计', data:[").append(dataStr).append("]}");
		
		// 采购统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.sum), 0) sum FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.currflow <> '申请' AND a.buydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'采购统计', data:[").append(dataStr).append("]}");
		/*
		// 简易采购统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
					+ " AND a.currflow = '结束' AND a.btype = 'FKD' AND a.relateno LIKE 'JYD%' AND a.paydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'简易采购统计', data:[").append(dataStr).append("]}");
		*/
		
		// 利润统计
		ManageDaoImpl manageDaoImpl = new ManageDaoImpl();
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sum = manageDaoImpl.getProfit("", "结束", "", "", monthList.get(monthIndex));
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'利润统计', data:[").append(dataStr).append("]}");
		
		/*
		// 工资统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.planmoney), 0) sum FROM bsalary a, bsalaryrow b WHERE a.salaryid = b.salaryid"
					+ " AND a.currflow = '结束' AND a.salarydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'工资统计', data:[").append(dataStr).append("]}");
		*/
		
		/*
		// 运费统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
					+ " AND a.currflow = '结束' AND a.btype = 'YFD' AND a.paydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'运费统计', data:[").append(dataStr).append("]}");
		*/
		request.setAttribute("monthStr", monthStr.toString());
		request.setAttribute("dataArray", dataArray.toString());
	}
	
	/**
	 * 综合物资报表
	 * @param form
	 * @param request
	 */
	public void getReportMaterialList(CodeTableForm form, HttpServletRequest request) {

		StringBuffer titleStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getFristDayOfCurYear());
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		String manuname = StrUtils.nullToStr(form.getValue("manuname"));// 供应商
		String sort = StrUtils.nullToStr(form.getValue("sort"), "DESC");// 排序
		String limitFrom = StrUtils.nullToStr(form.getValue("limitFrom"), "0");
		String limitNum = StrUtils.nullToStr(form.getValue("limitNum"), "12");
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		form.setValue("manuname", manuname);
		form.setValue("sort", sort);
		form.setValue("limitFrom", limitFrom);
		form.setValue("limitNum", limitNum);
		
		String cond = "";
		if(!manuname.equals("")) {
			cond += " AND EXISTS (SELECT 1 FROM smanu s WHERE s.manuid = a.manuid AND s.manuname LIKE '%" + manuname + "%')";
		}
		
		sql = "SELECT * FROM (SELECT CONCAT(a.materialno, '-', a.materialname) name,"
				+ " (SELECT IFNULL(SUM(c.sum), 0) FROM bbuy b, bbuyrow c WHERE b.buyid = c.buyid AND b.currflow <> '申请' AND b.btype = 'CGD'"
				+ " AND c.materialid = a.materialid"
				+ " AND b.buydate >= '" + dateFrom + "' AND b.buydate <= '" + dateTo + "') sum FROM smaterial a WHERE 1 = 1 "
				+ cond + ") m ORDER BY m.sum " + sort
				+ " LIMIT " + limitFrom + "," + limitNum;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		int len = list.size();
		CodeTableForm codeTableForm = null;
		for(int i = len-1; i >= 0; i--) {
			codeTableForm = (CodeTableForm) list.get(i);
			if(i < len-1) {
				titleStr.append(",");
				dataStr.append(",");
			}

			titleStr.append("'").append(codeTableForm.getValue("name")).append("'");
			dataStr.append(codeTableForm.getValue("sum"));
		}

		request.setAttribute("titleStr", titleStr.toString());
		request.setAttribute("dataStr", dataStr.toString());
	}
	
	/**
	 * 综合产品报表
	 * @param form
	 * @param request
	 */
	public void getReportProductList(CodeTableForm form, HttpServletRequest request) {

		StringBuffer titleStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();// 销售
		StringBuffer dataProfitStr = new StringBuffer();// 利润
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getFristDayOfCurYear());
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		String sort = StrUtils.nullToStr(form.getValue("sort"), "DESC");// 排序
		String limitFrom = StrUtils.nullToStr(form.getValue("limitFrom"), "0");
		String limitNum = StrUtils.nullToStr(form.getValue("limitNum"), "10");
		String manuName = StrUtils.nullToStr(form.getValue("manuName"));
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		form.setValue("sort", sort);
		form.setValue("limitFrom", limitFrom);
		form.setValue("limitNum", limitNum);
		form.setValue("manuName", manuName);
		
		String cond = "";
		if(!manuName.equals("")) {
			cond += " AND EXISTS (SELECT 1 FROM smanu sm WHERE sm.manuid = b.manuid AND sm.manuname LIKE '%"
					+ manuName + "%')";
		}
		
		sql = "SELECT * FROM (SELECT CONCAT(a.productno, '-', a.productname) name,"
				+ " (SELECT IFNULL(SUM(c.realsum), 0) FROM bsell b, bsellrow c WHERE b.sellid = c.sellid AND b.currflow <> '申请' AND c.productid = a.productid"
				+ " AND b.selldate >= '" + dateFrom + "' AND b.selldate <= '" + dateTo + "'" + cond + ") sum,"
				+ " (SELECT IFNULL(SUM(c.profit*c.num), 0)"
				+ " FROM bsell b, bsellrow c WHERE b.sellid = c.sellid"
				+ " AND b.currflow <> '申请' AND c.productid = a.productid"
				+ " AND b.selldate >= '" + dateFrom + "' AND b.selldate <= '" + dateTo + "'" + cond + ") profit"
				+ " FROM sproduct a WHERE a.statusid = '1') m ORDER BY m.sum " + sort
				+ " LIMIT " + limitFrom + "," + limitNum;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		int len = list.size();
		CodeTableForm codeTableForm = null;
		for(int i = len-1; i >= 0; i--) {
			codeTableForm = (CodeTableForm) list.get(i);
			if(i < len-1) {
				titleStr.append(",");
				dataStr.append(",");
				dataProfitStr.append(",");
			}

			titleStr.append("'").append(codeTableForm.getValue("name")).append("'");
			dataStr.append(codeTableForm.getValue("sum"));
			dataProfitStr.append(codeTableForm.getValue("profit"));
		}

		request.setAttribute("titleStr", titleStr.toString());
		request.setAttribute("dataStr", dataStr.toString());
		request.setAttribute("dataProfitStr", dataProfitStr.toString());
		/**************利润End**************/
	}
	
	/**
	 * 综合供应商报表
	 * @param form
	 * @param request
	 */
	public void getReportManuList(CodeTableForm form, HttpServletRequest request) {

		StringBuffer titleStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getFristDayOfCurYear());
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		String sort = StrUtils.nullToStr(form.getValue("sort"), "DESC");// 排序
		String limitFrom = StrUtils.nullToStr(form.getValue("limitFrom"), "0");
		String limitNum = StrUtils.nullToStr(form.getValue("limitNum"), "12");
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		form.setValue("sort", sort);
		form.setValue("limitFrom", limitFrom);
		form.setValue("limitNum", limitNum);
		
		sql = "SELECT m.* FROM "
				+ "(SELECT c.manuname name, IFNULL(SUM(b.sum), 0) sum FROM bbuy a, bbuyrow b, smanu c"
				+ " WHERE a.buyid = b.buyid AND b.manuid = c.manuid AND a.btype = 'CGD' AND a.buydate >= '"
				+ dateFrom + "' AND a.buydate <= '" + dateTo + "' GROUP BY c.manuname) m ORDER BY m.sum " + sort
				+ " LIMIT " + limitFrom + "," + limitNum;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		int len = list.size();
		CodeTableForm codeTableForm = null;
		for(int i = len-1; i >= 0; i--) {
			codeTableForm = (CodeTableForm) list.get(i);
			if(i < len-1) {
				titleStr.append(",");
				dataStr.append(",");
			}

			titleStr.append("'").append(codeTableForm.getValue("name")).append("'");
			dataStr.append(codeTableForm.getValue("sum"));
		}

		request.setAttribute("titleStr", titleStr.toString());
		request.setAttribute("dataStr", dataStr.toString());
	}
	
	/**
	 * 综合客户报表
	 * @param form
	 * @param request
	 */
	public void getReportClientList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getFristDayOfCurYear());
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		
		String manuCond = "";
		CodeTableForm userForm = (CodeTableForm) request.getSession().getAttribute(Constants.USER_INFO_SESSION); //用户信息
		if(userForm != null && "1".equals(userForm.getValue("ismanu"))) {// 是客户
			form.setValue("manuName", userForm.getValue("username"));
			manuCond += " AND c.manuname = '" + userForm.getValue("username") + "'";
		}
		
		sql = "SELECT m.* FROM "
				+ "(SELECT c.manuname, IFNULL(SUM(b.realsum), 0) sum FROM bsell a, bsellrow b, smanu c"
				+ " WHERE a.sellid = b.sellid AND a.manuid = c.manuid AND a.selldate >= '"
				+ dateFrom + "' AND a.selldate <= '" + dateTo + "' AND b.productid IS NOT NULL"
				+ " AND a.currflow != '申请'" + manuCond + " GROUP BY c.manuname) m ORDER BY m.sum DESC";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		int i = 0;
		for(CodeTableForm codeTableForm : list) {
			if(i >= 1) {
				dataStr.append(",");
			}
			i++;
			
			dataStr.append("['").append(codeTableForm.getValue("manuname")).append("', ")
			.append(codeTableForm.getValue("sum")).append("]");
		}
		
		request.setAttribute("dataStr", dataStr.toString());
	}
	
	/**
	 * 综合统计报表
	 * @param form
	 * @param request
	 */
	public void getReportStatisticsList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		String sum = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getFristDayOfCurYear());
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		String materialtype = StrUtils.nullToStr(form.getValue("materialtype"));
		String producttype = StrUtils.nullToStr(form.getValue("producttype"));
		String manuName = StrUtils.nullToStr(form.getValue("manuName"));
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		form.setValue("producttype", producttype);
		form.setValue("manuName", manuName);
		
		// 发货统计
		sql = "SELECT IFNULL(SUM(b.realsum), 0) FROM bsell a, bsellrow b WHERE a.sellid = b.sellid"
				+ " AND b.productid IS NOT NULL AND a.currflow != '申请'" + " AND a.selldate >= '" + dateFrom
				+ "' AND a.selldate <= '" + dateTo + "'";

		if(!materialtype.equals("")) {
			sql += " AND EXISTS (SELECT 1 FROM sproduct c WHERE c.productid = b.productid"
					+ " AND c.productno REGEXP '[A-Z]+" + materialtype + "_*')";
		}
		
		if(!producttype.equals("")) {
			sql += " AND EXISTS (SELECT 1 FROM sproduct c WHERE c.productid = b.productid"
					+ " AND c.productno REGEXP '[A-Z]+[0-9]{1}" + producttype + "_*')";
		}
		
		if(!manuName.equals("")) {
			sql += " AND EXISTS (SELECT 1 FROM smanu d WHERE d.manuid = a.manuid"
					+ " AND d.manuname LIKE '%" + manuName + "%')";
		}
		
		sum = dbUtils.execQuerySQL(sql);
		dataStr.append(sum);
		
		// 采购统计
		sql = "SELECT IFNULL(SUM(b.sum), 0) sum FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.btype = 'CGD'"
				+ " AND a.buydate >= '" + dateFrom + "' AND a.buydate <= '" + dateTo + "'";
		sum = dbUtils.execQuerySQL(sql);
		dataStr.append(",");
		dataStr.append(sum);

		// 简易采购统计
		sql = "SELECT IFNULL(SUM(b.sum), 0) sum FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.btype = 'JYD'"
				+ " AND a.buydate >= '" + dateFrom + "' AND a.buydate <= '" + dateTo + "'";
		sum = dbUtils.execQuerySQL(sql);
		dataStr.append(",");
		dataStr.append(sum);

		// 工资统计
		String salarySql = "SELECT IFNULL(SUM(b.planmoney), 0) sum FROM bsalary a, bsalaryrow b WHERE a.salaryid = b.salaryid"
				+ " AND a.currflow = '结束' AND a.salarydate >= '" + dateFrom.substring(0, 7) + "' AND a.salarydate <= '"
				+ dateTo.substring(0, 7) + "'";
		sum = dbUtils.execQuerySQL(salarySql);
		dataStr.append(",");
		dataStr.append(sum);
		/*
		// 运费统计
		sum = dbUtils.execQuerySQL(sql + " AND a.btype = 'YFD'");
		dataStr.append(",");
		dataStr.append(sum);
		*/
		request.setAttribute("types", "'发货统计', '采购统计', '简易采购统计', '工资统计'");
		request.setAttribute("dataStr", dataStr.toString());
	}
}