package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.UnitDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 单位管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/unit")
public class UnitAction {

	private UnitDaoImpl unitDaoImpl = new UnitDaoImpl();

	@RequiresPermissions("Unit:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		unitDaoImpl.initAction(request);

		int totalCount = unitDaoImpl.getUnitCount(form);
		List<CodeTableForm> unitList = unitDaoImpl.getUnitList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("unitList", unitList); // 单位列表
		request.setAttribute("sn", "unit"); //授权名称
		request.setAttribute("form", form);

		return "unit/list";
	}

	@RequiresPermissions("Unit:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		return "unit/add";
	}

	@RequiresPermissions("Unit:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form) {
		AjaxObject ajaxObject = null;
		int iReturn = unitDaoImpl.addUnit(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "unit_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Unit:edi")
	@RequestMapping(value="/edi/{unitid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("unitid") int unitid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = unitDaoImpl.getUnitById(unitid);
		request.setAttribute("form", form);
		return "unit/edi";
	}

	@RequiresPermissions("Unit:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = unitDaoImpl.ediUnit(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "unit_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Unit:delete")
	@RequestMapping(value="/delete/{unitid}")
	public @ResponseBody String delete(@PathVariable int unitid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = unitDaoImpl.deleteUnit(unitid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "unit_list", "");
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
}