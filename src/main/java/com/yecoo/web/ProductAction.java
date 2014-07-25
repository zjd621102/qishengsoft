package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.ProductDaoImpl;
import com.yecoo.dao.ProducttypeDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 产品管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/product")
public class ProductAction {

	DbUtils dbUtils = new DbUtils();
	private ProductDaoImpl productDaoImpl = new ProductDaoImpl();
	private ProducttypeDaoImpl producttypeDaoImpl = new ProducttypeDaoImpl();

	@RequiresPermissions("Product:view")
	@RequestMapping(value="/tree")
	public String tree(HttpServletRequest request) {
		
		CodeTableForm form = producttypeDaoImpl.getProducttypeById(1);
		request.setAttribute("form", form);
		return "product/tree";
	}
	
	@RequiresPermissions("Product:view")
	@RequestMapping(value="/list/{producttype}")
	public String list(@PathVariable("producttype") int producttype, CodeTableForm form, HttpServletRequest request) {

		form.setValue("producttype", producttype);
		productDaoImpl.initAction(request);

		int totalCount = productDaoImpl.getProductCount(form);
		List<CodeTableForm> productList = productDaoImpl.getProductList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("productList", productList); // 列表
		request.setAttribute("sn", "product"); //授权名称
		request.setAttribute("form", form);

		return "product/list";
	}

	@RequiresPermissions("Product:add")
	@RequestMapping(value="/add/{producttype}", method=RequestMethod.GET)
	public String toAdd(@PathVariable("producttype") int producttype, HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		
		CodeTableForm parentForm = dbUtils.getFormByColumn("sproducttype", "producttype",
				String.valueOf(producttype));
		
		String productno = StrUtils.getNO(StrUtils.nullToStr(parentForm.getValue("producttypeno")),
				"productno", "sproduct");
		
		form.setValue("producttype", producttype);
		form.setValue("productno", productno); //产品类型编码
		form.setValue("producttypename", StrUtils.nullToStr(parentForm.getValue("producttypename")));
		
		request.setAttribute("form", form);
		this.getSelects(request);
		return "product/add";
	}

	@RequiresPermissions("Product:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createdate = StrUtils.getSysdate(); //当前日期
		form.setValue("createdate", createdate);
		int iReturn = productDaoImpl.addProduct(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "新增成功！", "", "", "jbsxBox2product", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Product:edi")
	@RequestMapping(value="/edi/{productid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("productid") int productid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = productDaoImpl.getProductById(productid, request);
		
		request.setAttribute("form", form);
		this.getSelects(request);
		return "product/edi";
	}

	@RequiresPermissions("Product:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = productDaoImpl.ediProduct(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "修改成功！", "", "", "jbsxBox2product", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Product:delete")
	@RequestMapping(value="/delete/{productid}")
	public @ResponseBody String delete(@PathVariable int productid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = productDaoImpl.deleteProduct(productid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "删除成功！", "", "", "jbsxBox2product", "");
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

		String sql = "select * from cunit order by priority";
		List<CodeTableForm> unitList = dbUtils.getListBySql(sql); //计量单位
		request.setAttribute("unitList", unitList);
	}
	
	/**
	 * 查询产品
	 * @param keyword
	 * @return
	 */
    @RequestMapping(value = "/getSelectByKeyword")
    @ResponseBody
    public List<CodeTableForm> getSelectByKeyword(String keyword) {
		String sql = "SELECT * FROM sproduct t WHERE (t.productno LIKE '%"
				+ keyword + "%' OR t.productname LIKE '%" + keyword + "%')";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
        return list;
    }
}