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
import com.yecoo.dao.ProducttypeDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 产品类别管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/producttype")
public class ProducttypeAction {

	private ProducttypeDaoImpl producttypeDaoImpl = new ProducttypeDaoImpl();

	@RequiresPermissions("Producttype:view")
	@RequestMapping(value="/list/{parent}")
	public String list(@PathVariable("parent") int parent, CodeTableForm form, HttpServletRequest request) {

		form.setValue("parent", parent);
		producttypeDaoImpl.initAction(request);

		int totalCount = producttypeDaoImpl.getProducttypeCount(form);
		List<CodeTableForm> producttypeList = producttypeDaoImpl.getProducttypeList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("producttypeList", producttypeList); // 列表
		request.setAttribute("sn", "producttype"); //授权名称
		request.setAttribute("form", form);

		return "producttype/list";
	}
	
	@RequiresPermissions("Producttype:view")
	@RequestMapping(value="/tree")
	public String tree(HttpServletRequest request) {
		
		CodeTableForm form = producttypeDaoImpl.getProducttypeById(1);
		request.setAttribute("form", form);
		return "producttype/tree";
	}
	
	@RequiresPermissions("Producttype:add")
	@RequestMapping(value="/add/{parent}", method=RequestMethod.GET)
	public String toAdd(@PathVariable("parent") int parent, HttpServletRequest request) {
		
		CodeTableForm form = new CodeTableForm();
		
		DbUtils dbUtils = new DbUtils();
		
		CodeTableForm parentForm = dbUtils.getFormByColumn("sproducttype", "producttype", String.valueOf(parent));
		String producttypeno = StrUtils.getNO(StrUtils.nullToStr(parentForm.getValue("producttypeno")),
				"producttypeno", "sproducttype", 2);
		
		form.setValue("parent", parent);
		form.setValue("producttypeno", producttypeno); //产品类型编码
		
		request.setAttribute("form", form);
		return "producttype/add";
	}
	
	@ResponseBody
	@RequiresPermissions("Producttype:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		
		// 校验编码是否可用
		String producttype = StrUtils.nullToStr(form.getValue("producttype"));
		String producttypeno = StrUtils.nullToStr(form.getValue("producttypeno"));
		boolean checkNO = producttypeDaoImpl.checkNo(producttype, producttypeno);
		
		if(checkNO) {
			int iReturn = producttypeDaoImpl.addProducttype(form);
			
			if(iReturn > 0) {
				DbUtils dbUtils = new DbUtils();
				String sql = "UPDATE sproducttype a, sproducttype b SET a.producttypeall = CONCAT(b.producttypeall, '-', a.producttype)"
						+ " WHERE a.parent = b.producttype AND a.producttypeno = '" + form.getValue("producttypeno") + "'";
				iReturn = dbUtils.executeSQL(sql);
			}
			
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("新增成功！", "producttype_tree", "closeCurrent");
	
				StrUtils.saveLog(request, "新增产品类型", form);
			} else {
				ajaxObject = new AjaxObject("新增失败");
			}
		} else {
			ajaxObject = new AjaxObject("产品类型编码已存在");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Producttype:edi")
	@RequestMapping(value = "/edi/{producttype}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("producttype") int producttype,
			HttpServletRequest request) {

		CodeTableForm form = null;
		form = producttypeDaoImpl.getProducttypeById(producttype);
		request.setAttribute("form", form);
		return "producttype/edi";
	}

	@RequiresPermissions("Producttype:edi")
	@ResponseBody
	@RequestMapping(value = "/edi", method = RequestMethod.POST)
	public String doEdi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		
		// 校验编码是否可用
		String producttype = StrUtils.nullToStr(form.getValue("producttype"));
		String producttypeno = StrUtils.nullToStr(form.getValue("producttypeno"));
		boolean checkNO = producttypeDaoImpl.checkNo(producttype, producttypeno);
		
		if(checkNO) {
			int iReturn = producttypeDaoImpl.ediProducttype(form);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("修改成功！", "producttype_tree", "closeCurrent");
	
				StrUtils.saveLog(request, "修改产品类型", form);
			} else {
				ajaxObject = new AjaxObject("修改失败");
			}
		} else {
			ajaxObject = new AjaxObject("产品类型编码已存在");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Producttype:delete")
	@ResponseBody
	@RequestMapping(value = "/delete/{producttype}")
	public String delete(@PathVariable("producttype") String producttype,
			HttpServletRequest request) {
		
		DbUtils dbUtils = new DbUtils();
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM sproducttype t WHERE t.parent = '" + producttype + "'";
		int icount = dbUtils.getIntBySql(sql);
		if(icount >= 1) {
			ajaxObject = new AjaxObject("删除失败（此节点下还有子节点）");
		} else {
			
			//判断节点下是否还有物资
			sql = "SELECT COUNT(1) FROM sproduct t WHERE t.producttype = '" + producttype + "'";
			icount = dbUtils.getIntBySql(sql);
			if(icount >= 1) {
				ajaxObject = new AjaxObject("删除失败（此产品类别下还有产品）");
			} else {
				iReturn = producttypeDaoImpl.deleteProducttype(producttype);
				if (iReturn >= 0) {
					ajaxObject = new AjaxObject("删除成功！", "producttype_tree", "");

					LogDaoImpl.saveLog(request, "删除产品类型", producttype);
				} else {
					ajaxObject = new AjaxObject("删除失败");
				}
			}
		}
		return ajaxObject.toString();
	}
}