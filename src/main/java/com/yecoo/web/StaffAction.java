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
import com.yecoo.util.Constants;
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

		String act = StrUtils.nullToStr(request.getAttribute("act"));
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request
			.getParameter("numPerPage"));
		int pageNum = 1;
		int numPerPage = Constants.NUMPERPAGE;
		if (!sPageNum.equals("")) {
			pageNum = Integer.parseInt(sPageNum);
		}
		if (!sNumPerPage.equals("")) {
			numPerPage = Integer.parseInt(sNumPerPage);
		}
		request.setAttribute("pageNum", pageNum); // 当前页
		request.setAttribute("numPerPage", numPerPage); // 每页数量

		int totalCount = staffDaoImpl.getStaffCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> staffList = staffDaoImpl.getStaffList(form, pageNum,
			numPerPage);
		request.setAttribute("staffList", staffList); // 员工列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
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
	 * 获取下拉列表
	 * @param request
	 */
	private void getSelects(HttpServletRequest request) {

		DbUtils dbUtils = new DbUtils();
		String sql = "select * from cstaffstatus order by staffstatusid";
		List<CodeTableForm> staffstatusList = dbUtils.getListBySql(sql); //员工状态
		sql = "select * from cstafftype order by stafftypeid";
		List<CodeTableForm> stafftypeList = dbUtils.getListBySql(sql); //员工类型
		request.setAttribute("staffstatusList", staffstatusList);
		request.setAttribute("stafftypeList", stafftypeList);
	}
}