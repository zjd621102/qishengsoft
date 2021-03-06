package com.yecoo.web;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.FileDaoImpl;
import com.yecoo.dao.LogDaoImpl;
import com.yecoo.dao.ParameterDaoImpl;
import com.yecoo.dao.ProductDaoImpl;
import com.yecoo.dao.ProducttypeDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
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
		
		String manuname = null;
		CodeTableForm userForm = (CodeTableForm) request.getSession().getAttribute(Constants.USER_INFO_SESSION); //用户信息
		if(userForm != null && "1".equals(userForm.getValue("ismanu"))) {// 是客户
			manuname = StrUtils.nullToStr(userForm.getValue("username"));
		}
		
		CodeTableForm form = producttypeDaoImpl.getProducttypeById(1, manuname);
		request.setAttribute("form", form);
		return "product/tree";
	}
	
	@RequiresPermissions("Product:view")
	@RequestMapping(value="/list/{producttype}")
	public String list(@PathVariable("producttype") int producttype, CodeTableForm form, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// 来自tree.jsp
		
		form.setValue("producttype", producttype);
		productDaoImpl.initAction(request);
		/*
		String first = StrUtils.nullToStr(request.getParameter("first"));// 来自tree.jsp
		if(first.equals("true")) {// 第一次加载
			form.setValue("statusid", "1"); //使用状态
		}
		*/
		// 设置买家到session
		Object obuyers = form.getValue("buyers");
		if(obuyers != null) {
			String buyers = StrUtils.nullToStr(obuyers);
			request.getSession().setAttribute("buyers", buyers);
		} else {// 客户
			CodeTableForm userForm = (CodeTableForm) request.getSession().getAttribute(Constants.USER_INFO_SESSION); //用户信息
			if(userForm != null && "1".equals(userForm.getValue("ismanu"))) {// 是客户
				request.getSession().setAttribute("buyers", userForm.getValue("username"));
			}
		}
		
		// 从session获取买家
		String buyers = StrUtils.nullToStr(request.getSession().getAttribute("buyers"));
		if(!buyers.equals("")) {
			form.setValue("buyers", buyers);
		}

		int totalCount = productDaoImpl.getProductCount(form);
		List<CodeTableForm> productList = productDaoImpl.getProductList(form);
		request.setAttribute("curTime", curTime);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("productList", productList); // 列表
		request.setAttribute("sn", "product"); //授权名称
		request.setAttribute("form", form);

		return "product/list";
	}

	@RequiresPermissions("Product:add")
	@RequestMapping(value="/add/{producttype}", method=RequestMethod.GET)
	public String toAdd(@PathVariable("producttype") int producttype, HttpServletRequest request) {
		
		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间

		CodeTableForm form = new CodeTableForm();
		
		CodeTableForm parentForm = dbUtils.getFormByColumn("sproducttype", "producttype",
				String.valueOf(producttype));
		
		String productno = StrUtils.getNO(StrUtils.nullToStr(parentForm.getValue("producttypeno")),
				"productno", "sproduct", 2);
		
		form.setValue("producttype", producttype);
		form.setValue("productno", productno); //产品类型编码
		form.setValue("producttypename", StrUtils.nullToStr(parentForm.getValue("producttypename")));
		form.setValue("unit", "1");// 默认单位：只
		
		request.setAttribute("form", form);
		request.setAttribute("curTime", curTime);
		
		/**************初始化行项Begin**************
		List<CodeTableForm> productrowList = new ArrayList<CodeTableForm>();
		CodeTableForm productrow = new CodeTableForm();
		productrow.setValue("materialname", "人力成本");
		productrow.setValue("materialprice", "0");
		productrow.setValue("materialnum", "1");
		productrow.setValue("sort", "1");
		productrowList.add(productrow);
		
		productrow = new CodeTableForm();
		productrow.setValue("materialname", "其他成本");
		productrow.setValue("materialprice", "0");
		productrow.setValue("materialnum", "1");
		productrow.setValue("sort", "2");
		productrowList.add(productrow);
		request.setAttribute("productrowList", productrowList);
		/**************初始化行项End**************/
		
		return "product/add";
	}

	@RequiresPermissions("Product:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		AjaxObject ajaxObject = null;
		String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createdate", createdate);
		int iReturn = productDaoImpl.addProduct(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "新增成功！", "", "", "jbsxBox2product" + curTime, "closeCurrent");

			StrUtils.saveLog(request, "新增产品", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Product:edi")
	@RequestMapping(value="/edi/{productid}")
	public String toEdi(@PathVariable("productid") int productid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = productDaoImpl.getProductById(productid, request);
		
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		List<CodeTableForm> fileList = fileDaoImpl.getFileList(productid, "'product', 'product_cover'");// 附件列表
		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		request.setAttribute("form", form);
		request.setAttribute("fileList", fileList);
		request.setAttribute("curTime", curTime);
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("print")) {
			String productno = StrUtils.nullToStr(form.getValue("productno"));
			Pattern p = Pattern.compile("^[A-Z]+1");// 铜
			Matcher m = p.matcher(productno);
			if(m.find()) {
				form.setValue("materialtype", "铜");
			}
			
			String sql = "SELECT CONCAT(t.fileid, '.', t.suffix) FROM sfile t WHERE t.pid = '" + productid
					+ "' AND t.btype = 'product_cover'";
			String picPath = dbUtils.execQuerySQL(sql);
			form.setValue("picPath", picPath);
			
			return "product/print_pic"; // 打印
		}
		
		String profitPoint = new ParameterDaoImpl().getParameterName("利润百分点");
		request.setAttribute("profitPoint", profitPoint);// 利润百分点
		
		return "product/edi";
	}

	@RequiresPermissions("Product:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		AjaxObject ajaxObject = null;
		int iReturn = productDaoImpl.ediProduct(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "修改成功！", "", "", "jbsxBox2product" + curTime, "");// closeCurrent

			StrUtils.saveLog(request, "修改产品", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Product:delete")
	@RequestMapping(value="/delete/{productid}")
	public @ResponseBody String delete(@PathVariable int productid, HttpServletRequest request) {
		
		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		AjaxObject ajaxObject = null;
		int iReturn = productDaoImpl.deleteProduct(productid, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "删除成功！", "", "", "jbsxBox2product" + curTime, "");

			LogDaoImpl.saveLog(request, "删除产品", productid);
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
	
	/**
	 * 查询产品
	 * @param keyword
	 * @param manuid
	 * @return
	 */
    @RequestMapping(value = "/getSelectByKeyword")
    @ResponseBody
    public List<CodeTableForm> getSelectByKeyword(String keyword, String manuid) {
    	
		
		String field = "";

		if(manuid != null && !manuid.equals("")) {
			String priceMemory = new ParameterDaoImpl().getParameterName("是否价格记忆");
			if(priceMemory.equals("Y")) {// 价格记忆
				field += " (SELECT b.realprice FROM bsell a, bsellrow b WHERE a.sellid = b.sellid"
					+ " AND b.productid = t.productid AND a.manuid = '" + manuid
					+ "' ORDER BY b.sellid DESC LIMIT 0, 1) historyprice,";
			}
		}
    	
		String sql = "SELECT " + field + "t.* FROM sproduct t WHERE (t.productno LIKE '%"
				+ keyword + "%' OR t.productname LIKE '%" + keyword + "%')"
				+ " AND t.statusid = '1'"
				+ " ORDER BY t.productsort ASC, t.productno ASC";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
        return list;
    }
    
    /**
     * 复制产品清单
     * @param request
     * @return
     */
	@RequestMapping(value="/copyDetail")
	public @ResponseBody String copyDetail(HttpServletRequest request) {
		
		String result = "false";
		
		String copyproductno = StrUtils.nullToStr(request.getParameter("copyproductno"));
		int productid = Integer.parseInt(StrUtils.nullToStr(request.getParameter("productid"), "0"));
		
		int iReturn = productDaoImpl.copyDetail(copyproductno, productid);
		if (iReturn >= 0) {
			result = "true";
		}
		
		return result;
	}
}