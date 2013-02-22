package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class PayDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取收付款单数量
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
	 * 获取收付款单列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getPayList(CodeTableForm form, int pageNum, int numPerPage) {
		
		String sql = "SELECT t.*, func_getBtypeName(t.btype) btypename, func_getManuName(t.manuid) manuname,"
				+ " func_getUserName(t.maker) makername FROM bpay t WHERE 1 = 1";
		String cond = getPayListCondition(form);
		sql  += cond;
		sql += " ORDER BY createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取收付款单列表-条件
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
	 * 新增收付款单
	 * @param form
	 * @return
	 */
	public int addPay(CodeTableForm form) {
		
		int iReturn = dbUtils.setInsert(form, "bpay", "");
		return iReturn;
	}
	/**
	 * 通过ID获取收付款单
	 * @param payid
	 * @return
	 */
	public CodeTableForm getPayById(int payid) {
		
		String sql = "SELECT a.*, func_getBtypeName(a.btype) btypename, func_getManuName(a.manuid) manuname,"
				+ " func_getUserName(a.maker) makername FROM bpay a WHERE a.payid = '" + payid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	/**
	 * 修改收付款单
	 * @param form
	 * @return
	 */
	public int ediPay(CodeTableForm form) {
		
		int iReturn = -1;
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		if(!currflow.equals("结束")) {
			iReturn = dbUtils.setUpdate(form, "", "bpay", "payid", "");
		} else {
			 //流程结束
			Connection conn = null;
			try {
				conn = dbUtils.dbConnection();
				conn.setAutoCommit(false); //事务开启
				iReturn = dbUtils.setUpdate(conn, form, "", "bpay", "payid", "");
				if(iReturn >= 1) {
					String btype = StrUtils.nullToStr(form.getValue("btype"));
					String bankcardno = StrUtils.nullToStr(form.getValue("bankcardno"));
					String realmoney = StrUtils.nullToStr(form.getValue("realmoney"));
					String sql = null;
					if(btype.equals("FKD") || btype.equals("YFD")) {
						sql = "UPDATE sbankcard t SET t.money = t.money - " + realmoney
								+ " WHERE t.bankcardno = '" + bankcardno + "'";
					} else if(btype.equals("SKD")) {
						sql = "UPDATE sbankcard t SET t.money = t.money + " + realmoney
								+ " WHERE t.bankcardno = '" + bankcardno + "'";
					}
					iReturn =  dbUtils.executeSQL(conn, sql);
				}
				
				conn.commit();
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
				} catch (SQLException e) {}
			}
		}
		return iReturn;
	}
	/**
	 * 删除收付款单
	 * @param payid
	 * @return
	 */
	public int deletePay(int payid) {
		
		String sql = "DELETE FROM bpay WHERE payid = '" + payid + "'";
		int iReturn = dbUtils.executeSQL(sql);
		return iReturn;
	}
}