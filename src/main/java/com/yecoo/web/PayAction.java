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
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 收付款单管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/pay")
public class PayAction {

	private PayDaoImpl payDaoImpl = new PayDaoImpl();

	@RequiresPermissions("Pay:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String act = StrUtils.nullToStr(request.getAttribute("act"));
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request.getParameter("numPerPage"));
		int pageNum = 1;
		int numPerPage = Constants.NUMPERPAGE;
		if (!sPageNum.equals("")) {
			pageNum = Integer.parseInt(sPageNum);
		}
		if (!sNumPerPage.equals("")) {
			numPerPage = Integer.parseInt(sNumPerPage);
		}
		request.setAttribute("pageNum", pageNum); // 当前页
		request.setAttribute("numPerPage", numPerPage); // 每页数量

		int totalCount = payDaoImpl.getPayCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> payList = payDaoImpl.getPayList(form, pageNum, numPerPage);
		request.setAttribute("payList", payList); // 收付款单列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		request.setAttribute("sn", "pay"); //授权名称
		
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
		int iReturn = payDaoImpl.addPay(form);
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
		form = payDaoImpl.getPayById(payid);
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "pay/edi";
	}

	@RequiresPermissions("Pay:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = payDaoImpl.ediPay(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "pay_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Pay:delete")
	@RequestMapping(value="/delete/{payid}")
	public @ResponseBody String delete(@PathVariable int payid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		
		CodeTableForm form = payDaoImpl.getPayById(payid);
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		if(currflow.equals("结束")) {
			ajaxObject = new AjaxObject("单据已结束，不能删除");
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

		DbUtils dbUtils = new DbUtils();
		String sql = "SELECT * FROM sbtype WHERE btype in ('FKD','SKD','YFD')";
		List<CodeTableForm> btypeList = dbUtils.getListBySql(sql); //单据类型
		sql = "SELECT * FROM sbankcard WHERE status = '1'";
		List<CodeTableForm> bankcardList = dbUtils.getListBySql(sql); //银行卡
		sql = "SELECT * FROM sflow WHERE btype = 'XXX'";
		List<CodeTableForm> currflowList = dbUtils.getListBySql(sql); //当前流程
		request.setAttribute("btypeList", btypeList);
		request.setAttribute("bankcardList", bankcardList);
		request.setAttribute("currflowList", currflowList);
	}
}