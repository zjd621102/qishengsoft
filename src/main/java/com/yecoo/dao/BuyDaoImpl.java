package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class BuyDaoImpl extends BaseDaoImpl {

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
	public List<CodeTableForm> getBuyList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getUserName(t.maker) makername, func_getBtypeName(t.btype) btypename,"
				+ " func_getSum(t.buyid, 'CGD') allsum FROM bbuy t WHERE 1 = 1";
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
		String buydateFrom = StrUtils.nullToStr(form.getValue("buydateFrom"));
		String buydateTo = StrUtils.nullToStr(form.getValue("buydateTo"));
		
		if(!buyname.equals("")) {
			cond.append(" AND t.buyname like '%").append(buyname).append("%'");
		}
		if(!buyno.equals("")) {
			cond.append(" AND t.buyno like '%").append(buyno).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		if(!buydateFrom.equals("")) {
			cond.append(" AND t.buydate >= '").append(buydateFrom).append("'");
		}
		if(!buydateTo.equals("")) {
			cond.append(" AND t.buydate <= '").append(buydateTo).append("'");
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
			
			if(iReturn == -1) {
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
		
		sql = "SELECT a.*, b.materialno FROM bbuyrow a LEFT JOIN smaterial b ON a.materialid = b.materialid WHERE a.buyid = '" + buyid + "'";
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
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
				String maker = StrUtils.nullToStr(user.getValue("userid")); //当前登录用户
				String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss");
				String buyid = StrUtils.nullToStr(form.getValue("buyid"));
				StringBuffer sql = new StringBuffer("INSERT INTO bpay(btype, maker, paydate, relateno, relatemoney,")
					.append(" currflow, createtime)	SELECT 'FKD', '").append(maker)
					.append("', buydate, buyno, func_getSum(buyid, 'CGD'), '申请', '").append(createdate)
					.append("' FROM bbuy WHERE buyid = '").append(buyid).append("'");

				iReturn = dbUtils.executeSQL(sql.toString()); //直接保存，用于下面获取payid
				
				if(iReturn >= 1) {
					sql.delete(0,sql.length());
					sql.append("SELECT MAX(payid) FROM bpay");
					int payid = dbUtils.getIntBySql(sql.toString());
					sql.delete(0,sql.length());
					sql.append("INSERT INTO bpayrow(payid, manuid, manubankname, manubankcardno, manuaccountname, plansum, realsum)")
						.append(" SELECT ").append(payid).append(", t.manuid,")
						.append(" (SELECT sm.bankrow FROM smanurow sm WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1),")
						.append(" (SELECT sm.accountnorow FROM smanurow sm WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1),")
						.append(" (SELECT sm.accountnamerow FROM smanurow sm WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1),")
						.append(" t.sum, t.sum")
						.append(" FROM (SELECT manuid, SUM(sum) sum FROM bbuyrow WHERE buyid = '").append(buyid)
						.append("' GROUP BY manuid) t");
					iReturn = dbUtils.executeSQL(conn, sql.toString());
					if(iReturn == -1) { //行项保存失败，删除主表
						sql.delete(0,sql.length());
						sql.append("DELETE FROM bpay WHERE payid = '").append(payid).append("'");
						dbUtils.executeSQL(sql.toString());
						sql.append("UPDATE bbuy SET currflow = '申请' WHERE buyid = '").append(buyid).append("'");
						dbUtils.executeSQL(sql.toString());
					}
				}
			}
			
			if(iReturn >= 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
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