package com.yecoo.web;

import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.ManageDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 配置管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/manage")
public class ManageAction {

	DbUtils dbUtils = new DbUtils();
	ManageDaoImpl manageDaoImpl = new ManageDaoImpl();
	
	/**
	 * 配置列表
	 * 
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("Manage:view")
	@RequestMapping(value = "/list")
	public String list(CodeTableForm form, HttpServletRequest request) {

		ManageDaoImpl manageDaoImpl = new ManageDaoImpl();
		
		// 账户金额
		double zhje = manageDaoImpl.getZhje();
		// 单据已收款
		double djysk = manageDaoImpl.getDjysk();
		// 销售已收款
		double xsysk = manageDaoImpl.getXsysk();
		// 采购已付款
		double cgyfk = manageDaoImpl.getCgyfk();
		// 合计
		DecimalFormat df = new DecimalFormat("0.##");
		double hj = zhje + djysk + xsysk - cgyfk;
		
		request.setAttribute("zhje", zhje);
		request.setAttribute("djysk", djysk);
		request.setAttribute("xsysk", xsysk);
		request.setAttribute("cgyfk", cgyfk);
		request.setAttribute("hj", df.format(hj));
		
		return "manage/list";
	}
	
    /**
     * 刷新产品列表
     * @param request
     * @return
     */
	@RequestMapping(value="/refreshProductList")
	public @ResponseBody String refreshProductList(HttpServletRequest request) {
		
		String result = "false";
		
		String sql = "UPDATE sproductrow b, smaterial c SET b.materialname = c.materialname, b.materialprice = c.price"
				+ " WHERE b.materialid = c.materialid";
		
		int iReturn = dbUtils.executeSQL(sql);
		if (iReturn >= 0 && refreshProduct()) {
			result = "true";
		}
		
		return result;
	}
	
    /**
     * 查询利润
     * @param request
     * @return
     */
	@RequestMapping(value="/queryProfit")
	public @ResponseBody String queryProfit(HttpServletRequest request) {

		String sellno = StrUtils.nullToStr(request.getParameter("sellno"));
		String currflow = StrUtils.nullToStr(request.getParameter("currflow"));
		String selldateFrom = StrUtils.nullToStr(request.getParameter("selldateFrom"));
		String selldateTo = StrUtils.nullToStr(request.getParameter("selldateTo"));
		
		String iReturn = manageDaoImpl.getProfit(sellno, currflow, selldateFrom, selldateTo, "");
		
		return iReturn;
	}
	
    /**
     * 刷新产品物资
     * @param request
     * @return
     */
	@RequestMapping(value="/refreshProductMaterial")
	public @ResponseBody String refreshProductMaterial(HttpServletRequest request) {
		
		String result = "false";

		String materialno_old = StrUtils.nullToStr(request.getParameter("materialno_old"));
		String materialno_new = StrUtils.nullToStr(request.getParameter("materialno_new"));
		
		if(!materialno_old.equals("") && !materialno_new.equals("")) {
			String sql = "UPDATE sproductrow b, smaterial c, smaterial d"
					+ " SET b.materialid = d.materialid, b.materialno = d.materialno, b.materialname = d.materialname,"
					+ " b.materialprice = d.price"
					+ " WHERE b.materialid = c.materialid AND c.materialno = '" + materialno_old
					+ "' AND d.materialno = '" + materialno_new + "'";
			
			int iReturn = dbUtils.executeSQL(sql);
			if (iReturn >= 0 && refreshProduct()) {
				result = "true";
			}
		}
		
		return result;
	}
	
	/**
	 * 更新产品成本、利润
	 * @return
	 */
	private boolean refreshProduct() {
		boolean result = false;
		
		String sql = "UPDATE sproduct a"
				+ " SET costprice = (SELECT IFNULL(SUM(IFNULL(b.materialsum, 0)), 0) FROM sproductrow b"
				+ " WHERE b.productid = a.productid), profit = (realprice - costprice)";
		
		int iReturn = dbUtils.executeSQL(sql);
		if (iReturn >= 0) {
			result = true;
		}
		
		return result;
	}
}