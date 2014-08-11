package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.MaterialtypeDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 物资类型管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/materialtype")
public class MaterialtypeAction {

	private MaterialtypeDaoImpl materialtypeDaoImpl = new MaterialtypeDaoImpl();

	@RequiresPermissions("Materialtype:view")
	@RequestMapping(value="/list/{parent}")
	public String list(@PathVariable("parent") int parent, CodeTableForm form, HttpServletRequest request) {

		form.setValue("parent", parent);
		materialtypeDaoImpl.initAction(request);

		int totalCount = materialtypeDaoImpl.getMaterialtypeCount(form);
		List<CodeTableForm> materialtypeList = materialtypeDaoImpl.getMaterialtypeList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("materialtypeList", materialtypeList); // 列表
		request.setAttribute("sn", "materialtype"); //授权名称
		request.setAttribute("form", form);

		return "materialtype/list";
	}
	
	@RequiresPermissions("Materialtype:view")
	@RequestMapping(value="/tree")
	public String tree(HttpServletRequest request) {
		
		CodeTableForm form = materialtypeDaoImpl.getMaterialtypeById(1);
		request.setAttribute("form", form);
		return "materialtype/tree";
	}
	
	@RequiresPermissions("Materialtype:add")
	@RequestMapping(value="/add/{parent}", method=RequestMethod.GET)
	public String toAdd(@PathVariable("parent") int parent, HttpServletRequest request) {
		
		CodeTableForm form = new CodeTableForm();
		
		DbUtils dbUtils = new DbUtils();
		
		CodeTableForm parentForm = dbUtils.getFormByColumn("smaterialtype", "materialtype", String.valueOf(parent));
		String materialtypeno = StrUtils.getNO(StrUtils.nullToStr(parentForm.getValue("materialtypeno")),
				"materialtypeno", "smaterialtype");
		
		form.setValue("parent", parent);
		form.setValue("materialtypeno", materialtypeno); //物资类型编码
		
		request.setAttribute("form", form);
		return "materialtype/add";
	}
	
	@ResponseBody
	@RequiresPermissions("Materialtype:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = materialtypeDaoImpl.addMaterialtype(form);
		
		if(iReturn > 0) {
			DbUtils dbUtils = new DbUtils();
			String sql = "UPDATE smaterialtype a, smaterialtype b SET a.materialtypeall = CONCAT(b.materialtypeall, '-', a.materialtype)"
					+ " WHERE a.parent = b.materialtype AND a.materialtypeno = '" + form.getValue("materialtypeno") + "'";
			iReturn = dbUtils.executeSQL(sql);
		}
		
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "materialtype_tree", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Materialtype:edi")
	@RequestMapping(value = "/edi/{materialtype}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("materialtype") int materialtype,
			HttpServletRequest request) {

		CodeTableForm form = null;
		form = materialtypeDaoImpl.getMaterialtypeById(materialtype);
		request.setAttribute("form", form);
		return "materialtype/edi";
	}

	@RequiresPermissions("Materialtype:edi")
	@ResponseBody
	@RequestMapping(value = "/edi", method = RequestMethod.POST)
	public String doEdi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = materialtypeDaoImpl.ediMaterialtype(form);
		
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "materialtype_tree", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Materialtype:delete")
	@ResponseBody
	@RequestMapping(value = "/delete/{materialtype}")
	public String delete(@PathVariable("materialtype") String materialtype,
			HttpServletRequest request) {
		
		DbUtils dbUtils = new DbUtils();
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM smaterialtype t WHERE t.parent = '" + materialtype + "'";
		int icount = dbUtils.getIntBySql(sql);
		if(icount >= 1) {
			ajaxObject = new AjaxObject("删除失败（此节点下还有子节点）");
		} else {
			
			//判断节点下是否还有物资
			sql = "SELECT COUNT(1) FROM smaterial t WHERE t.materialtype = '" + materialtype + "'";
			icount = dbUtils.getIntBySql(sql);
			if(icount >= 1) {
				ajaxObject = new AjaxObject("删除失败（此物资类型下还有物资）");
			} else {
				iReturn = materialtypeDaoImpl.deleteMaterialtype(materialtype);
				if (iReturn >= 0) {
					ajaxObject = new AjaxObject("删除成功！", "materialtype_tree", "");
				} else {
					ajaxObject = new AjaxObject("删除失败");
				}
			}
		}
		return ajaxObject.toString();
	}
}