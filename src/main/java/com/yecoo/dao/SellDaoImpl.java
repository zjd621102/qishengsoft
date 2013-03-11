package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class SellDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取销售单数量
	 * @param form
	 * @return
	 */
	public int getSellCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM bsell t WHERE 1 = 1";
		String cond = getSellListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取销售单列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getSellList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getUserName(t.maker) makername, func_getManuName(t.manuid) manuname,"
				+ " func_getSum(t.sellid, 'XSD') allrealsum FROM bsell t WHERE 1 = 1";
		String cond = getSellListCondition(form);
		sql  += cond;
		sql += " ORDER BY sellid DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取销售单列表-条件
	 * @param form
	 * @return
	 */
	public String getSellListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String sellno = StrUtils.nullToStr(form.getValue("sellno"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		
		if(!sellno.equals("")) {
			cond.append(" AND t.sellno like '%").append(sellno).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增销售单
	 * @param form
	 * @return
	 */
	public int addSell(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "bsell", ""); //保存主表
			conn.commit();
			
			String sql = "SELECT IFNULL(MAX(sellid), 1) FROM bsell";
			int sellid = dbUtils.getIntBySql(sql);
			form.setValue("sellid", sellid);
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bsellrow", "sellrowid", "sellid", "", 1);
			}
			
			if(iReturn == -1) {
				dbUtils.setDelete(String.valueOf(sellid), "bsell", "sellid");
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
			StrUtils.WriteLog(this.getClass().getName() + ".addSell()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取销售单
	 * @param sellid
	 * @return
	 */
	public CodeTableForm getSellById(int sellid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getUserName(a.maker) makername, func_getManuName(a.manuid) manuname"
				+ " FROM bsell a WHERE a.sellid = '" + sellid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.*, func_getUnitName(a.unit) unitname FROM bsellrow a WHERE a.sellid = '" + sellid + "'";
		List<CodeTableForm> sellrowList = dbUtils.getListBySql(sql);
		request.setAttribute("sellrowList", sellrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改销售单
	 * @param form
	 * @return
	 */
	public int ediSell(CodeTableForm form, HttpServletRequest request) {

		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(form, "", "bsell", "sellid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bsellrow", "sellrowid", "sellid", "", 1);
			}
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
				String maker = StrUtils.nullToStr(user.getValue("userid")); //当前登录用户
				String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss");
				String sellid = StrUtils.nullToStr(form.getValue("sellid"));
				StringBuffer sql = new StringBuffer("INSERT INTO bpay(btype, maker, paydate, relateno, relatemoney,")
					.append(" currflow, createtime)	SELECT 'SKD', '").append(maker)
					.append("', selldate, sellno, func_getSum(sellid, 'XSD'), '申请', '").append(createdate)
					.append("' FROM bsell WHERE sellid = '").append(sellid).append("'");

				iReturn = dbUtils.executeSQL(sql.toString()); //直接保存，用于下面获取payid
				
				if(iReturn >= 1) { //生成销售单
					sql.delete(0,sql.length());
					sql.append("SELECT MAX(payid) FROM bpay");
					int payid = dbUtils.getIntBySql(sql.toString());
					int payid2 = 0;
					sql.delete(0,sql.length());
					sql.append("INSERT INTO bpayrow(payid, manuid, manubankname, manubankcardno, manuaccountname, plansum, realsum)")
						.append(" SELECT ").append(payid).append(", t.manuid,")
						.append(" (SELECT sm.bankrow FROM smanurow sm WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1),")
						.append(" (SELECT sm.accountnorow FROM smanurow sm WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1),")
						.append(" (SELECT sm.accountnamerow FROM smanurow sm WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1),")
						.append(" func_getSum(t.sellid, 'XSD'), func_getSum(t.sellid, 'XSD')")
						.append(" FROM bsell t WHERE sellid = '").append(sellid).append("'");
					iReturn = dbUtils.executeSQL(conn, sql.toString());
					
					if(iReturn >= 1) { //生成运费单
						sql = new StringBuffer("INSERT INTO bpay(btype, maker, paydate, relateno, relatemoney,")
						.append(" currflow, createtime)	SELECT 'YFD', '").append(maker)
						.append("', selldate, sellno, func_getSum(sellid, 'XSD'), '申请', '").append(createdate)
						.append("' FROM bsell WHERE sellid = '").append(sellid).append("'");
						
						iReturn = dbUtils.executeSQL(sql.toString()); //直接保存，用于下面获取payid
						
						if(iReturn >= 1) {
							sql.delete(0,sql.length());
							sql.append("SELECT MAX(payid) FROM bpay");
							payid2 = dbUtils.getIntBySql(sql.toString());
							sql.delete(0,sql.length());
							sql.append("INSERT INTO bpayrow(payid) values ('").append(payid2).append("')");
							iReturn = dbUtils.executeSQL(conn, sql.toString());
						}
					}
					
					if(iReturn == -1) { //行项保存失败，删除主表
						sql.delete(0,sql.length());
						sql.append("DELETE FROM bpay WHERE payid = '").append(payid).append("'");
						dbUtils.executeSQL(sql.toString());
						sql.delete(0,sql.length());
						sql.append("DELETE FROM bpay WHERE payid = '").append(payid2).append("'");
						dbUtils.executeSQL(sql.toString());
						sql.append("UPDATE bsell SET currflow = '申请' WHERE sellid = '").append(sellid).append("'");
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
			StrUtils.WriteLog(this.getClass().getName() + ".ediSell()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除销售单
	 * @param sellid
	 * @return
	 */
	public int deleteSell(int sellid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM bsell WHERE sellid = '" + sellid + "'";
		sqls[1] = "DELETE FROM bsellrow WHERE sellid = '" + sellid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
}