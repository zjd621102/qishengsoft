package com.yecoo.dao;

import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class UnitDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有单位
	 * @return
	 */
	public List<CodeTableForm> getUnitList() {
		
		String sql = "SELECT t.* FROM cunit t ORDER BY priority";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取单位数量
	 * @param form
	 * @return
	 */
	public int getUnitCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.unitid) FROM cunit t WHERE 1 = 1";
		String cond = getUnitListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取单位列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getUnitList(CodeTableForm form) {
		
		String sql = "SELECT t.* FROM cunit t WHERE 1 = 1";
		String cond = getUnitListCondition(form);
		sql  += cond;
		sql += " ORDER BY priority";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取单位列表-条件
	 * @param form
	 * @return
	 */
	public String getUnitListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String unitname = StrUtils.nullToStr(form.getValue("unitname"));
		
		if(!unitname.equals("")) {
			cond.append(" AND t.unitname like '%").append(unitname).append("%'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增单位
	 * @param form
	 * @return
	 */
	public int addUnit(CodeTableForm form) {
		
		int iReturn = dbUtils.setInsert(form, "cunit", "");
		return iReturn;
	}
	/**
	 * 通过ID获取单位
	 * @param unitid
	 * @return
	 */
	public CodeTableForm getUnitById(int unitid) {
		
		String sql = "SELECT a.* FROM cunit a WHERE a.unitid = '" + unitid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	/**
	 * 修改单位
	 * @param form
	 * @return
	 */
	public int ediUnit(CodeTableForm form) {
		
		int iReturn = dbUtils.setUpdate(form, "", "cunit", "unitid", "");
		return iReturn;
	}
	/**
	 * 删除单位
	 * @param unitid
	 * @return
	 */
	public int deleteUnit(int unitid) {
		
		String sql = "DELETE FROM cunit WHERE unitid = '" + unitid + "'";
		int iReturn = dbUtils.executeSQL(sql);
		return iReturn;
	}
}