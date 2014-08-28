package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 字典DAO
 * @author zhoujd
 * @date   2014年8月21日 上午10:32:24
 */
public class DictDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取字典数量
	 * @param form
	 * @return
	 */
	public int getDictCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM cdict t WHERE 1 = 1";
		String cond = getDictListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取字典列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getDictList(CodeTableForm form) {
		
		String sql = "SELECT t.* FROM cdict t WHERE 1 = 1";
		String cond = getDictListCondition(form);
		sql  += cond;
		sql += " ORDER BY t.createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取字典列表-条件
	 * @param form
	 * @return
	 */
	public String getDictListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		
		String dicttype = StrUtils.nullToStr(form.getValue("dicttype"));

		if(!dicttype.equals("")) {
			cond.append(" AND t.dicttype = '").append(dicttype).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增字典
	 * @param form
	 * @return
	 */
	public int addDict(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "cdict", ""); //保存主表
			conn.commit();
			
			String sql = "SELECT IFNULL(MAX(dictid), 1) FROM cdict";
			int dictid = dbUtils.getIntBySql(sql);
			form.setValue("dictid", dictid);
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "cdictrow", "dictrowid", "dictid", "", 1);
			}
			
			if(iReturn == -1) {
				dbUtils.setDelete(String.valueOf(dictid), "cdict", "dictid");
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
			StrUtils.WriteLog(this.getClass().getName() + ".addDict()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取字典
	 * @param dictid
	 * @return
	 */
	public CodeTableForm getDictById(int dictid, HttpServletRequest request) {
		
		String sql = "SELECT a.* FROM cdict a WHERE a.dictid = '" + dictid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.* FROM cdictrow a WHERE a.dictid = '" + dictid + "' ORDER BY sordid";
		List<CodeTableForm> dictrowList = dbUtils.getListBySql(sql);
		request.setAttribute("dictrowList", dictrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改字典
	 * @param form
	 * @return
	 */
	public int ediDict(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(form, "", "cdict", "dictid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "cdictrow", "dictrowid", "dictid", "", 1);
			}
			
			conn.commit();
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediDict()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除字典
	 * @param dictid
	 * @return
	 */
	public int deleteDict(int dictid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM cdict WHERE dictid = '" + dictid + "'";
		sqls[1] = "DELETE FROM cdictrow WHERE dictid = '" + dictid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
}