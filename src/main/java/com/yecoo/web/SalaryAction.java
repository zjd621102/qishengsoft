package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.SalaryDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 工资单管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/salary")
public class SalaryAction {

	DbUtils dbUtils = new DbUtils();
	private SalaryDaoImpl salaryDaoImpl = new SalaryDaoImpl();

	@RequiresPermissions("Salary:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String first = StrUtils.nullToStr(request.getParameter("first")); // 查询初始化
		if(first.equals("true")) {
			form.setValue("currflow", "申请");
			
			String salarydate = StrUtils.nullToStr(form.getValue("salarydate"));
			if(salarydate.equals("")) {
				salarydate = DateUtils.getAdjustTime(DateUtils.getNowDateTime(), "month", "", 1);// 默认为上个月
				salarydate = salarydate.substring(0, 7);
				form.setValue("salarydate", salarydate);
			}
		}
		
		salaryDaoImpl.initAction(request);

		int totalCount = salaryDaoImpl.getSalaryCount(form);
		List<CodeTableForm> salaryList = salaryDaoImpl.getSalaryList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("salaryList", salaryList); // 工资单列表
		request.setAttribute("sn", "salary"); // 授权名称
		request.setAttribute("form", form);
		
		return "salary/list";
	}

	@RequiresPermissions("Salary:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		
		String salarydate = StrUtils.nullToStr(request.getParameter("salarydate"));
		if(salarydate.equals("")) {
			salarydate = DateUtils.getAdjustTime(DateUtils.getNowDateTime(), "month", "", 1);// 默认为上个月
		}
		salarydate = salarydate.substring(0, 7);
		
		form.setValue("salarydate", salarydate);// 工资单日期
		form.setValue("salaryname", salarydate.replaceAll("-", "年") + "月份工资单");// 工资单名称
		request.setAttribute("form", form);
		
		String sql = "SELECT t.staffid, staffname, func_getSalaryByMonth(t.staffid, '"
				+ salarydate + "') planmoney FROM sstaff t WHERE t.staffstatus = '1' ORDER BY t.priority";
		List<CodeTableForm> salaryrowList = dbUtils.getListBySql(sql);
		request.setAttribute("salaryrowList", salaryrowList);
		
		return "salary/add";
	}

	@RequiresPermissions("Salary:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); // 当前日期
		form.setValue("createtime", createtime);
					
		String salaryno = StrUtils.getNewNO("GZD","salaryno","bsalary");
		form.setValue("salaryno", salaryno); // 初始化单据号
		
		CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		String maker = StrUtils.nullToStr(user.getValue("userid"));
		form.setValue("maker", maker);
		int iReturn = salaryDaoImpl.addSalary(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "salary_list", "closeCurrent");

			StrUtils.saveLog(request, "新增工资单", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Salary:edi")
	@RequestMapping(value="/edi/{salaryid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("salaryid") int salaryid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = salaryDaoImpl.getSalaryById(salaryid, request);
		
		request.setAttribute("form", form);
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("print")) {
			return "salary/print"; // 打印
		}
		
		return "salary/edi";
	}

	@RequiresPermissions("Salary:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = salaryDaoImpl.ediSalary(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "salary_list", "closeCurrent");

			StrUtils.saveLog(request, "修改工资单", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Salary:delete")
	@RequestMapping(value="/delete/{salaryid}")
	public @ResponseBody String delete(@PathVariable int salaryid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM bsalary t WHERE t.currflow <> '申请' AND t.salaryid = '" + salaryid + "'";
		int icount = dbUtils.getIntBySql(sql);
		if(icount >= 3) {
			ajaxObject = new AjaxObject("删除失败（单据不在申请流程）");
		} else {
			iReturn = salaryDaoImpl.deleteSalary(salaryid);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("删除成功！", "salary_list", "");
			} else {
				ajaxObject = new AjaxObject("删除失败");
			}
		}
		return ajaxObject.toString();
	}
}