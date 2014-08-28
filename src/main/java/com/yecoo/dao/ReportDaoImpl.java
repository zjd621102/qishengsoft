package com.yecoo.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
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
		
		String buydateFrom = StrUtils.nullToStr(form.getValue("buydateFrom"), dateUtils.getStepDateTime(-366));
		String buydateTo = StrUtils.nullToStr(form.getValue("buydateTo"), DateUtils.getNowDate());
		form.setValue("buydateFrom", buydateFrom);
		form.setValue("buydateTo", buydateTo);
		List<String> monthList = DateUtils.getMonthList(buydateFrom, buydateTo);
		for (int i = 0, montLen = monthList.size(); i < montLen; i++) {
			if(i >= 1) {
				monthStr.append(",");
			}
			monthStr.append("'").append(monthList.get(i)).append("'");
		}

		String sql = "SELECT manuid, manuname FROM smanu t WHERE t.manutypeid = '1' ORDER BY t.priority ASC";
		List<CodeTableForm> manuList = dbUtils.getListBySql(sql);
		String sum = null;
		for (int manuIndex = 0, manuLen = manuList.size(); manuIndex < manuLen; manuIndex++) {
			CodeTableForm manu = manuList.get(manuIndex);
			
			dataStr.delete(0, dataStr.length());
			for(int i = 0, monthLen = monthList.size(); i < monthLen; i++) {
				sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
						+ " AND a.btype = 'FKD' AND a.currflow = '结束' AND a.paydate LIKE '"
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
			dataArray.append("{name:'").append(manu.getValue("manuname")).append("', data:[").append(dataStr).append("]}");
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
		
		String selldateFrom = StrUtils.nullToStr(form.getValue("selldateFrom"), dateUtils.getStepDateTime(-366));
		String selldateTo = StrUtils.nullToStr(form.getValue("selldateTo"), DateUtils.getNowDate());
		form.setValue("selldateFrom", selldateFrom);
		form.setValue("selldateTo", selldateTo);
		List<String> monthList = DateUtils.getMonthList(selldateFrom, selldateTo);
		for (int i = 0, montLen = monthList.size(); i < montLen; i++) {
			if(i >= 1) {
				monthStr.append(",");
			}
			monthStr.append("'").append(monthList.get(i)).append("'");
		}

		String sql = "SELECT manuid, manuname FROM smanu t WHERE t.manutypeid = '2' ORDER BY t.priority ASC";
		List<CodeTableForm> manuList = dbUtils.getListBySql(sql);
		String sum = null;
		for (int manuIndex = 0; manuIndex < manuList.size(); manuIndex++) {
			CodeTableForm manu = manuList.get(manuIndex);
			
			dataStr.delete(0, dataStr.length());
			for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
				sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
						+ " AND a.btype = 'SKD' AND a.currflow = '结束' AND a.paydate LIKE '"
						+ monthList.get(monthIndex) + "%' AND b.manuid = '" + manu.getValue("manuid") + "'";
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), dateUtils.getStepDateTime(-366));
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
		
		// 收款统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
					+ " AND a.currflow = '结束' AND a.btype = 'SKD' AND a.paydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append("{name:'收款统计', data:[").append(dataStr).append("]}");
		
		// 付款统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
					+ " AND a.currflow = '结束' AND a.btype = 'FKD' AND a.paydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'付款统计', data:[").append(dataStr).append("]}");
		
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
		
		// 工资统计
		dataStr.delete(0, dataStr.length());
		for(int monthIndex = 0, len = monthList.size(); monthIndex <= len-1; monthIndex++) {
			sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
					+ " AND a.currflow = '结束' AND a.btype = 'GZD' AND a.paydate LIKE '"
					+ monthList.get(monthIndex) + "%'";
			sum = dbUtils.execQuerySQL(sql);
			if(monthIndex >= 1) {
				dataStr.append(",");
			}
			dataStr.append(sum);
		}
		dataArray.append(",");
		dataArray.append("{name:'工资统计', data:[").append(dataStr).append("]}");
		
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), dateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		String sort = StrUtils.nullToStr(form.getValue("sort"), "DESC");// 排序
		String limitFrom = StrUtils.nullToStr(form.getValue("limitFrom"), "0");
		String limitNum = StrUtils.nullToStr(form.getValue("limitNum"), "12");
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		form.setValue("sort", sort);
		form.setValue("limitFrom", limitFrom);
		form.setValue("limitNum", limitNum);
		
		sql = "SELECT * FROM (SELECT CONCAT(a.materialno, '-', a.materialname) name,"
				+ " (SELECT IFNULL(SUM(c.sum), 0) FROM bbuy b, bbuyrow c WHERE b.buyid = c.buyid AND b.currflow = '结束' AND c.materialid = a.materialid"
				+ " AND b.buydate >= '" + dateFrom + "' AND b.buydate <= '" + dateTo + "') sum FROM smaterial a) m ORDER BY m.sum " + sort
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), dateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		String sort = StrUtils.nullToStr(form.getValue("sort"), "DESC");// 排序
		String limitFrom = StrUtils.nullToStr(form.getValue("limitFrom"), "0");
		String limitNum = StrUtils.nullToStr(form.getValue("limitNum"), "10");
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		form.setValue("sort", sort);
		form.setValue("limitFrom", limitFrom);
		form.setValue("limitNum", limitNum);
		
		sql = "SELECT * FROM (SELECT CONCAT(a.productno, '-', a.productname) name,"
				+ " (SELECT IFNULL(SUM(c.realsum), 0) FROM bsell b, bsellrow c WHERE b.sellid = c.sellid AND b.currflow = '结束' AND c.productid = a.productid"
				+ " AND b.selldate >= '" + dateFrom + "' AND b.selldate <= '" + dateTo + "') sum,"
				+ " (SELECT IFNULL(SUM(c.profit*c.num), 0) FROM bsell b, bsellrow c WHERE b.sellid = c.sellid AND b.currflow = '结束' AND c.productid = a.productid"
				+ " AND b.selldate >= '" + dateFrom + "' AND b.selldate <= '" + dateTo + "') profit FROM sproduct a) m ORDER BY m.sum " + sort
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), dateUtils.getStepDateTime(-366));
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
				+ "(SELECT c.manuname name, IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b, smanu c"
				+ " WHERE a.payid = b.payid AND b.manuid = c.manuid AND a.btype = 'FKD' AND a.currflow = '结束' AND a.paydate >= '"
				+ dateFrom + "' AND a.paydate <= '" + dateTo + "' GROUP BY c.manuname) m ORDER BY m.sum " + sort
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), dateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		
		sql = "SELECT m.* FROM "
				+ "(SELECT c.manuname, IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b, smanu c"
				+ " WHERE a.payid = b.payid AND b.manuid = c.manuid AND a.btype = 'SKD' AND a.currflow = '结束' AND a.paydate >= '"
				+ dateFrom + "' AND a.paydate <= '" + dateTo + "' GROUP BY c.manuname) m ORDER BY m.sum DESC";
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), dateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		
		sql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
				+ " AND a.currflow = '结束' AND a.paydate >= '" + dateFrom + "' AND a.paydate <= '"
				+ dateTo + "'";
		
		// 收款统计
		sum = dbUtils.execQuerySQL(sql + " AND a.btype = 'SKD'");
		dataStr.append(sum);
		
		// 付款统计
		sum = dbUtils.execQuerySQL(sql + " AND a.btype = 'FKD'");
		dataStr.append(",");
		dataStr.append(sum);
		
		// 付款统计
		sum = dbUtils.execQuerySQL(sql + " AND a.btype = 'FKD' AND a.relateno LIKE 'JYD%'");
		dataStr.append(",");
		dataStr.append(sum);
		
		// 工资统计
		String salarySql = "SELECT IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b WHERE a.payid = b.payid"
				+ " AND a.currflow = '结束' AND a.paydate >= '" + dateFrom.substring(0, 7) + "' AND a.paydate <= '"
				+ dateTo.substring(0, 7) + "'";
		sum = dbUtils.execQuerySQL(salarySql + " AND a.btype = 'GZD'");
		dataStr.append(",");
		dataStr.append(sum);
		
		// 运费统计
		sum = dbUtils.execQuerySQL(sql + " AND a.btype = 'YFD'");
		dataStr.append(",");
		dataStr.append(sum);
		
		request.setAttribute("types", "'收款统计', '付款统计', '简易采购统计', '工资统计', '运费统计'");
		request.setAttribute("dataStr", dataStr.toString());
	}
}