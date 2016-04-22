package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.LogDaoImpl;
import com.yecoo.dao.StaffDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 员工管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/staff")
public class StaffAction {

	private StaffDaoImpl staffDaoImpl = new StaffDaoImpl();

	@RequiresPermissions("Staff:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String first = StrUtils.nullToStr(request.getParameter("first")); //查询初始化
		if(first.equals("true")) {
			form.setValue("staffstatus", "1");
		}
		staffDaoImpl.initAction(request);

		int totalCount = staffDaoImpl.getStaffCount(form);
		List<CodeTableForm> staffList = staffDaoImpl.getStaffList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("staffList", staffList); // 员工列表
		request.setAttribute("sn", "staff"); //授权名称
		request.setAttribute("form", form);
		
		return "staff/list";
	}

	@RequiresPermissions("Staff:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		return "staff/add";
	}

	@RequiresPermissions("Staff:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		AjaxObject ajaxObject = null;
		int iReturn = staffDaoImpl.addStaff(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "staff_list", "closeCurrent");

			StrUtils.saveLog(request, "新增员工", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Staff:edi")
	@RequestMapping(value="/edi/{staffid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("staffid") int staffid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = staffDaoImpl.getStaffById(staffid);
		request.setAttribute("form", form);
		
		return "staff/edi";
	}

	@RequiresPermissions("Staff:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = staffDaoImpl.ediStaff(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "staff_list", "closeCurrent");

			StrUtils.saveLog(request, "修改员工", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Staff:delete")
	@RequestMapping(value="/delete/{staffid}")
	public @ResponseBody String delete(@PathVariable int staffid, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = staffDaoImpl.deleteStaff(staffid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "staff_list", "");

			LogDaoImpl.saveLog(request, "删除员工", staffid);
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
	/**
	 * 考勤情况
	 * @param staffid
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Staff:view")
	@RequestMapping(value="/edi_work/{staffid}")
	public String intoEdi_work(@PathVariable("staffid") int staffid, CodeTableForm form, HttpServletRequest request) {

		form.setValue("staffid", staffid);
		
		String workmonth = StrUtils.nullToStr(form.getValue("workmonth"));
		if(workmonth.equals("")) {
			workmonth = StrUtils.getSysdate("yyyy-MM");
			form.setValue("workmonth", workmonth); // 初始化考勤月份
		}
		staffDaoImpl.initWork(workmonth);
		
		form = staffDaoImpl.getWork(form, request);
		
		request.setAttribute("form", form);
		
		return "staff/work";
	}

	/**
	 * 修改考勤情况
	 * @param staffid
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Staff:view")
	@RequestMapping(value="/edi_work")
	public @ResponseBody String edi_work(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = staffDaoImpl.ediWork(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "", "");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}
	
    /**
     * 自动考勤
     * @param request
     * @return
     */
	@RequestMapping(value="/autoWork")
	public @ResponseBody String autoWork(HttpServletRequest request) {
		
		String result = "false";
		
		String overtimepay = StrUtils.nullToStr(request.getParameter("overtimepay"));
		String workdate = StrUtils.nullToStr(request.getParameter("workdate"));
		if(workdate.equals("")) {
			workdate = DateUtils.getNowDateTime("yyyy-MM-dd");
		}
		String ids = StrUtils.nullToStr(request.getParameter("ids"));
		
		String othersalarySQL = "";
		
		if(overtimepay.equals("1")) {
			othersalarySQL += ", t.othersalary = IFNULL(a.overtimepay, 0)";
		}
		
		String sql = "UPDATE bworkrow t, sstaff a, bwork b SET t.salary = a.salary" + othersalarySQL
			+ " WHERE a.staffid = b.staffid AND b.workid = t.workid"
			+ " AND t.workdate = '2016-04-22' AND a.staffid IN (" + ids + ")";

		DbUtils dbUtils = new DbUtils();
		int iReturn = dbUtils.executeSQL(sql);
		if (iReturn >= 0) {
			result = "true";
		}
		
		return result;
	}
}