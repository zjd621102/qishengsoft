package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class BuyDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取采购单数量
	 * @param form
	 * @return
	 */
	public int getBuyCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM bbuy t WHERE 1 = 1";
		String cond = getBuyListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取采购单列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getBuyList(CodeTableForm form, int pageNum, int numPerPage) {
		
		String sql = "SELECT t.*, func_getUserName(t.maker) makername, func_getBtypeName(t.btype) btypename"
				+ " FROM bbuy t WHERE 1 = 1";
		String cond = getBuyListCondition(form);
		sql  += cond;
		sql += " ORDER BY buyid DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取采购单列表-条件
	 * @param form
	 * @return
	 */
	public String getBuyListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String buyname = StrUtils.nullToStr(form.getValue("buyname"));
		String buyno = StrUtils.nullToStr(form.getValue("buyno"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		
		if(!buyname.equals("")) {
			cond.append(" AND t.buyname like '%").append(buyname).append("%'");
		}
		if(!buyno.equals("")) {
			cond.append(" AND t.buyno like '%").append(buyno).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增采购单
	 * @param form
	 * @return
	 */
	public int addBuy(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "bbuy", ""); //保存主表
			conn.commit();
			
			String sql = "SELECT IFNULL(MAX(buyid), 1) FROM bbuy";
			int buyid = dbUtils.getIntBySql(sql);
			form.setValue("buyid", buyid);
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bbuyrow", "buyrowid", "buyid", "", 1);
			}
			
			if(iReturn == -1) {
				dbUtils.setDelete(String.valueOf(buyid), "bbuy", "buyid");
			}
			
			conn.commit();
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".addBuy()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取采购单
	 * @param buyid
	 * @return
	 */
	public CodeTableForm getBuyById(int buyid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getUserName(a.maker) makername, func_getBtypeName(a.btype) btypename"
				+ " FROM bbuy a WHERE a.buyid = '" + buyid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.* FROM bbuyrow a WHERE a.buyid = '" + buyid + "'";
		List<CodeTableForm> buyrowList = dbUtils.getListBySql(sql);
		request.setAttribute("buyrowList", buyrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改采购单
	 * @param form
	 * @return
	 */
	public int ediBuy(CodeTableForm form, HttpServletRequest request) {

		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(form, "", "bbuy", "buyid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bbuyrow", "buyrowid", "buyid", "", 1);
			}
			
			conn.commit();
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediBuy()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除采购单
	 * @param buyid
	 * @return
	 */
	public int deleteBuy(int buyid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM bbuy WHERE buyid = '" + buyid + "'";
		sqls[1] = "DELETE FROM bbuyrow WHERE buyid = '" + buyid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
}