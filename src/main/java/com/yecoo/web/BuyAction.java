package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.BuyDaoImpl;
import com.yecoo.dao.LogDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 采购单管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/buy")
public class BuyAction {

	DbUtils dbUtils = new DbUtils();
	private BuyDaoImpl buyDaoImpl = new BuyDaoImpl();

	@RequiresPermissions("Buy:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String first = StrUtils.nullToStr(request.getParameter("first")); // 查询初始化
		if(first.equals("true")) {
			form.setValue("currflow", "申请");
		}
		
		buyDaoImpl.initAction(request);

		int totalCount = buyDaoImpl.getBuyCount(form);
		List<CodeTableForm> buyList = buyDaoImpl.getBuyList(form);
		String totalSum = buyDaoImpl.getBuySum(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("buyList", buyList); // 采购单列表
		request.setAttribute("totalSum", totalSum); // 销售额
		request.setAttribute("sn", "buy"); // 授权名称
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "buy/list";
	}

	@RequiresPermissions("Buy:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		
		String buydate = StrUtils.getSysdate(); //采购日期默认为当前日期
		form.setValue("buydate", buydate);
		
		String buyname = StrUtils.getSysdate("yyyy.MM.dd") + "采购"; //采购名称
		form.setValue("buyname", buyname);
		
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "buy/add";
	}

	@RequiresPermissions("Buy:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); // 当前日期
		form.setValue("createtime", createtime);
		
		String btype = StrUtils.nullToStr(form.getValue("btype"));				
		String buyno = StrUtils.getNewNO(btype,"buyno","bbuy");
		form.setValue("buyno", buyno); // 初始化单据号
		
		CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		String maker = StrUtils.nullToStr(user.getValue("userid"));
		form.setValue("maker", maker);
		int iReturn = buyDaoImpl.addBuy(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "buy_list", "closeCurrent");

			StrUtils.saveLog(request, "新增采购单", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Buy:edi")
	@RequestMapping(value="/edi/{buyid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("buyid") int buyid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = buyDaoImpl.getBuyById(buyid, request);
		
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("print")) {
			return "buy/print"; // 打印
		}
		
		return "buy/edi";
	}

	@RequiresPermissions("Buy:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = buyDaoImpl.ediBuy(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "buy_list", "closeCurrent");

			StrUtils.saveLog(request, "修改采购单", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Buy:delete")
	@RequestMapping(value="/delete/{buyid}")
	public @ResponseBody String delete(@PathVariable int buyid, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		String sql = "SELECT COUNT(1) FROM bbuy t WHERE t.currflow <> '申请' AND t.buyid = '" + buyid + "'";
		int icount = dbUtils.getIntBySql(sql);
		if(icount >= 1) {
			ajaxObject = new AjaxObject("删除失败（单据不在申请流程）");
		} else {
			iReturn = buyDaoImpl.deleteBuy(buyid);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("删除成功！", "buy_list", "");

				LogDaoImpl.saveLog(request, "删除采购单", buyid);
			} else {
				ajaxObject = new AjaxObject("删除失败");
			}
		}
		return ajaxObject.toString();
	}
	
	/**
	 * 获取下拉列表
	 * @param request
	 */
	private void getSelects(HttpServletRequest request) {

		String sql = "SELECT * FROM sbtype WHERE btype in ('CGD','JYD')";
		List<CodeTableForm> btypeList = dbUtils.getListBySql(sql); // 单据类型
		request.setAttribute("btypeList", btypeList);
	}
}