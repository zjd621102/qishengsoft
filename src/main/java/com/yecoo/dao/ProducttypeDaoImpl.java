package com.yecoo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class ProducttypeDaoImpl extends BaseDaoImpl {

	DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有产品类别
	 * @return
	 */
	public List<CodeTableForm> getProducttypeList() {
		
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> producttypeList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getProducttypeName(t.parent) parentname FROM sproducttype t"
				+ " WHERE t.parent = '1' ORDER BY t.priority, t.producttype";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = new CodeTableForm();
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
	    		producttypeList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getProducttypeList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return producttypeList;
	}
	/**
	 * 获取子产品类别列表
	 * @param form
	 * @return
	 */
	private List<CodeTableForm> getChildrenList(CodeTableForm form) {
		
	    Connection myConn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rs = null;
	    List<CodeTableForm> producttypeList = new ArrayList<CodeTableForm>();
	    CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getProducttypeName(t.parent) parentname FROM sproducttype t WHERE t.parent = '"
				+ form.getValue("producttype") + "' ORDER BY t.priority, t.producttype";
	    try {
	    	myConn = dbUtils.dbConnection();
	    	pStmt = myConn.prepareStatement(sql);
	    	rs = pStmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		codeTableForm = new CodeTableForm();
	    		codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
	    		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
	    		producttypeList.add(codeTableForm);
	    	}
	    } catch (Exception e) {
	    	StrUtils.WriteLog(this.getClass().getName() + ".getChildrenList()", e);
	    } finally {
	    	dbUtils.closeConnection(rs, pStmt, myConn);
	    }
		
		return producttypeList;
	}
	/**
	 * 获取产品类别数量
	 * @param form
	 * @return
	 */
	public int getProducttypeCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM sproducttype t WHERE 1 = 1";
		String cond = getProducttypeListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取产品类别列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getProducttypeList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getProducttypeName(t.parent) parentname FROM sproducttype t WHERE 1 = 1";
		String cond = getProducttypeListCondition(form);
		sql  += cond;
		sql += " ORDER BY priority, t.producttype";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取产品类别列表-条件
	 * @param form
	 * @return
	 */
	public String getProducttypeListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String producttypename = StrUtils.nullToStr(form.getValue("producttypename"));
		String producttypeno = StrUtils.nullToStr(form.getValue("producttypeno"));
		String parent = StrUtils.nullToStr(form.getValue("parent"));
		
		if(!producttypename.equals("")) {
			cond.append(" AND t.producttypename like '%").append(producttypename).append("%'");
		}
		if(!producttypeno.equals("")) {
			cond.append(" AND t.producttypeno like '%").append(producttypeno).append("%'");
		}
		if(!parent.equals("")) {
			cond.append(" AND t.parent = '").append(parent).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 通过ID获取产品类别
	 * @param producttype
	 * @return
	 */
	public CodeTableForm getProducttypeById(int producttype) {
		
		String sql = "SELECT t.*, func_getProducttypeName(t.parent) parentname FROM sproducttype t WHERE t.producttype = '"
				+ producttype + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
		return codeTableForm;
	}

	/**
	 * 校验编码是否可用
	 * @param producttype
	 * @param producttypeno
	 * @return
	 */
	public boolean checkNo(String producttype, String producttypeno) {
		boolean bRes = false;
		
		int iRes = 0;
		String sql = "SELECT COUNT(1) FROM sproducttype t WHERE t.producttypeno = '" + producttypeno + "'";
		if(!producttype.equals("")) {
			sql += " AND t.producttype <> '" + producttype + "'";
		}
		iRes = dbUtils.getIntBySql(sql);
		if(iRes == 0) {
			bRes = true;
		}
		
		return bRes;
	}
	
	/**
	 * 新增产品类别
	 * @param form
	 * @return
	 */
	public int addProducttype(CodeTableForm form) {
		
		return dbUtils.setInsert(form, "sproducttype");
	}
	/**
	 * 修改产品类别
	 * @param form
	 * @return
	 */
	public int ediProducttype(CodeTableForm form) {
		
		return dbUtils.setUpdate(form, "sproducttype", "producttype");
	}
	/**
	 * 删除产品类别
	 * @param producttype
	 * @return
	 */
	public int deleteProducttype(String producttype) {
		
		String sql = "DELETE FROM sproducttype WHERE producttype = " + producttype + "";
		return dbUtils.executeSQL(sql);
	}
}