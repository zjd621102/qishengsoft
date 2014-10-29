package com.yecoo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class MaterialtypeDaoImpl extends BaseDaoImpl {

	DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有物资类型
	 * @return
	 */
	public List<CodeTableForm> getMaterialtypeList() {
		
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> materialtypeList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getMaterialtypeName(t.parent) parentname FROM smaterialtype t"
				+ " WHERE t.parent = '1' ORDER BY t.priority, t.materialtype";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = new CodeTableForm();
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
	    		materialtypeList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getMaterialtypeList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return materialtypeList;
	}
	/**
	 * 获取子物资类型列表
	 * @param form
	 * @return
	 */
	private List<CodeTableForm> getChildrenList(CodeTableForm form) {
		
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> materialtypeList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getMaterialtypeName(t.parent) parentname FROM smaterialtype t WHERE t.parent = '"
				+ form.getValue("materialtype") + "' ORDER BY t.priority, t.materialtype";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = new CodeTableForm();
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
	    		materialtypeList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getChildrenList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return materialtypeList;
	}
	/**
	 * 获取物资类型数量
	 * @param form
	 * @return
	 */
	public int getMaterialtypeCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM smaterialtype t WHERE 1 = 1";
		String cond = getMaterialtypeListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取物资类型列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getMaterialtypeList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getMaterialtypeName(t.parent) parentname FROM smaterialtype t WHERE 1 = 1";
		String cond = getMaterialtypeListCondition(form);
		sql  += cond;
		sql += " ORDER BY priority, t.materialtype";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取物资类型列表-条件
	 * @param form
	 * @return
	 */
	public String getMaterialtypeListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String materialtypename = StrUtils.nullToStr(form.getValue("materialtypename"));
		String materialtypeno = StrUtils.nullToStr(form.getValue("materialtypeno"));
		String parent = StrUtils.nullToStr(form.getValue("parent"));
		
		if(!materialtypename.equals("")) {
			cond.append(" AND t.materialtypename like '%").append(materialtypename).append("%'");
		}
		if(!materialtypeno.equals("")) {
			cond.append(" AND t.materialtypeno like '%").append(materialtypeno).append("%'");
		}
		if(!parent.equals("")) {
			cond.append(" AND t.parent = '").append(parent).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 通过ID获取物资类型
	 * @param materialtype
	 * @return
	 */
	public CodeTableForm getMaterialtypeById(int materialtype) {
		
		String sql = "SELECT t.*, func_getMaterialtypeName(t.parent) parentname FROM smaterialtype t WHERE t.materialtype = '"
				+ materialtype + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
		return codeTableForm;
	}
	
	/**
	 * 校验编码是否可用
	 * @param materialtype
	 * @param materialtypeno
	 * @return
	 */
	public boolean checkNo(String materialtype, String materialtypeno) {
		boolean bRes = false;
		
		int iRes = 0;
		String sql = "SELECT COUNT(1) FROM smaterialtype t WHERE t.materialtypeno = '" + materialtypeno + "'";
		if(!materialtype.equals("")) {
			sql += " AND t.materialtype <> '" + materialtype + "'";
		}
		iRes = dbUtils.getIntBySql(sql);
		if(iRes == 0) {
			bRes = true;
		}
		
		return bRes;
	}
	
	/**
	 * 新增物资类型
	 * @param form
	 * @return
	 */
	public int addMaterialtype(CodeTableForm form) {
		
		return dbUtils.setInsert(form, "smaterialtype");
	}
	/**
	 * 修改物资类型
	 * @param form
	 * @return
	 */
	public int ediMaterialtype(CodeTableForm form) {
		
		return dbUtils.setUpdate(form, "smaterialtype", "materialtype");
	}
	/**
	 * 删除物资类型
	 * @param materialtype
	 * @return
	 */
	public int deleteMaterialtype(String materialtype) {
		
		String sql = "DELETE FROM smaterialtype WHERE materialtype = " + materialtype + "";
		return dbUtils.executeSQL(sql);
	}
}