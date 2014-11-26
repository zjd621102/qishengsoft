package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.IdSingleton;
import com.yecoo.util.StrUtils;

public class SalaryDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取工资单数量
	 * @param form
	 * @return
	 */
	public int getSalaryCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM bsalary t WHERE 1 = 1";
		String cond = getSalaryListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取工资单列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getSalaryList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getUserName(t.maker) makername,"
				+ " func_getDictName('工资类型', t.salarytype) salarytypename,"
				+ " func_getSum(t.salaryid, 'GZD') allplanmoney FROM bsalary t WHERE 1 = 1";
		String cond = getSalaryListCondition(form);
		sql  += cond;
		sql += " ORDER BY salaryid DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取工资单列表-条件
	 * @param form
	 * @return
	 */
	public String getSalaryListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String salaryname = StrUtils.nullToStr(form.getValue("salaryname"));
		String salaryno = StrUtils.nullToStr(form.getValue("salaryno"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		
		if(!salaryname.equals("")) {
			cond.append(" AND t.salaryname like '%").append(salaryname).append("%'");
		}
		if(!salaryno.equals("")) {
			cond.append(" AND t.salaryno like '%").append(salaryno).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增工资单
	 * @param form
	 * @return
	 */
	public int addSalary(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			String salaryid = IdSingleton.getInstance().getNewId();
			form.setValue("salaryid", salaryid);
			
			iReturn = dbUtils.setInsert(conn, form, "bsalary", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bsalaryrow", "salaryrowid", "salaryid", "", 1);
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
			StrUtils.WriteLog(this.getClass().getName() + ".addSalary()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取工资单
	 * @param salaryid
	 * @return
	 */
	public CodeTableForm getSalaryById(int salaryid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getUserName(a.maker) makername, func_getDictName('工资类型', a.salarytype) salarytypename"
				+ " FROM bsalary a WHERE a.salaryid = '" + salaryid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.*, func_getStaffName(a.staffid) staffname FROM bsalaryrow a WHERE a.salaryid = '" + salaryid + "'";
		List<CodeTableForm> salaryrowList = dbUtils.getListBySql(sql);
		request.setAttribute("salaryrowList", salaryrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改工资单
	 * @param form
	 * @return
	 */
	public int ediSalary(CodeTableForm form, HttpServletRequest request) {

		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(conn, form, "", "bsalary", "salaryid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bsalaryrow", "salaryrowid", "salaryid", "", 1);
			}
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
				String maker = StrUtils.nullToStr(user.getValue("userid")); //当前登录用户
				String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss");
				String salaryid = StrUtils.nullToStr(form.getValue("salaryid"));

				String payid = IdSingleton.getInstance().getNewId();
				
				StringBuffer sql = new StringBuffer("INSERT INTO bpay(payid, btype, maker, paydate, relateno, relatemoney,")
					.append(" currflow, createtime)	SELECT '").append(payid).append("', 'GZD', '").append(maker)
					.append("', salarydate, salaryno, func_getSum(salaryid, 'GZD'), '申请', '").append(createdate)
					.append("' FROM bsalary WHERE salaryid = '").append(salaryid).append("'");

				iReturn = dbUtils.executeSQL(conn, sql.toString()); //直接保存，用于下面获取payid
				
				if(iReturn >= 1) {
					sql.delete(0,sql.length());
					sql.append("INSERT INTO bpayrow(payid, manubankname, manubankcardno, manuaccountname, plansum, realsum)")
						.append(" SELECT ").append(payid).append(",")
						.append(" (SELECT ss.bank FROM sstaff ss WHERE ss.staffid = t.staffid),")
						.append(" (SELECT ss.accountno FROM sstaff ss WHERE ss.staffid = t.staffid),")
						.append(" (SELECT ss.accountname FROM sstaff ss WHERE ss.staffid = t.staffid),")
						.append(" t.planmoney, t.planmoney")
						.append(" FROM (SELECT staffid, SUM(planmoney) planmoney FROM bsalaryrow WHERE salaryid = '").append(salaryid)
						.append("' GROUP BY staffid) t");
					iReturn = dbUtils.executeSQL(conn, sql.toString());
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
				
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediSalary()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除工资单
	 * @param salaryid
	 * @return
	 */
	public int deleteSalary(int salaryid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM bsalary WHERE salaryid = '" + salaryid + "'";
		sqls[1] = "DELETE FROM bsalaryrow WHERE salaryid = '" + salaryid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
}