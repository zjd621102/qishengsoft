package com.yecoo.web;


import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.yecoo.dao.ReportDaoImpl;
import com.yecoo.model.CodeTableForm;
/**
 * 报表管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/report")
public class ReportAction {

	private ReportDaoImpl reportDaoImpl = new ReportDaoImpl();

	/**
	 * 月度供应商报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportBuy:view")
	@RequestMapping(value = "/reportBuy")
	public String reportBuy(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportBuyList(form, request);
		request.setAttribute("sn", "reportBuy"); //授权名称
		request.setAttribute("form", form);

		return "report/reportBuy";
	}

	/**
	 * 月度客户报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportSell:view")
	@RequestMapping(value = "/reportSell")
	public String reportSell(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportSellList(form, request);
		request.setAttribute("sn", "reportSell"); //授权名称
		request.setAttribute("form", form);

		return "report/reportSell";
	}

	/**
	 * 月度综合报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportColligate:view")
	@RequestMapping(value = "/reportColligate")
	public String reportColligate(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportColligateList(form, request);
		request.setAttribute("sn", "reportColligate"); //授权名称
		request.setAttribute("form", form);

		return "report/reportColligate";
	}

	/**
	 * 综合统计报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportStatistics:view")
	@RequestMapping(value = "/reportStatistics")
	public String reportStatistics(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportStatisticsList(form, request);
		request.setAttribute("sn", "reportStatistics"); //授权名称
		request.setAttribute("form", form);

		return "report/reportStatistics";
	}

	/**
	 * 综合物资报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportMaterial:view")
	@RequestMapping(value = "/reportMaterial")
	public String reportMaterial(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportMaterialList(form, request);
		request.setAttribute("sn", "reportMaterial"); //授权名称
		request.setAttribute("form", form);

		return "report/reportMaterial";
	}

	/**
	 * 综合产品报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportProduct:view")
	@RequestMapping(value = "/reportProduct")
	public String reportProduct(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportProductList(form, request);
		request.setAttribute("sn", "reportProduct"); //授权名称
		request.setAttribute("form", form);

		return "report/reportProduct";
	}

	/**
	 * 综合供应商报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportManu:view")
	@RequestMapping(value = "/reportManu")
	public String reportManu(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportManuList(form, request);
		request.setAttribute("sn", "reportManu"); //授权名称
		request.setAttribute("form", form);

		return "report/reportManu";
	}

	/**
	 * 综合客户报表
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("ReportClient:view")
	@RequestMapping(value = "/reportClient")
	public String reportClient(CodeTableForm form, HttpServletRequest request) {
		
		reportDaoImpl.getReportClientList(form, request);
		request.setAttribute("sn", "reportClient"); //授权名称
		request.setAttribute("form", form);

		return "report/reportClient";
	}
}