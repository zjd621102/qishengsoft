package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.PayDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 单据管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/pay")
public class PayAction {

	DbUtils dbUtils = new DbUtils();
	private PayDaoImpl payDaoImpl = new PayDaoImpl();

	@RequiresPermissions("Pay:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {
		
		String first = StrUtils.nullToStr(request.getParameter("first")); //查询初始化
		if(first.equals("true")) {
			form.setValue("currflow", "申请");
		}
		payDaoImpl.initAction(request);

		int totalCount = payDaoImpl.getPayCount(form);
		List<CodeTableForm> payList = payDaoImpl.getPayList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("payList", payList); // 单据列表
		request.setAttribute("sn", "pay"); //授权名称
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "pay/list";
	}

	@RequiresPermissions("Pay:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "pay/add";
	}

	@RequiresPermissions("Pay:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createtime", createtime);
		CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		String maker = StrUtils.nullToStr(user.getValue("userid"));
		form.setValue("maker", maker);
		int iReturn = payDaoImpl.addPay(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "pay_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Pay:edi")
	@RequestMapping(value="/edi/{payid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("payid") int payid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = payDaoImpl.getPayById(payid, request);

		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("print")) {
			return "pay/print"; // 打印
		}
		
		return "pay/edi";
	}

	@RequiresPermissions("Pay:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		CodeTableForm user = (CodeTableForm) request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		form.setValue("operater", user.getValue("userid"));
		form.setValue("operatetime", DateUtils.getNowDateTime());
		
		AjaxObject ajaxObject = null;
		int iReturn = payDaoImpl.ediPay(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "pay_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Pay:delete")
	@RequestMapping(value="/delete/{payid}")
	public @ResponseBody String delete(@PathVariable int payid, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		
		CodeTableForm form = payDaoImpl.getPayById(payid, request);
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		if(currflow.equals("结束")) {
			ajaxObject = new AjaxObject("单据已结束，不能删除");
		} else if(!"".equals(StrUtils.nullToStr(form.getValue("relateno")))) {
			ajaxObject = new AjaxObject("单据已关联其它单据，不能删除");
		} else {
			iReturn = payDaoImpl.deletePay(payid);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("删除成功！", "pay_list", "");
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

		String sql = "SELECT * FROM sbtype WHERE btype in ('FKD','SKD','YFD','GZD')";
		List<CodeTableForm> btypeList = dbUtils.getListBySql(sql); //单据类型
		sql = "SELECT * FROM sbankcard WHERE status = '1'";
		List<CodeTableForm> bankcardList = dbUtils.getListBySql(sql); //银行卡
		sql = "SELECT * FROM sflow WHERE btype = 'XXX' ORDER BY priority,flowid";
		List<CodeTableForm> currflowList = dbUtils.getListBySql(sql); //当前流程
		request.setAttribute("btypeList", btypeList);
		request.setAttribute("bankcardList", bankcardList);
		request.setAttribute("currflowList", currflowList);
	}
}