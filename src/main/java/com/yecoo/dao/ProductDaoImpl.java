package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class ProductDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有产品
	 * @return
	 */
	public List<CodeTableForm> getProductList() {
		
		String sql = "SELECT t.* FROM sproduct t ORDER BY productid";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取产品数量
	 * @param form
	 * @return
	 */
	public int getProductCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM sproduct t WHERE 1 = 1";
		String cond = getProductListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取产品列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getProductList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getProducttypeName(t.producttype) producttypename,"
				+ " func_getUnitName(t.unit) unitname, func_getSum(t.productid, 'CPD') planprice"
				+ " FROM sproduct t WHERE 1 = 1";
		String cond = getProductListCondition(form);
		sql  += cond;
		sql += " ORDER BY productid";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取产品列表-条件
	 * @param form
	 * @return
	 */
	public String getProductListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String productname = StrUtils.nullToStr(form.getValue("productname"));
		String producttype = StrUtils.nullToStr(form.getValue("producttype"));
		
		if(!productname.equals("")) {
			cond.append(" AND t.productname like '%").append(productname).append("%'");
		}
		if(!producttype.equals("")) {
			cond.append(" AND t.producttype = '").append(producttype).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增产品
	 * @param form
	 * @return
	 */
	public int addProduct(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "sproduct", ""); //保存主表
			conn.commit();
			
			String sql = "SELECT IFNULL(MAX(productid), 1) FROM sproduct";
			int productid = dbUtils.getIntBySql(sql);
			form.setValue("productid", productid);
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "sproductrow", "productrowid", "productid", "", 1);
			}
			
			if(iReturn == -1) {
				dbUtils.setDelete(String.valueOf(productid), "sproduct", "productid");
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
			StrUtils.WriteLog(this.getClass().getName() + ".addProduct()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取产品
	 * @param productid
	 * @return
	 */
	public CodeTableForm getProductById(int productid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getProducttypeName(a.producttype) producttypename,"
				+ " func_getUnitName(a.unit) unitname, func_getSum(a.productid, 'CPD') planprice"
				+ " FROM sproduct a WHERE a.productid = '" + productid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.* FROM sproductrow a WHERE a.productid = '" + productid + "'";
		List<CodeTableForm> productrowList = dbUtils.getListBySql(sql);
		request.setAttribute("productrowList", productrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改产品
	 * @param form
	 * @return
	 */
	public int ediProduct(CodeTableForm form, HttpServletRequest request) {

		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(conn, form, "", "sproduct", "productid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "sproductrow", "productrowid", "productid", "", 1);
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
			StrUtils.WriteLog(this.getClass().getName() + ".ediProduct()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除产品
	 * @param productid
	 * @return
	 */
	public int deleteProduct(int productid) {
		
		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM sproduct WHERE productid = '" + productid + "'";
		sqls[1] = "DELETE FROM sproductrow WHERE productid = '" + productid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		System.out.println(sqls);
		return iReturn;
	}
}