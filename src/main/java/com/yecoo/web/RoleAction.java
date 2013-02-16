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
import com.yecoo.dao.RoleDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 角色管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/role")
public class RoleAction {

	private RoleDaoImpl roleDaoImpl = new RoleDaoImpl();
	private ModuleDaoImpl moduleDaoImpl = new ModuleDaoImpl();

	@RequiresPermissions("Role:view")
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

		int totalCount = roleDaoImpl.getRoleCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> roleList = roleDaoImpl.getRoleList(form, pageNum,
				numPerPage);
		request.setAttribute("roleList", roleList); // 角色列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		request.setAttribute("sn", "role"); //授权名称
		return "role/list";
	}

	@RequiresPermissions("Role:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		List<CodeTableForm> moduleList = moduleDaoImpl.getModuleList();
		request.setAttribute("moduleList", moduleList);
		return "role/add";
	}

	@RequiresPermissions("Role:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form) {
		AjaxObject ajaxObject = null;
		int iReturn = roleDaoImpl.addRole(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "role_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Role:edi")
	@RequestMapping(value="/edi/{roleid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("roleid") int roleid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = roleDaoImpl.getRoleById(roleid);
		request.setAttribute("form", form);
		
		List<CodeTableForm> moduleList = moduleDaoImpl.getModuleList();
		request.setAttribute("moduleList", moduleList);
		return "role/edi";
	}

	@RequiresPermissions("Role:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = roleDaoImpl.ediRole(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "role_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Role:delete")
	@RequestMapping(value="/delete/{roleid}")
	public @ResponseBody String delete(@PathVariable int roleid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = roleDaoImpl.deleteRole(roleid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "role_list", "");
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
}