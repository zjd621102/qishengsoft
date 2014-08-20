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
import com.yecoo.dao.SellDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
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
			form.setValue("currflow", "申请");
		}
		sellDaoImpl.initAction(request);

		int totalCount = sellDaoImpl.getSellCount(form);
		List<CodeTableForm> sellList = sellDaoImpl.getSellList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("sellList", sellList); // 销售单列表
		request.setAttribute("sn", "sell"); //授权名称
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "sell/list";
	}

	@RequiresPermissions("Sell:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		
		String selldate = StrUtils.getSysdate(); //销售日期默认为当前日期
		form.setValue("selldate", selldate);
		
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
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

	@RequiresPermissions("Sell:edi")
	@RequestMapping(value="/edi/{sellid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("sellid") int sellid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = sellDaoImpl.getSellById(sellid, request);
		
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("print")) {
			return "sell/print"; // 打印
		}
		
		return "sell/edi";
	}

	@RequiresPermissions("Sell:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = sellDaoImpl.ediSell(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "sell_list", "closeCurrent");

			StrUtils.saveLog(request, "修改销售单", form);
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
	 * 获取下拉列表
	 * @param request
	 */
	private void getSelects(HttpServletRequest request) {

		String sql = "SELECT * FROM cunit ORDER BY priority";
		List<CodeTableForm> unitList = dbUtils.getListBySql(sql); //计量单位
		request.setAttribute("unitList", unitList);

		sql = "SELECT * FROM sflow WHERE btype = 'XXX' ORDER BY priority,flowid";
		List<CodeTableForm> currflowList = dbUtils.getListBySql(sql); //当前流程
		request.setAttribute("currflowList", currflowList);
	}
}