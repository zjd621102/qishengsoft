package com.yecoo.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.IdSingleton;
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
				+ " func_getDictName('计量单位', t.unit) unitname FROM sproduct t WHERE 1 = 1";
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
		String materialtypeno = StrUtils.nullToStr(form.getValue("materialtypeno"));
		
		if(!productname.equals("")) {
			cond.append(" AND t.productname like '%").append(productname).append("%'");
		}
		if(!producttype.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM sproducttype m WHERE m.producttype = t.producttype AND CONCAT('-', m.producttypeall, '-') LIKE '%-").append(producttype).append("-%')");
		}
		if(!materialtypeno.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM sproductrow n WHERE n.productid = t.productid AND n.materialno = '")
				.append(materialtypeno).append("')");
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
			
			String productid = IdSingleton.getInstance().getNewId();
			form.setValue("productid", productid);
			
			iReturn = dbUtils.setInsert(conn, form, "sproduct", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "sproductrow", "productrowid", "productid", "", 1);
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
				+ " func_getDictName('计量单位', a.unit) unitname FROM sproduct a WHERE a.productid = '" + productid + "'";
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
	public int deleteProduct(int productid, HttpServletRequest request) {
		
		String filePath = null;
		
		String sql = "SELECT t.fileid, t.suffix FROM sfile t WHERE t.pid = '" + productid + "'";
		List<CodeTableForm> fileList = dbUtils.getListBySql(sql);
		
		String[] sqls = new String[3];
		sqls[0] = "DELETE FROM sproduct WHERE productid = '" + productid + "'";
		sqls[1] = "DELETE FROM sproductrow WHERE productid = '" + productid + "'";
		sqls[2] = "DELETE FROM sfile WHERE pid = '" + productid + "'";// 删除附件
		int iReturn = dbUtils.executeSQLs(sqls);
		
		// 删除附件
		String ctxPath = request.getSession().getServletContext().getRealPath("/")
				+ Constants.PATH_FILE;
		for(CodeTableForm form : fileList) {
			filePath = ctxPath + form.getValue("fileid") + "." + form.getValue("suffix");
			File file = new File(filePath);
			if (file.exists()) {
				file.delete();
			}
		}
		
		return iReturn;
	}
	
	/**
	 * 获取产品树
	 * @param form
	 * @param path		项目路径
	 * @param curTime	当前时间HHmmss
	 * @return
	 */
	public String tree(CodeTableForm form, String path, String curTime) {
		if (form.getValue("childrenList")==null || ((List<CodeTableForm>) form.getValue("childrenList")).isEmpty()) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul>" + "\n");
		for (Object obj : (List) form.getValue("childrenList")) {
			CodeTableForm o = (CodeTableForm) obj;
			buffer.append("<li><a href=\"" + path + "/product/list/"
					+ o.getValue("producttype")
					+ "?curTime=" + curTime + "\" target=\"ajax\" rel=\"jbsxBox2product" + curTime + "\">"
					+ o.getValue("producttypename") + "</a>" + "\n");
			buffer.append(tree(o, path, curTime));
			buffer.append("</li>" + "\n");
		}
		buffer.append("</ul>" + "\n");
		return buffer.toString();
	}
}