package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.IdSingleton;
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
		
		String sql = "SELECT t.*, func_getDictName('单据类型', t.btype) btypename, func_getUserName(t.maker) makername,"
				+ " (SELECT IFNULL(SUM(bp.plansum), 0) FROM bpayrow bp WHERE bp.payid = t.payid) allplansum,"
				+ " (SELECT IFNULL(SUM(bp.realsum), 0) FROM bpayrow bp WHERE bp.payid = t.payid) allrealsum,"
				+ " func_getManuName(t.manuid) manuname"
				+ " FROM bpay t WHERE 1 = 1";
		String cond = getPayListCondition(form);
		sql  += cond;
		sql += " ORDER BY createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		
		sql = "SELECT m.*, (m.allplansum - m.allrealsum) unpaysum FROM (" + sql + ") m";
		
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取应付金额
	 * @param form
	 * @return
	 */
	public String getPlanSum(CodeTableForm form) {
		
		String sql = "SELECT IFNULL(SUM(b.plansum), 0) FROM bpay t, bpayrow b WHERE 1 = 1 AND t.payid = b.payid";
		String cond = getPayListCondition(form);
		sql += cond;
		String sum = dbUtils.execQuerySQL(sql);
		return sum;
	}
	/**
	 * 获取实付金额
	 * @param form
	 * @return
	 */
	public String getPaySum(CodeTableForm form) {
		
		String sql = "SELECT IFNULL(SUM(b.realsum), 0) FROM bpay t, bpayrow b WHERE 1 = 1 AND t.payid = b.payid";
		String cond = getPayListCondition(form);
		sql += cond;
		String sum = dbUtils.execQuerySQL(sql);
		return sum;
	}
	/**
	 * 获取发票列表-条件
	 * @param form
	 * @return
	 */
	public String getPayListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String payid = StrUtils.nullToStr(form.getValue("payid"));
		String btype = StrUtils.nullToStr(form.getValue("btype"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		String manuname = StrUtils.nullToStr(form.getValue("manuname"));
		
		if(!payid.equals("")) {
			cond.append(" AND t.payid = '").append(payid).append("'");
		}
		if(!btype.equals("")) {
			cond.append(" AND t.btype = '").append(btype).append("'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		if(!manuname.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM smanu m WHERE m.manuid = t.manuid AND m.manuname LIKE '%")
				.append(manuname).append("%')");
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
			
			String payid = IdSingleton.getInstance().getNewId();
			form.setValue("payid", payid);
			
			iReturn = dbUtils.setInsert(conn, form, "bpay", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bpayrow", "payrowid", "payid", "", 1);
			}
			
			if(iReturn >= 0) {
				conn.commit();
			} else {
				conn.rollback();
				iReturn = -1;
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
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
		
		String sql = "SELECT a.*, func_getDictName('单据类型', a.btype) btypename, func_getUserName(a.maker) makername,"
				+ " func_getManuName(a.manuid) manuname" + " FROM bpay a WHERE a.payid = '" + payid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.* FROM bpayrow a WHERE a.payid = '" + payid + "'";
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
		String sql = null;

		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		String payid = null;
		
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
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				String btype = StrUtils.nullToStr(form.getValue("btype"));
				payid = StrUtils.nullToStr(form.getValue("payid"));
				
				String sing = null;
				if(btype.equals("FKD") || btype.equals("YFD") || btype.equals("GZD")) {
					sing = "-";
				} else if(btype.equals("SKD")) {
					sing = "+";
				}
				
				if(sing == null) {
					iReturn = -1;
					if(currflow.equals("结束") && payid != null) { //单据不能结束
						sql = "UPDATE bpay t SET t.currflow = '申请' WHERE t.payid = '" + payid + "'";
						dbUtils.executeSQL(sql);
					}
				} else {
					/**
					// 修改银行卡的金额
					sql = "SELECT a.payrowid, a.bankcardno, a.realsum FROM bpayrow a WHERE a.payid = '"
						+ payid + "'";
					List<CodeTableForm> list = dbUtils.getListBySql(sql);
					for(CodeTableForm codeTableForm : list) {
						String payrowid = StrUtils.nullToStr(codeTableForm.getValue("payrowid"));
						String bankcardno = StrUtils.nullToStr(codeTableForm.getValue("bankcardno"));
						String realsum = StrUtils.nullToStr(codeTableForm.getValue("realsum"), "0");
						sql = "UPDATE sbankcard t SET t.money = (t.money " + sing
							+ realsum + "), t.changetype = 'bpayrow', t.changeid = '" + payrowid + "'"
							+ " WHERE t.bankcardno = '" + bankcardno + "'";
						
						iReturn =  dbUtils.executeSQL(conn, sql);
						if(iReturn == -1) {
							break;
						}
					}
					*/
					
					if(iReturn >= 0) {
						conn.commit();
					} else {// 保存失败，回滚
						conn.rollback();
						if(iReturn >= 1 && currflow.equals("结束")) { //单据不能结束
							sql = "UPDATE bpay t SET t.currflow = '申请' WHERE t.payid = '" + payid + "'";
							dbUtils.executeSQL(sql);
						}
					}
				}
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			if(currflow.equals("结束") && payid != null) { //单据不能结束
				sql = "UPDATE bpay t SET t.currflow = '申请' WHERE t.payid = '" + payid + "'";
				dbUtils.executeSQL(sql);
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