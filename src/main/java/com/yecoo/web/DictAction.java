package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.DictDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 字典管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/dict")
public class DictAction {

	private DictDaoImpl dictDaoImpl = new DictDaoImpl();

	@RequiresPermissions("Dict:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		dictDaoImpl.initAction(request);

		int totalCount = dictDaoImpl.getDictCount(form);
		List<CodeTableForm> dictList = dictDaoImpl.getDictList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("dictList", dictList); // 字典列表
		request.setAttribute("sn", "dict"); //授权名称
		request.setAttribute("form", form);

		return "dict/list";
	}

	@RequiresPermissions("Dict:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		return "dict/add";
	}

	@RequiresPermissions("Dict:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createtime", createtime);
		int iReturn = dictDaoImpl.addDict(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "dict_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Dict:edi")
	@RequestMapping(value="/edi/{dictid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("dictid") int dictid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = dictDaoImpl.getDictById(dictid, request);
		request.setAttribute("form", form);
		return "dict/edi";
	}

	@RequiresPermissions("Dict:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = dictDaoImpl.ediDict(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "dict_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Dict:delete")
	@RequestMapping(value="/delete/{dictid}")
	public @ResponseBody String delete(@PathVariable int dictid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = dictDaoImpl.deleteDict(dictid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "dict_list", "");
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
}