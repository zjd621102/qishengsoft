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
	/**
	 * 月度供应商报表
	 * @param form
	 * @param request
	 */
	public void getReportBuyList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer monthStr = new StringBuffer();
		StringBuffer dataStr = new StringBuffer();
		StringBuffer dataArray = new StringBuffer();
		
		String buydateFrom = StrUtils.nullToStr(form.getValue("buydateFrom"), DateUtils.getStepDateTime(-366));
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

		String sql = "SELECT manuid, manuname FROM smanu t WHERE t.manutypeid = '1' ORDER BY t.createdate";
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
		
		String selldateFrom = StrUtils.nullToStr(form.getValue("selldateFrom"), DateUtils.getStepDateTime(-366));
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

		String sql = "SELECT manuid, manuname FROM smanu t WHERE t.manutypeid = '2' ORDER BY t.createdate";
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getStepDateTime(-366));
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
		
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		
		sql = "SELECT n.materialname, m.sum FROM "
				+ "(SELECT b.materialid, IFNULL(SUM(b.sum), 0) sum FROM bbuy a, bbuyrow b"
				+ " WHERE a.buyid = b.buyid AND a.currflow = '结束' AND a.buydate >= '"
				+ dateFrom + "' AND a.buydate <= '" + dateTo + "' GROUP BY b.materialid) m, smaterial n"
				+ " WHERE m.materialid = n.materialid ORDER BY m.sum DESC";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		int i = 0;
		for(CodeTableForm codeTableForm : list) {
			if(i >= 1) {
				dataStr.append(",");
			}
			i++;
			
			dataStr.append("['").append(codeTableForm.getValue("materialname")).append("', ")
			.append(codeTableForm.getValue("sum")).append("]");
		}
		
		request.setAttribute("dataStr", dataStr.toString());
	}
	
	/**
	 * 综合产品报表
	 * @param form
	 * @param request
	 */
	public void getReportProductList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		
		sql = "SELECT n.productname, m.sum FROM "
				+ "(SELECT b.productid, IFNULL(SUM(b.realsum), 0) sum FROM bsell a, bsellrow b"
				+ " WHERE a.sellid = b.sellid AND a.currflow = '结束' AND a.selldate >= '"
				+ dateFrom + "' AND a.selldate <= '" + dateTo + "' GROUP BY b.productid) m, sproduct n"
				+ " WHERE m.productid = n.productid ORDER BY m.sum DESC";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		int i = 0;
		for(CodeTableForm codeTableForm : list) {
			if(i >= 1) {
				dataStr.append(",");
			}
			i++;
			
			dataStr.append("['").append(codeTableForm.getValue("productname")).append("', ")
			.append(codeTableForm.getValue("sum")).append("]");
		}
		
		request.setAttribute("dataStr", dataStr.toString());
	}
	
	/**
	 * 综合供应商报表
	 * @param form
	 * @param request
	 */
	public void getReportManuList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getStepDateTime(-366));
		String dateTo = StrUtils.nullToStr(form.getValue("dateTo"), DateUtils.getNowDate());
		form.setValue("dateFrom", dateFrom);
		form.setValue("dateTo", dateTo);
		
		sql = "SELECT m.* FROM "
				+ "(SELECT c.manuname, IFNULL(SUM(b.realsum), 0) sum FROM bpay a, bpayrow b, smanu c"
				+ " WHERE a.payid = b.payid AND b.manuid = c.manuid AND a.btype = 'FKD' AND a.currflow = '结束' AND a.paydate >= '"
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
	 * 综合客户报表
	 * @param form
	 * @param request
	 */
	public void getReportClientList(CodeTableForm form, HttpServletRequest request) {
		
		StringBuffer dataStr = new StringBuffer();
		String sql = null;
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getStepDateTime(-366));
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
		
		String dateFrom = StrUtils.nullToStr(form.getValue("dateFrom"), DateUtils.getStepDateTime(-366));
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