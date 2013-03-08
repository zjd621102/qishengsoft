package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class PayDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取发票数量
	 * @param form
	 * @return
	 */
	public int getPayCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM bpay t WHERE 1 = 1";
		String cond = getPayListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取发票列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getPayList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getBtypeName(t.btype) btypename, func_getUserName(t.maker) makername,"
				+ " (SELECT IFNULL(SUM(bp.realsum), 0) FROM bpayrow bp WHERE bp.payid = t.payid) allrealsum"
				+ " FROM bpay t WHERE 1 = 1";
		String cond = getPayListCondition(form);
		sql  += cond;
		sql += " ORDER BY createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取发票列表-条件
	 * @param form
	 * @return
	 */
	public String getPayListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String payname = StrUtils.nullToStr(form.getValue("payname"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		
		if(!payname.equals("")) {
			cond.append(" AND t.payname like '%").append(payname).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增发票
	 * @param form
	 * @return
	 */
	public int addPay(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "bpay", ""); //保存主表
			conn.commit();
			
			String sql = "SELECT IFNULL(MAX(payid), 1) FROM bpay";
			int payid = dbUtils.getIntBySql(sql);
			form.setValue("payid", payid);
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bpayrow", "payrowid", "payid", "", 1);
			}
			
			if(iReturn == -1) {
				dbUtils.setDelete(String.valueOf(payid), "bpay", "payid");
				conn.rollback();
			} else {
				conn.commit();
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".addPay()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取发票
	 * @param payid
	 * @return
	 */
	public CodeTableForm getPayById(int payid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getBtypeName(a.btype) btypename, func_getUserName(a.maker) makername"
				+ " FROM bpay a WHERE a.payid = '" + payid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.*, func_getManuName(a.manuid) manuname FROM bpayrow a WHERE a.payid = '" + payid + "'";
		List<CodeTableForm> payrowList = dbUtils.getListBySql(sql);
		request.setAttribute("payrowList", payrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改发票
	 * @param form
	 * @return
	 */
	public int ediPay(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启

			iReturn = dbUtils.setUpdate(conn, form, "", "bpay", "payid", "");
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bpayrow", "payrowid", "payid", "", 1);
			}
			
			if(iReturn >= 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				String btype = StrUtils.nullToStr(form.getValue("btype"));
				String sql = null;
				String payid = StrUtils.nullToStr(form.getValue("payid"));
				if(btype.equals("FKD") || btype.equals("YFD")) {
					sql = "UPDATE sbankcard t SET t.money = t.money - "
							+ "(SELECT IFNULL(SUM(a.realsum), 0) FROM bpayrow a WHERE a.payid = '" + payid + "'"
							+ " AND a.bankcardno = t.bankcardno)"
							+ " WHERE exists (SELECT 1 FROM bpayrow b WHERE b.payid = '"
							+ payid + "' AND b.bankcardno = t.bankcardno)";
				} else if(btype.equals("SKD")) {
					sql = "UPDATE sbankcard t SET t.money = t.money + "
							+ "(SELECT IFNULL(SUM(a.realsum), 0) FROM bpayrow a WHERE a.payid = '" + payid + "'"
							+ " AND a.bankcardno = t.bankcardno)"
							+ " WHERE exists (SELECT 1 FROM bpayrow b WHERE b.payid = '"
							+ payid + "' AND b.bankcardno = t.bankcardno)";
				}
				iReturn =  dbUtils.executeSQL(sql);
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediPay()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除发票
	 * @param payid
	 * @return
	 */
	public int deletePay(int payid) {
		
		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM bpay WHERE payid = '" + payid + "'";
		sqls[1] = "DELETE FROM bpayrow WHERE payid = '" + payid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
}