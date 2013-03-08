package com.yecoo.dao;

import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class StaffDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取员工数量
	 * @param form
	 * @return
	 */
	public int getStaffCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.staffid) FROM sstaff t WHERE 1 = 1";
		String cond = getStaffListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取员工列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getStaffList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getStaffstatusName(t.staffstatus) staffstatusname,"
				+ " func_getStafftypeName(t.stafftype) stafftypename FROM sstaff t WHERE 1 = 1";
		String cond = getStaffListCondition(form);
		sql  += cond;
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取员工列表-条件
	 * @param form
	 * @return
	 */
	public String getStaffListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String staffname = StrUtils.nullToStr(form.getValue("staffname"));
		String staffstatus = StrUtils.nullToStr(form.getValue("staffstatus"));
		
		if(!staffname.equals("")) {
			cond.append(" AND t.staffname like '%").append(staffname).append("%'");
		}
		if(!staffstatus.equals("")) {
			cond.append(" AND t.staffstatus = '").append(staffstatus).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增员工
	 * @param form
	 * @return
	 */
	public int addStaff(CodeTableForm form) {
		
		int iReturn = dbUtils.setInsert(form, "sstaff", "");
		return iReturn;
	}
	/**
	 * 通过ID获取员工
	 * @param staffid
	 * @return
	 */
	public CodeTableForm getStaffById(int staffid) {
		
		String sql = "SELECT a.*, func_getStaffstatusName(a.staffstatus) staffstatusname,"
				+ " func_getStafftypeName(a.stafftype) stafftypename FROM sstaff a WHERE a.staffid = '" + staffid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	/**
	 * 修改员工
	 * @param form
	 * @return
	 */
	public int ediStaff(CodeTableForm form) {
		
		int iReturn = dbUtils.setUpdate(form, "", "sstaff", "staffid", "");
		return iReturn;
	}
	/**
	 * 删除员工
	 * @param staffid
	 * @return
	 */
	public int deleteStaff(int staffid) {
		
		String sql = "DELETE FROM sstaff WHERE staffid = '" + staffid + "'";
		int iReturn = dbUtils.executeSQL(sql);
		return iReturn;
	}
}