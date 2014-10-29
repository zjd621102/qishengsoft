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
//			month = DateUtils.getAdjustTime(DateUtils.getNowDateTime(), "month", "", 1);// 默认为上个月
			month = DateUtils.getNowDate();
			month = month.substring(0, 7);
			form.setValue("month", month);
		}
		
		String sql = "SELECT t.*, func_getDictName('员工状态', t.staffstatus) staffstatusname,"
				+ " func_getDictName('员工类别', t.stafftype) stafftypename,"
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
		
		String sql = "SELECT a.*, func_getDictName('员工状态', a.staffstatus) staffstatusname,"
				+ " func_getDictName('员工类别', a.stafftype) stafftypename FROM sstaff a WHERE a.staffid = '" + staffid + "'";
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
		String workmonth = StrUtils.nullToStr(form.getValue("workmonth"));
		
		String sql = "SELECT a.*, b.staffname, b.salary FROM bwork a, sstaff b WHERE a.staffid = b.staffid AND a.staffid = '"
				+ staffid + "' AND a.workmonth = '" + workmonth + "' ORDER BY b.staffid";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.* FROM bworkrow a WHERE a.workid = '" + codeTableForm.getValue("workid") + "'";
		List<CodeTableForm> workrowList = dbUtils.getListBySql(sql);
		request.setAttribute("workrowList", workrowList);
		
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
			
			iReturn = dbUtils.setUpdate(form, "", "bwork", "workid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bworkrow", "workrowid", "workid", "", 0);
			}
			
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
		Connection conn = null;
		boolean res = true;
		int ires = 0;
		try {
			if(!"".equals(month)) {
				String sql = "SELECT staffid FROM sstaff WHERE staffstatus = '1'";
				List<CodeTableForm> staffList = dbUtils.getListBySql(sql);
				for(CodeTableForm form : staffList) {
					staffid = StrUtils.nullToStr(form.getValue("staffid"));
					sql = "SELECT COUNT(1) FROM bwork t WHERE t.workmonth = '" + month + "' AND t.staffid = '"
							+ staffid + "' AND EXISTS (SELECT 1 FROM bworkrow b WHERE b.workid = t.workid)";
					int worknum = dbUtils.getIntBySql(sql);
					if(worknum == 0) {
						sql = "SELECT t.workid FROM bwork t WHERE t.workmonth = '" + month + "' AND t.staffid = '" + staffid + "';";
						String workid = dbUtils.execQuerySQL(sql);
						
						if(workid.equals("")) {
							sql = "INSERT INTO bwork(workmonth, staffid) VALUES ('" + month + "', '" + staffid + "')";
							dbUtils.executeSQL(sql);
						}

						sql = "SELECT t.workid FROM bwork t WHERE t.workmonth = '" + month + "' AND t.staffid = '" + staffid + "';";
						workid = dbUtils.execQuerySQL(sql);

						conn = dbUtils.dbConnection();
						conn.setAutoCommit(false); //事务开启
						
						List<String> dateList = DateUtils.getMonthDate(month);
						for(String date : dateList) {
							sql = "INSERT INTO bworkrow(workid, workdate) VALUES ('" + workid + "', '" + date + "')";
							ires = dbUtils.executeSQL(conn, sql);
							if(ires <= 0) {
								res = false;
								break;
							}
						}
						
						if(res) {
							conn.commit();
						} else {
							conn.rollback();
						}
					}
				}
			}
		} catch(Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".initWork()", e);
		} finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				StrUtils.WriteLog(this.getClass().getName() + ".initWork()", e);
			}
		}
	}
}