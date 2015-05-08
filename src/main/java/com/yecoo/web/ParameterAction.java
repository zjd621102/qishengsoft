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
import com.yecoo.dao.ParameterDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 系统参数管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/parameter")
public class ParameterAction {

	private ParameterDaoImpl parameterDaoImpl = new ParameterDaoImpl();

	@RequiresPermissions("Parameter:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		parameterDaoImpl.initAction(request);

		int totalCount = parameterDaoImpl.getParameterCount(form);
		List<CodeTableForm> parameterList = parameterDaoImpl.getParameterList(form);
		request.setAttribute("totalCount", totalCount); //列表总数量
		request.setAttribute("parameterList", parameterList); //系统参数列表
		request.setAttribute("sn", "parameter"); //授权名称
		request.setAttribute("form", form);
		
		return "parameter/list";
	}

	@RequiresPermissions("Parameter:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		return "parameter/add";
	}

	@RequiresPermissions("Parameter:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createtime", createtime);
		int iReturn = parameterDaoImpl.addParameter(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "parameter_list", "closeCurrent");

			StrUtils.saveLog(request, "新增系统参数", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Parameter:edi")
	@RequestMapping(value="/edi/{parameterid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("parameterid") int parameterid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = parameterDaoImpl.getParameterById(parameterid);
		request.setAttribute("form", form);
		
		return "parameter/edi";
	}

	@RequiresPermissions("Parameter:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = parameterDaoImpl.ediParameter(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "parameter_list", "closeCurrent");

			StrUtils.saveLog(request, "修改系统参数", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Parameter:delete")
	@RequestMapping(value="/delete/{parameterid}")
	public @ResponseBody String delete(@PathVariable int parameterid, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = parameterDaoImpl.deleteParameter(parameterid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "parameter_list", "");

			LogDaoImpl.saveLog(request, "删除系统参数", parameterid);
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
}