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

	private BuyDaoImpl buyDaoImpl = new BuyDaoImpl();

	@RequiresPermissions("Buy:view")
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

		int totalCount = buyDaoImpl.getBuyCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> buyList = buyDaoImpl.getBuyList(form, pageNum, numPerPage);
		request.setAttribute("buyList", buyList); // 采购单列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		request.setAttribute("sn", "buy"); //授权名称
		
		this.getSelects(request);
		
		return "buy/list";
	}

	@RequiresPermissions("Buy:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "buy/add";
	}

	@RequiresPermissions("Buy:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		String createtime = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createtime", createtime);
		
		String btype = StrUtils.nullToStr(form.getValue("btype"));				
		String buyno = StrUtils.getNewNO(btype,"buyno","bbuy");
		form.setValue("buyno", buyno); //初始化单据号
		
		CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
		String maker = StrUtils.nullToStr(user.getValue("userid"));
		form.setValue("maker", maker);
		int iReturn = buyDaoImpl.addBuy(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("新增成功！", "buy_list", "closeCurrent");
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
		
		return "buy/edi";
	}

	@RequiresPermissions("Buy:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = buyDaoImpl.ediBuy(form, request);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "buy_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Buy:delete")
	@RequestMapping(value="/delete/{buyid}")
	public @ResponseBody String delete(@PathVariable int buyid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = buyDaoImpl.deleteBuy(buyid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "buy_list", "");
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

		DbUtils dbUtils = new DbUtils();
		String sql = "SELECT * FROM cunit ORDER BY priority";
		List<CodeTableForm> unitList = dbUtils.getListBySql(sql); //采购单类型
		request.setAttribute("unitList", unitList);

		sql = "SELECT * FROM sflow WHERE btype = 'CGD'";
		List<CodeTableForm> currflowList = dbUtils.getListBySql(sql); //当前流程
		request.setAttribute("currflowList", currflowList);

		sql = "SELECT * FROM sbtype WHERE btype in ('CGD','JYD')";
		List<CodeTableForm> btypeList = dbUtils.getListBySql(sql); //当前流程
		request.setAttribute("btypeList", btypeList);
	}
}