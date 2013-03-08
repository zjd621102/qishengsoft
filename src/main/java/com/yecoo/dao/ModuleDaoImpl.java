package com.yecoo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class ModuleDaoImpl extends BaseDaoImpl {

	DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有模块
	 * @return
	 */
	public List<CodeTableForm> getModuleList() {
		
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> moduleList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getModuleName(t.parentid) parentname FROM smodule t WHERE t.parentid = '1' ORDER BY t.priority, t.moduleid";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = new CodeTableForm();
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
	    		moduleList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getModuleList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return moduleList;
	}
	/**
	 * 获取子模块列表
	 * @param form
	 * @return
	 */
	private List<CodeTableForm> getChildrenList(CodeTableForm form) {
		
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> moduleList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getModuleName(t.parentid) parentname FROM smodule t WHERE t.parentid = '" + form.getValue("moduleid")
			+ "' ORDER BY t.priority, t.moduleid";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = new CodeTableForm();
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
	    		moduleList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getChildrenList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return moduleList;
	}
	/**
	 * 获取模块数量
	 * @param form
	 * @return
	 */
	public int getModuleCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM smodule t WHERE 1 = 1";
		String cond = getModuleListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取模块列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getModuleList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getModuleName(t.parentid) parentname FROM smodule t WHERE 1 = 1";
		String cond = getModuleListCondition(form);
		sql  += cond;
		sql += " ORDER BY priority, t.moduleid";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取模块列表-条件
	 * @param form
	 * @return
	 */
	public String getModuleListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String modulename = StrUtils.nullToStr(form.getValue("modulename"));
		String parentid = StrUtils.nullToStr(form.getValue("parentid"));
		
		if(!modulename.equals("")) {
			cond.append(" AND t.modulename like '%").append(modulename).append("%'");
		}
		if(!parentid.equals("")) {
			cond.append(" AND t.parentid = '").append(parentid).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 通过ID获取模块
	 * @param moduleid
	 * @return
	 */
	public CodeTableForm getModuleById(int moduleid) {
		
		String sql = "SELECT t.*, func_getModuleName(t.parentid) parentname FROM smodule t WHERE t.moduleid = '"
				+ moduleid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
		return codeTableForm;
	}
	/**
	 * 新增模块
	 * @param form
	 * @return
	 */
	public int addModule(CodeTableForm form) {
		
		return dbUtils.setInsert(form, "smodule");
	}
	/**
	 * 修改模块
	 * @param form
	 * @return
	 */
	public int ediModule(CodeTableForm form) {
		
		return dbUtils.setUpdate(form, "smodule", "moduleid");
	}
	/**
	 * 删除模块
	 * @param moduleid
	 * @return
	 */
	public int deleteModule(String moduleid) {
		
		String sql = "DELETE FROM smodule WHERE moduleid = " + moduleid + "";
		return dbUtils.executeSQL(sql);
	}
}