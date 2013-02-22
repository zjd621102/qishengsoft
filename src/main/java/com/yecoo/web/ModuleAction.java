package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.ModuleDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 模块管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/module")
public class ModuleAction {

	private ModuleDaoImpl moduleDaoImpl = new ModuleDaoImpl();

	@RequiresPermissions("Module:view")
	@RequestMapping(value="/list/{parentid}")
	public String list(@PathVariable("parentid") int parentid, CodeTableForm form, HttpServletRequest request) {

		form.setValue("parentid", parentid);
		
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request.getParameter("numPerPage"));
		int pageNum = 1;
		int numPerPage = 100;
		if (!sPageNum.equals("")) {
			pageNum = Integer.parseInt(sPageNum);
		}
		if (!sNumPerPage.equals("")) {
			numPerPage = Integer.parseInt(sNumPerPage);
		}
		request.setAttribute("pageNum", pageNum); // 当前页
		request.setAttribute("numPerPage", numPerPage); // 每页数量

		int totalCount = moduleDaoImpl.getModuleCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> moduleList = moduleDaoImpl.getModuleList(form, pageNum, numPerPage);
		request.setAttribute("moduleList", moduleList); // 列表

		request.setAttribute("form", form);
		request.setAttribute("sn", "module"); //授权名称
		return "module/list";
	}
	
	@RequiresPermissions("Module:view")
	@RequestMapping(value="/tree")
	public String tree(HttpServletRequest request) {
		
		CodeTableForm form = moduleDaoImpl.getModuleById(1);
		request.setAttribute("form", form);
		return "module/tree";
	}
	
	@RequiresPermissions("Module:add")
	@RequestMapping(value="/add/{parentid}", method=RequestMethod.GET)
	public String toAdd(@PathVariable("parentid") int parentid, HttpServletRequest request) {
		
		CodeTableForm form = new CodeTableForm();
		form.setValue("parentid", parentid);
		request.setAttribute("form", form);
		return "module/add";
	}
	
	@ResponseBody
	@RequiresPermissions("Module:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = moduleDaoImpl.addModule(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "module_tree", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Module:edi")
	@RequestMapping(value = "/edi/{moduleid}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("moduleid") int moduleid,
			HttpServletRequest request) {

		CodeTableForm form = null;
		form = moduleDaoImpl.getModuleById(moduleid);
		request.setAttribute("form", form);
		return "module/edi";
	}

	@RequiresPermissions("Module:edi")
	@ResponseBody
	@RequestMapping(value = "/edi", method = RequestMethod.POST)
	public String doEdi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = moduleDaoImpl.ediModule(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "module_tree", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Module:delete")
	@ResponseBody
	@RequestMapping(value = "/delete/{moduleid}")
	public String delete(@PathVariable("moduleid") String moduleid,
			HttpServletRequest request) {
		
		DbUtils dbUtils = new DbUtils();
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM smodule t WHERE t.parentid = '" + moduleid + "'";
		int icount = dbUtils.getIntBySql(sql);
		if(icount >= 1) {
			ajaxObject = new AjaxObject("删除失败（此节点下还有子节点）");
		} else {
			iReturn = moduleDaoImpl.deleteModule(moduleid);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("删除成功！", "module_tree", "");
			} else {
				ajaxObject = new AjaxObject("删除失败");
			}
		}
		return ajaxObject.toString();
	}
}