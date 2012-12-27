package com.yecoo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class ModuleDaoImpl {

	DbUtils dbUtils = new DbUtils();
	
	public List<CodeTableForm> getModuleList() {
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> moduleList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.* FROM module t WHERE t.parentid = '1' ORDER BY t.priority, t.moduleid ASC";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		sql = "SELECT t.* FROM module t WHERE t.parentid = '" + rs.getString("moduleid")
	    			+ "' ORDER BY t.priority, t.moduleid ASC";
	    		codeTableForm.setValue("childrenList", dbUtils.getListBySql(sql));
	    		moduleList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getModuleList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return moduleList;
	}
}