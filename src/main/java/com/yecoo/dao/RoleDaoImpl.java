package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class RoleDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有角色
	 * @return
	 */
	public List<CodeTableForm> getRoleList() {
		
		String sql = "SELECT t.* FROM srole t ORDER BY priority";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取角色数量
	 * @param form
	 * @return
	 */
	public int getRoleCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.roleid) FROM srole t WHERE 1 = 1";
		String cond = getRoleListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取角色列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getRoleList(CodeTableForm form, int pageNum, int numPerPage) {
		
		String sql = "SELECT t.* FROM srole t WHERE 1 = 1";
		String cond = getRoleListCondition(form);
		sql  += cond;
		sql += " ORDER BY priority";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取角色列表-条件
	 * @param form
	 * @return
	 */
	public String getRoleListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String rolename = StrUtils.nullToStr(form.getValue("rolename"));
		
		if(!rolename.equals("")) {
			cond.append(" AND t.rolename like '%").append(rolename).append("%'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增角色
	 * @param form
	 * @return
	 */
	public int addRole(CodeTableForm form) {
		
		int iReturn = -1;
		int roleid = 0;
		String sql = null;
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false);//事务开启
			
			iReturn = dbUtils.setInsert(form, "srole", "");
			sql = "SELECT IFNULL(MAX(t.roleid),1) FROM srole t";
			roleid = Integer.parseInt(dbUtils.execQuerySQL(sql));
			
			//插入角色资源表
			if(iReturn > 0 && form.getValue("permission")!=null) {
				if(form.getValue("permission").toString().indexOf(":") > -1) {//只有一个资源
					sql = "INSERT INTO spermission(roleid,permission) VALUES ('"
							+ form.getValue("roleid") + "','" + form.getValue("permission") + "')";
					iReturn = dbUtils.executeSQL(conn, sql);
				} else {//多个资源
					String[] permission = (String[])form.getValue("permission");
					String[] sqls  = new String[permission.length];
					for(int i = 0; i< sqls.length; i++) {
						sqls[i] = "INSERT INTO spermission(roleid,permission) VALUES ('"
								+ roleid + "','" + permission[i] + "')";
					}
					iReturn = dbUtils.executeSQLs(conn, sqls);
				}
			}
			
			conn.commit();
		} catch(Exception e) {
			try {
				sql = "DELETE FROM srole WHERE roleid = '" + roleid + "'";
				dbUtils.executeSQL(sql);
				conn.rollback();
			} catch (SQLException e1) {

			}
			iReturn = -1;
			StrUtils.WriteLog(this.getClass().getName() + ".addRole()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		return iReturn;
	}
	/**
	 * 通过ID获取角色
	 * @param roleid
	 * @return
	 */
	public CodeTableForm getRoleById(int roleid) {
		
		String sql = "SELECT a.* FROM srole a WHERE a.roleid = '" + roleid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		sql = "SELECT t.permission FROM spermission t WHERE t.roleid = '" + roleid + "'";
		String permission = ";" + dbUtils.execQuerySQLReturnMulti(sql, ";") + ";";
		codeTableForm.setValue("permission", permission);
		return codeTableForm;
	}
	/**
	 * 修改角色
	 * @param form
	 * @return
	 */
	public int ediRole(CodeTableForm form) {
		
		int iReturn = -1;
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false);//事务开启
			
			iReturn = dbUtils.setUpdate(conn, form, "", "srole", "roleid", "");
			
			if(iReturn >= 0) {
				String sql = "DELETE FROM spermission WHERE roleid = '" + form.getValue("roleid") + "'";
				iReturn = dbUtils.executeSQL(conn, sql);
				//插入角色资源表
				if(iReturn >= 0 && form.getValue("permission")!=null) {
					if(form.getValue("permission").toString().indexOf(":") > -1) {//只有一个资源
						sql = "INSERT INTO spermission(roleid,permission) VALUES ('"
								+ form.getValue("roleid") + "','" + form.getValue("permission") + "')";
						iReturn = dbUtils.executeSQL(conn, sql);
					} else {//多个资源
						String[] permission = (String[])form.getValue("permission");
						String[] sqls  = new String[permission.length];
						for(int i = 0; i< sqls.length; i++) {
							sqls[i] = "INSERT INTO spermission(roleid,permission) VALUES ('"
									+ form.getValue("roleid") + "','" + permission[i] + "')";
						}
						iReturn = dbUtils.executeSQLs(conn, sqls);
					}
				}
			}
			
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {

			}
			iReturn = -1;
			StrUtils.WriteLog(this.getClass().getName() + ".ediRole()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

			}
		}
		return iReturn;
	}
	/**
	 * 删除角色
	 * @param roleid
	 * @return
	 */
	public int deleteRole(int roleid) {
		
		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM srole WHERE roleid = '" + roleid + "'";
		sqls[1] = "DELETE FROM spermission WHERE roleid = '" + roleid + "'";
		return dbUtils.executeSQLs(sqls);
	}
}