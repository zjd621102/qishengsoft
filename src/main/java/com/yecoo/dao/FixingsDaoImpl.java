package com.yecoo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class FixingsDaoImpl extends BaseDaoImpl {

	DbUtils dbUtils = new DbUtils();

	/**
	 * 获取所有配件
	 * @return
	 */
	public List<CodeTableForm> getFixingsList() {

		Connection myConn = null;
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		List<CodeTableForm> fixingsList = new ArrayList<CodeTableForm>();
		CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getFixingsName(t.parentid) parentname"
				+ " FROM sfixings t WHERE t.parentid = '1' ORDER BY t.priority, t.fixingsid";
		try {
			myConn = dbUtils.dbConnection();
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();

			while (rs.next()) {
				codeTableForm = new CodeTableForm();
				codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
				codeTableForm.setValue("childrenList",
						getChildrenList(codeTableForm));
				fixingsList.add(codeTableForm);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getFixingsList()",
					e);
		} finally {
			dbUtils.closeConnection(rs, pStmt, myConn);
		}

		return fixingsList;
	}

	/**
	 * 获取子配件列表
	 * 
	 * @param form
	 * @return
	 */
	private List<CodeTableForm> getChildrenList(CodeTableForm form) {

		Connection myConn = null;
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		List<CodeTableForm> fixingsList = new ArrayList<CodeTableForm>();
		CodeTableForm codeTableForm = null;
		String sql = "SELECT t.*, func_getFixingsName(t.parentid) parentname"
				+ " FROM sfixings t WHERE t.parentid = '" + form.getValue("fixingsid")
				+ "' ORDER BY t.priority, t.fixingsid";
		try {
			myConn = dbUtils.dbConnection();
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();

			while (rs.next()) {
				codeTableForm = new CodeTableForm();
				codeTableForm = dbUtils.setFormRecord(codeTableForm, rs);
				codeTableForm.setValue("childrenList",
						getChildrenList(codeTableForm));
				fixingsList.add(codeTableForm);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getChildrenList()",
					e);
		} finally {
			dbUtils.closeConnection(rs, pStmt, myConn);
		}

		return fixingsList;
	}

	/**
	 * 获取配件数量
	 * 
	 * @param form
	 * @return
	 */
	public int getFixingsCount(CodeTableForm form) {

		String sql = "SELECT COUNT(1) FROM sfixings t WHERE 1 = 1";
		String cond = getFixingsListCondition(form);
		sql += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}

	/**
	 * 获取配件列表
	 * 
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getFixingsList(CodeTableForm form) {

		String sql = "SELECT t.*, func_getFixingsName(t.parentid) parentname FROM sfixings t WHERE 1 = 1";
		String cond = getFixingsListCondition(form);
		sql += cond;
		sql += " ORDER BY priority, t.fixingsid";
		sql += " LIMIT " + (pageNum - 1) * numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}

	/**
	 * 获取配件列表-条件
	 * 
	 * @param form
	 * @return
	 */
	public String getFixingsListCondition(CodeTableForm form) {

		StringBuffer cond = new StringBuffer("");
		String fixingsname = StrUtils.nullToStr(form.getValue("fixingsname"));
		String parentid = StrUtils.nullToStr(form.getValue("parentid"));

		if (!fixingsname.equals("")) {
			cond.append(" AND t.fixingsname like '%").append(fixingsname).append("%'");
		}
		if (!parentid.equals("")) {
			cond.append(" AND t.parentid = '").append(parentid).append("'");
		}

		return cond.toString();
	}

	/**
	 * 通过ID获取配件
	 * 
	 * @param fixingsid
	 * @return
	 */
	public CodeTableForm getFixingsById(int fixingsid) {

		String sql = "SELECT t.*, func_getFixingsName(t.parentid) parentname"
				+ " FROM sfixings t WHERE t.fixingsid = '" + fixingsid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		codeTableForm.setValue("childrenList", getChildrenList(codeTableForm));
		return codeTableForm;
	}

	/**
	 * 新增配件
	 * 
	 * @param form
	 * @return
	 */
	public int addFixings(CodeTableForm form) {

		return dbUtils.setInsert(form, "sfixings");
	}

	/**
	 * 修改配件
	 * 
	 * @param form
	 * @return
	 */
	public int ediFixings(CodeTableForm form) {

		return dbUtils.setUpdate(form, "sfixings", "fixingsid");
	}

	/**
	 * 删除配件
	 * 
	 * @param fixingsid
	 * @return
	 */
	public int deleteFixings(String fixingsid) {

		String sql = "DELETE FROM sfixings WHERE fixingsid = " + fixingsid + "";
		return dbUtils.executeSQL(sql);
	}
	
	/**
	 * 获取配件列表
	 * @return
	 */
	public List<HashMap<String, Object>> getAllFixingsList() {

		String sql = "SELECT a.fixingsid, a.fixingsname"
				+ " FROM sfixings a LEFT JOIN smaterial b ON a.materialno = b.materialno"
				+ " WHERE a.parentid = '1' ORDER BY a.priority";
		List<CodeTableForm> ParentList = dbUtils.getListBySql(sql);
		
		List<HashMap<String, Object>> allList = new ArrayList<>();
		HashMap<String, Object> allMap = null;
		List<CodeTableForm> childList = null;
		
		for (CodeTableForm parentForm : ParentList) {
			sql = "SELECT a.fixingsname, c.manuname, b.materialname, b.price, a.description, b.numofonebox"
				+ " FROM sfixings a LEFT JOIN smaterial b ON a.materialno = b.materialno"
				+ " LEFT JOIN smanu c ON b.manuid = c.manuid WHERE a.parentid = '"
				+ parentForm.getValue("fixingsid") + "' ORDER BY a.priority";
			childList = dbUtils.getListBySql(sql);
			
			allMap = new HashMap<>();
			allMap.put("parentname", parentForm.getValue("fixingsname"));
			allMap.put("childList", childList);
			
			allList.add(allMap);
		}
		
		return allList;
	}
}