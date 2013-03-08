package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class ManuDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取供应商数量
	 * @param form
	 * @return
	 */
	public int getManuCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.manuid) FROM smanu t WHERE 1 = 1";
		String cond = getManuListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取供应商列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getManuList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getManutypeName(manutypeid) manutypename ,"
				+ " func_getStatusName(statusid) statusname,"
				+ " (SELECT sm.bankrow FROM smanurow sm"
				+ " WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1) manubankname,"
				+ " (SELECT sm.accountnorow FROM smanurow sm"
				+ " WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1) manubankcardno,"
				+ " (SELECT sm.accountnamerow FROM smanurow sm"
				+ " WHERE sm.manuid = t.manuid ORDER BY priorityrow LIMIT 0,1) manuaccountname"
				+ " FROM smanu t WHERE 1 = 1";
		String cond = getManuListCondition(form);
		sql  += cond;
		sql += " ORDER BY manuid";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取供应商列表-条件
	 * @param form
	 * @return
	 */
	public String getManuListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String manuname = StrUtils.nullToStr(form.getValue("manuname"));
		String manutypeid = StrUtils.nullToStr(form.getValue("manutypeid"));
		String statusid = StrUtils.nullToStr(form.getValue("statusid"));
		
		if(!manuname.equals("")) {
			cond.append(" AND t.manuname like '%").append(manuname).append("%'");
		}
		if(!manutypeid.equals("")) {
			cond.append(" AND t.manutypeid = '").append(manutypeid).append("'");
		}
		if(!statusid.equals("")) {
			cond.append(" AND t.statusid = '").append(statusid).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增供应商
	 * @param form
	 * @return
	 */
	public int addManu(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "smanu", ""); //保存主表
			conn.commit();
			
			String sql = "SELECT IFNULL(MAX(manuid), 1) FROM smanu";
			int manuid = dbUtils.getIntBySql(sql);
			form.setValue("manuid", manuid);
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "smanurow", "manurowid", "manuid", "", 1);
			}
			
			if(iReturn == -1) {
				dbUtils.setDelete(String.valueOf(manuid), "smanu", "manuid");
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
			StrUtils.WriteLog(this.getClass().getName() + ".addManu()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取供应商
	 * @param manuid
	 * @return
	 */
	public CodeTableForm getManuById(int manuid, HttpServletRequest request) {
		
		String sql = "SELECT a.* FROM smanu a WHERE a.manuid = '" + manuid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.* FROM smanurow a WHERE a.manuid = '" + manuid + "' ORDER BY priorityrow";
		List<CodeTableForm> manurowList = dbUtils.getListBySql(sql);
		request.setAttribute("manurowList", manurowList);
		
		return codeTableForm;
	}
	/**
	 * 修改供应商
	 * @param form
	 * @return
	 */
	public int ediManu(CodeTableForm form, HttpServletRequest request) {

		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(form, "", "smanu", "manuid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "smanurow", "manurowid", "manuid", "", 1);
			}
			
			conn.commit();
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediManu()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除供应商
	 * @param manuid
	 * @return
	 */
	public int deleteManu(int manuid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM smanu WHERE manuid = '" + manuid + "'";
		sqls[1] = "DELETE FROM smanurow WHERE manuid = '" + manuid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
}