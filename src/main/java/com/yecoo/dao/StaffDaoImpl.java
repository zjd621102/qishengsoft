package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DateUtils;
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
		
		String month = StrUtils.nullToStr(form.getValue("month"));
		if(month.equals("")) {
			month = DateUtils.getAdjustTime(DateUtils.getNowDateTime(), "month", "", 1);// 默认为上个月
			month = month.substring(0, 7);
			form.setValue("month", month);
		}
		
		String sql = "SELECT t.*, func_getStaffstatusName(t.staffstatus) staffstatusname,"
				+ " func_getStafftypeName(t.stafftype) stafftypename,"
				+ " func_getSalaryByMonth(t.staffid, '" + month + "') monthsalary FROM sstaff t WHERE 1 = 1";
		
		String cond = getStaffListCondition(form);
		sql += cond;
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
	/**
	 * 获取员工考勤信息
	 * @param form
	 * @param request
	 * @return
	 */
	public CodeTableForm getWork(CodeTableForm form, HttpServletRequest request) {
		
		int staffid = Integer.parseInt(StrUtils.nullToStr(form.getValue("staffid")));
		CodeTableForm codeTableForm = this.getStaffById(staffid);
		
		String sql = "SELECT t.* FROM bwork t WHERE t.staffid = '" + staffid + "'";
		String cond = getWorkCondition(form);
		sql += cond;
		sql += " ORDER BY t.workdate";
		List<CodeTableForm> workList = dbUtils.getListBySql(sql);
		request.setAttribute("workList", workList);
		return codeTableForm;
	}
	/**
	 * 获取员工考勤信息-条件
	 * @param form
	 * @return
	 */
	public String getWorkCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String staffid = StrUtils.nullToStr(form.getValue("staffid"));
		String month = StrUtils.nullToStr(form.getValue("month"));

		if(!staffid.equals("")) {
			cond.append(" AND t.staffid = '").append(staffid).append("'");
		}
		if(!month.equals("")) {
			cond.append(" AND t.workdate like '").append(month).append("%'");
		}
		
		return cond.toString();
	}
	/**
	 * 修改员工考勤
	 * @param form
	 * @return
	 */
	public int ediWork(CodeTableForm form, HttpServletRequest request) {

		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			iReturn = dbUtils.saveRowTable(request, conn, form, "bwork", "workid", "staffid", "", 0);
			if(iReturn == -1) {
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
			StrUtils.WriteLog(this.getClass().getName() + ".ediWork()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 初始化月份考勤
	 * @param month
	 */
	public void initWork(String month) {
		
		String staffid = null;
		if(!"".equals(month)) {
			String sql = "SELECT staffid FROM sstaff WHERE staffstatus = '1'";
			List<CodeTableForm> staffList = dbUtils.getListBySql(sql);
			for(CodeTableForm form : staffList) {
				staffid = StrUtils.nullToStr(form.getValue("staffid"));
				sql = "SELECT COUNT(1) FROM bwork t WHERE t.workdate like '" + month + "%' AND t.staffid = '"
						+ staffid + "'";
				int worknum = dbUtils.getIntBySql(sql);
				if(worknum==0) {
					sql = "call proc_initWorkByStaff('" + month + "', '" + staffid + "')";
					dbUtils.executeSQL(sql);
				}
			}
		}
	}
}