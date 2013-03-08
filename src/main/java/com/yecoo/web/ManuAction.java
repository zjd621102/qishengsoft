package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.ManuDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 供应商管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/manu")
public class ManuAction {

	private ManuDaoImpl manuDaoImpl = new ManuDaoImpl();

	@RequiresPermissions("Manu:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String first = StrUtils.nullToStr(request.getParameter("first")); //查询初始化
		if(first.equals("true")) {
			form.setValue("statusid", "1");
		}
		manuDaoImpl.initAction(request);

		int totalCount = manuDaoImpl.getManuCount(form);
		List<CodeTableForm> manuList = manuDaoImpl.getManuList(form);
		request.setAttribute("totalCount", totalCount); //列表总数量
		request.setAttribute("manuList", manuList); //供应商列表
		request.setAttribute("sn", "manu"); //授权名称
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "manu/list";
	}

	@RequiresPermissions("Manu:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "manu/add";
	}

	@RequiresPermissions("Manu:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createdate = StrUtils.getSysdate(); //当前日期
		form.setValue("createdate", createdate);
		int iReturn = manuDaoImpl.addManu(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "manu_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Manu:edi")
	@RequestMapping(value="/edi/{manuid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("manuid") int manuid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = manuDaoImpl.getManuById(manuid, request);
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "manu/edi";
	}

	@RequiresPermissions("Manu:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = manuDaoImpl.ediManu(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "manu_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Manu:delete")
	@RequestMapping(value="/delete/{manuid}")
	public @ResponseBody String delete(@PathVariable int manuid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = manuDaoImpl.deleteManu(manuid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "manu_list", "");
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
		String sql = "select * from cmanutype order by manutypeid";
		List<CodeTableForm> manuTypeList = dbUtils.getListBySql(sql); //供应商类型
		sql = "select * from cstatus order by statusid";
		List<CodeTableForm> statusList = dbUtils.getListBySql(sql); //供应商状态
		request.setAttribute("manuTypeList", manuTypeList);
		request.setAttribute("statusList", statusList);
	}
}