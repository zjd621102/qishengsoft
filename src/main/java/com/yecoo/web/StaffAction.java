package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.StaffDaoImpl;
import com.yecoo.model.CodeTableForm;
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

		
		this.getSelects(request);
		
		return "staff/list";
	}

	@RequiresPermissions("Staff:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);

		this.getSelects(request);
		
		return "staff/add";
	}

	@RequiresPermissions("Staff:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form) {
		AjaxObject ajaxObject = null;
		int iReturn = staffDaoImpl.addStaff(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "staff_list", "closeCurrent");
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

		this.getSelects(request);
		
		return "staff/edi";
	}

	@RequiresPermissions("Staff:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = staffDaoImpl.ediStaff(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "staff_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Staff:delete")
	@RequestMapping(value="/delete/{staffid}")
	public @ResponseBody String delete(@PathVariable int staffid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = staffDaoImpl.deleteStaff(staffid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "staff_list", "");
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
		
		this.getSelects(request);
		
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
	 * 获取下拉列表
	 * @param request
	 */
	private void getSelects(HttpServletRequest request) {

		DbUtils dbUtils = new DbUtils();
		String sql = "select * from cstaffstatus order by staffstatusid";
		List<CodeTableForm> staffstatusList = dbUtils.getListBySql(sql); //员工状态
		sql = "select * from cstafftype order by stafftypeid";
		List<CodeTableForm> stafftypeList = dbUtils.getListBySql(sql); //员工类型
		sql = "select * from cworkstatus order by workstatus";
		List<CodeTableForm> workstatusList = dbUtils.getListBySql(sql); //考勤状态
		request.setAttribute("staffstatusList", staffstatusList);
		request.setAttribute("stafftypeList", stafftypeList);
		request.setAttribute("workstatusList", workstatusList);
	}
}