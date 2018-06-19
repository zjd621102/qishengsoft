package com.yecoo.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.LogDaoImpl;
import com.yecoo.dao.ParameterDaoImpl;
import com.yecoo.dao.SellDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 销售单管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/sell")
public class SellAction {

	DbUtils dbUtils = new DbUtils();
	private SellDaoImpl sellDaoImpl = new SellDaoImpl();

	@RequiresPermissions("Sell:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String first = StrUtils.nullToStr(request.getParameter("first")); //查询初始化
		if(first.equals("true")) {
//			form.setValue("currflow", "发货");
			form.setValue("first", "true");
		}
		sellDaoImpl.initAction(request);
		
		initManu(form, request);

		int totalCount = sellDaoImpl.getSellCount(form);
		List<CodeTableForm> sellList = sellDaoImpl.getSellList(form);
		String totalSum = sellDaoImpl.getSellSum(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("sellList", sellList); // 销售单列表
		request.setAttribute("totalSum", totalSum); // 销售额
		request.setAttribute("sn", "sell"); //授权名称
		request.setAttribute("form", form);
		
		return "sell/list";
	}

	@RequiresPermissions("Sell:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		
		String selldate = StrUtils.getSysdate(); //销售日期默认为当前日期
		form.setValue("selldate", selldate);
		
		initManu(form, request);
		
		request.setAttribute("form", form);
		
		return "sell/add";
	}

	@RequiresPermissions("Sell:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createtime", createtime);
		
		String sellno = StrUtils.getNewNO("XSD","sellno","bsell");
		form.setValue("sellno", sellno); //初始化单据号
		
		CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		String maker = StrUtils.nullToStr(user.getValue("userid"));
		form.setValue("maker", maker);
		int iReturn = sellDaoImpl.addSell(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "sell_list", "closeCurrent");

			StrUtils.saveLog(request, "新增销售单", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequestMapping(value="/edi/{sellid}")
	public String toEdi(@PathVariable("sellid") int sellid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = sellDaoImpl.getSellById(sellid, request);
		
		request.setAttribute("form", form);
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("print")) {
			
			ParameterDaoImpl parameterDaoImpl = new ParameterDaoImpl();
			String companyName = parameterDaoImpl.getParameterName("公司名称");
			String storeAddress = parameterDaoImpl.getParameterName("店面地址");
			String storePhone = parameterDaoImpl.getParameterName("店面电话");
			form.setValue("companyName", companyName);
			form.setValue("storeAddress", storeAddress);
			form.setValue("storePhone", storePhone);
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(currflow.equals("发货")) {
				String manuid = StrUtils.nullToStr(form.getValue("manuid"));
				String sql = "SELECT SUM(m.realsum) FROM ("
						+ "SELECT IFNULL(SUM(IFNULL(b.plansum, 0) - IFNULL(b.realsum, 0)), 0) realsum"
						+ " FROM bpay a, bpayrow b WHERE a.payid = b.payid"
						+ " AND a.currflow = '申请' AND a.manuid = '" + manuid + "'"
						+ " UNION ALL"
						+ " SELECT IFNULL(SUM(b.realsum), 0) realsum FROM bsell a, bsellrow b WHERE a.sellid = b.sellid"
						+ " AND a.currflow = '发货' AND a.manuid = '" + manuid + "'"
						+ ") m";
				double allToPaysum = Double.parseDouble(dbUtils.execQuerySQL(sql));// 所有待付款
				sql = "SELECT IFNULL(SUM(b.realsum), 0) realsum FROM bsellrow b WHERE b.sellid = '" + sellid + "'";
				double currToPaysum = Double.parseDouble(dbUtils.execQuerySQL(sql));// 当前待付款
				
				// 处理double相减精度问题
				BigDecimal bd1 = new BigDecimal(Double.toString(allToPaysum)); 
		        BigDecimal bd2 = new BigDecimal(Double.toString(currToPaysum)); 
		        double historyToPaysum = bd1.subtract(bd2).doubleValue(); 

				request.setAttribute("currToPaysum", currToPaysum);
				request.setAttribute("historyToPaysum", historyToPaysum);
				request.setAttribute("allToPaysum", allToPaysum);
			}
			
			return "sell/print"; // 打印
		} else if(act.equals("printBuy")) {// 采购单
			return "sell/print_buy";
		} else if(act.equals("printDo")) {// 生产单
			return "sell/print_do";
		} else if(act.equals("printBox")) {// 箱子贴纸
			@SuppressWarnings("unchecked")
			List<CodeTableForm> sellrowList = (List<CodeTableForm>) request.getAttribute("sellrowList");
			double boxnum = 0;
			String iscu = null;
			List<CodeTableForm> boxList = new ArrayList<CodeTableForm>();
			CodeTableForm box = null;
			for(CodeTableForm codeTableForm : sellrowList) {
				boxnum = Double.parseDouble(codeTableForm.getValue("boxnum").toString());
				for(int i = 0; i < boxnum*2; i++) {
					box = new CodeTableForm();
					
					box.setValue(
							"producttypename",
							StrUtils.nullToStr(codeTableForm.getValue("ptprintname")).equals("") ? codeTableForm
									.getValue("producttypename") : codeTableForm
									.getValue("ptprintname"));// 产品类型
					box.setValue("productname", codeTableForm.getValue("productname"));// 产品名称
					box.setValue("numofonebox", codeTableForm.getValue("numofonebox"));// 一件数量
					box.setValue("printname", codeTableForm.getValue("printname"));// 打印名
					
					
					if(codeTableForm.getValue("iscu").equals("1")) {
						iscu = "铜";
					} else {
						iscu = "";
					}
					box.setValue("iscu", iscu);// 产品材质
					
					boxList.add(box);
				}
			}
			
			int boxRow = Integer.parseInt(new ParameterDaoImpl().getParameterName("箱子行数"));
			int boxCol = Integer.parseInt(new ParameterDaoImpl().getParameterName("箱子列数"));
			
			int boxsize = boxList.size();
			int pagenum = (boxsize - 1)/(boxRow*boxCol) + 1;

			request.setAttribute("boxsize", boxsize);// 件数
			request.setAttribute("pagenum", pagenum);// 页数
			request.setAttribute("boxList", boxList);// 列表
			request.setAttribute("boxRow", boxRow);// 箱子行数
			request.setAttribute("boxCol", boxCol);// 箱子列数
			
			return "sell/print_box";
		}
		
		return "sell/edi";
	}

	@RequiresPermissions("Sell:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = sellDaoImpl.ediSell(form, request);
		if (iReturn >= 0) {
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			String allbackType = "";
			if(currflow.equals("结束")) {// 单据结束，则关闭窗口
				allbackType = "closeCurrent";
			}
			ajaxObject = new AjaxObject("修改成功！", "sell_list", allbackType);// closeCurrent

			StrUtils.saveLog(request, "修改销售单", form);
			
			if("1".equals(form.getValue("addBuy"))) {// 生成采购单
				String sql = "SELECT COUNT(1) FROM bbuy t WHERE t.relateno = '" + form.getValue("sellno") + "'";
				int cou = dbUtils.getIntBySql(sql);
				if(cou >= 1) {
					ajaxObject = new AjaxObject("关联采购单已存在");
				} else {
					CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
					String maker = StrUtils.nullToStr(user.getValue("userid"));
					
					iReturn = sellDaoImpl.addBuy(form, maker);
					if(iReturn >= 0) {
						ajaxObject = new AjaxObject("生成采购单成功！", "sell_list", "closeCurrent");
					} else {
						ajaxObject = new AjaxObject("生成采购单失败");
					}
				}
			}
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Sell:delete")
	@RequestMapping(value="/delete/{sellid}")
	public @ResponseBody String delete(@PathVariable int sellid, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM bsell t WHERE t.currflow <> '申请' AND t.sellid = '" + sellid + "'";
		int icount = dbUtils.getIntBySql(sql);
		if(icount >= 1) {
			ajaxObject = new AjaxObject("删除失败（单据不在申请流程）");
		} else {
			iReturn = sellDaoImpl.deleteSell(sellid);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("删除成功！", "sell_list", "");

				LogDaoImpl.saveLog(request, "删除销售单", sellid);
			} else {
				ajaxObject = new AjaxObject("删除失败");
			}
		}
		return ajaxObject.toString();
	}
	
    /**
     * 重新生成编码
     * @param request
     * @return
     */
	@RequestMapping(value="/newNo")
	public @ResponseBody String newNo(HttpServletRequest request) {
		
		String result = "false";
		
		String sellid = StrUtils.nullToStr(request.getParameter("sellid"));
		String sellno = StrUtils.getNewNO("XSD","sellno","bsell");
		String selldate = DateUtils.getNowDateTime("yyyy-MM-dd");
		
		String sql = "UPDATE bsell SET sellno = '" + sellno + "', selldate = '" + selldate
				+ "' WHERE sellid = '" + sellid + "'";
		
		int iReturn = dbUtils.executeSQL(sql);
		if (iReturn >= 0) {
			result = "true";
		}
		
		return result;
	}

	/**
	 * 合并销售单
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Sell:edi")
	@RequestMapping(value="/merge")
	public @ResponseBody String merge(HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = -1;
		
		String[] ids = request.getParameterValues("ids");
		String sellids = StrUtils.ArrayToStr(ids, "','");
		sellids = "'" + sellids + "'";

		String sql = "SELECT COUNT(1) FROM bsell t WHERE t.currflow <> '申请' AND t.sellid IN (" + sellids + ")";
		int icount = dbUtils.getIntBySql(sql);
		
		if(icount >= 1) {
			ajaxObject = new AjaxObject("合并失败（单据不在申请流程）");
		} else {
			sql = "SELECT COUNT(1) FROM (SELECT COUNT(1) FROM bsell t WHERE t.sellid IN ("
				+ sellids + ") GROUP BY t.manuid) a";
			icount = dbUtils.getIntBySql(sql);
			
			if(icount >= 2) {
				ajaxObject = new AjaxObject("合并失败（供应商不同）");
			} else {
				CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
				String maker = StrUtils.nullToStr(user.getValue("userid"));
				
				iReturn = sellDaoImpl.mergeSell(sellids, maker);
				
				if (iReturn >= 0) {
					ajaxObject = new AjaxObject("合并成功！", "sell_list", "");
				} else {
					ajaxObject = new AjaxObject("合并失败");
				}
			}
		}
		
		return ajaxObject.toString();
	}
	
	/**
	 * 初始化客户信息
	 * @param form
	 * @param request
	 */
	private void initManu(CodeTableForm form, HttpServletRequest request) {
		CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		if("1".equals(user.getValue("ismanu"))) {// 是客户
			CodeTableForm manu = dbUtils.getFormByColumn("smanu", "relateuserid",
					String.valueOf(user.getValue("userid")));
			if(manu != null) {
				form.setValue("manuid", manu.getValue("manuid"));
				form.setValue("manuname", manu.getValue("manuname"));
			}
		}
	}
}