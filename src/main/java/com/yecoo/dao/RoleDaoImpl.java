package com.yecoo.dao;

import java.util.List;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class RoleDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	
	public List<CodeTableForm> getRoleList() {
		String sql = "SELECT t.* FROM srole t ORDER BY priority";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	
	public int getRoleCount(CodeTableForm form) {
		String sql = "SELECT COUNT(t.roleid) FROM srole t WHERE 1 = 1";
		String cond = getRoleListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}

	public List<CodeTableForm> getRoleList(CodeTableForm form, int pageNum, int numPerPage) {
		String sql = "SELECT t.* FROM srole t WHERE 1 = 1";
		String cond = getRoleListCondition(form);
		sql  += cond;
		sql += " ORDER BY priority";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	
	public String getRoleListCondition(CodeTableForm form) {
		StringBuffer cond = new StringBuffer("");
		String rolename = StrUtils.nullToStr(form.getValue("rolename"));
		
		if(!rolename.equals("")) {
			cond.append(" AND t.rolename like '%").append(rolename).append("%'");
		}
		
		return cond.toString();
	}
	
	public int addRole(CodeTableForm form) {
		int iReturn = 0;
		iReturn = dbUtils.setInsert(form, "srole");
		
		//插入角色资源表
		if(iReturn > 0) {
			String[] permission = (String[])form.getValue("permission");
			System.out.println(permission.length);
		}
		return iReturn;
	}
	
	public CodeTableForm getRoleById(int roleid) {
		String sql = "SELECT a.* FROM srole a WHERE a.roleid = '" + roleid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	
	public int ediRole(CodeTableForm form) {
		int iReturn = 0;
		iReturn = dbUtils.setUpdate(form, "srole", "roleid");
		
		//插入角色资源表
		if(iReturn > 0) {
			String sql = "DELETE FROM spermission t WHERE t.roleid = '" + form.getValue("roleid") + "'";
			dbUtils.execQuerySQL(sql);
			String[] permission = (String[])form.getValue("permission");
			System.out.println(permission.length);
		}
		return iReturn;
	}

	public int deleteRole(int roleid) {
		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM srole WHERE roleid = '" + roleid + "'";
		sqls[1] = "DELETE FROM spermission WHERE roleid = '" + roleid + "'";
		return dbUtils.executeSQLs(sqls);
	}
}