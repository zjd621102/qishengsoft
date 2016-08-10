package com.yecoo.web;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.LogDaoImpl;
import com.yecoo.dao.FixingsDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;

/**
 * 配件管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/fixings")
public class FixingsAction {

	private FixingsDaoImpl fixingsDaoImpl = new FixingsDaoImpl();

	@RequiresPermissions("Fixings:view")
	@RequestMapping(value = "/list/{parentid}")
	public String list(@PathVariable("parentid") int parentid,
			CodeTableForm form, HttpServletRequest request) {

		form.setValue("parentid", parentid);
		fixingsDaoImpl.initAction(request);

		int totalCount = fixingsDaoImpl.getFixingsCount(form);
		List<CodeTableForm> fixingsList = fixingsDaoImpl.getFixingsList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("fixingsList", fixingsList); // 列表
		request.setAttribute("sn", "fixings"); // 授权名称
		request.setAttribute("form", form);

		return "fixings/list";
	}
	
	/**
	 * 
	 * @return
	 */
	@RequiresPermissions("Fixings:view")
	@RequestMapping(value = "/fixingsList")
	public String fixingsList(HttpServletRequest request) {

		List<HashMap<String, Object>> list = fixingsDaoImpl.getAllFixingsList();
		request.setAttribute("list", list);
		
		return "fixings/fixings_list";
	}

	@RequiresPermissions("Fixings:view")
	@RequestMapping(value = "/tree")
	public String tree(HttpServletRequest request) {

		CodeTableForm form = fixingsDaoImpl.getFixingsById(1);
		request.setAttribute("form", form);
		return "fixings/tree";
	}

	@RequiresPermissions("Fixings:add")
	@RequestMapping(value = "/add/{parentid}", method = RequestMethod.GET)
	public String toAdd(@PathVariable("parentid") int parentid,
			HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		form.setValue("parentid", parentid);
		request.setAttribute("form", form);
		return "fixings/add";
	}

	@ResponseBody
	@RequiresPermissions("Fixings:add")
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(CodeTableForm form, HttpServletRequest request) {

		AjaxObject ajaxObject = null;
		int iReturn = fixingsDaoImpl.addFixings(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "fixings_tree", "closeCurrent");

			StrUtils.saveLog(request, "新增配件", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Fixings:edi")
	@RequestMapping(value = "/edi/{fixingsid}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("fixingsid") int fixingsid,
			HttpServletRequest request) {

		CodeTableForm form = null;
		form = fixingsDaoImpl.getFixingsById(fixingsid);
		request.setAttribute("form", form);
		return "fixings/edi";
	}

	@RequiresPermissions("Fixings:edi")
	@ResponseBody
	@RequestMapping(value = "/edi", method = RequestMethod.POST)
	public String doEdi(CodeTableForm form, HttpServletRequest request) {

		AjaxObject ajaxObject = null;
		int iReturn = fixingsDaoImpl.ediFixings(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "fixings_tree", "closeCurrent");

			StrUtils.saveLog(request, "修改配件", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Fixings:delete")
	@ResponseBody
	@RequestMapping(value = "/delete/{fixingsid}")
	public String delete(@PathVariable("fixingsid") String fixingsid,
			HttpServletRequest request) {

		DbUtils dbUtils = new DbUtils();
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM sfixings t WHERE t.parentid = '"
				+ fixingsid + "'";
		int icount = dbUtils.getIntBySql(sql);
		if (icount >= 1) {
			ajaxObject = new AjaxObject("删除失败（此节点下还有子节点）");
		} else {
			iReturn = fixingsDaoImpl.deleteFixings(fixingsid);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("删除成功！", "fixings_tree", "");

				LogDaoImpl.saveLog(request, "删除配件", fixingsid);
			} else {
				ajaxObject = new AjaxObject("删除失败");
			}
		}
		return ajaxObject.toString();
	}
}