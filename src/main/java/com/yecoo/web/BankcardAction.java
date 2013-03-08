package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.BankcardDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 银行卡管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/bankcard")
public class BankcardAction {

	private BankcardDaoImpl bankcardDaoImpl = new BankcardDaoImpl();

	@RequiresPermissions("Bankcard:view")
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(CodeTableForm form, HttpServletRequest request) {

		String first = StrUtils.nullToStr(request.getParameter("first")); //查询初始化
		if(first.equals("true")) {
			form.setValue("status", "1");
		}
		bankcardDaoImpl.initAction(request);

		int totalCount = bankcardDaoImpl.getBankcardCount(form);
		List<CodeTableForm> bankcardList = bankcardDaoImpl.getBankcardList(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		request.setAttribute("bankcardList", bankcardList); // 银行卡列表
		request.setAttribute("sn", "bankcard"); //授权名称
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "bankcard/list";
	}

	@RequiresPermissions("Bankcard:add")
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "bankcard/add";
	}

	@RequiresPermissions("Bankcard:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		
		String sql = "SELECT COUNT(1) FROM sbankcard WHERE bankcardno = '" + form.getValue("bankcardno") + "'";
		DbUtils dbUtils = new DbUtils();
		int count = dbUtils.getIntBySql(sql);
		if(count >= 1) {
			ajaxObject = new AjaxObject("“银行卡卡号”已存在");
		} else {
			int iReturn = bankcardDaoImpl.addBankcard(form);
			if (iReturn >= 1) {
				ajaxObject = new AjaxObject("新增成功！", "bankcard_list", "closeCurrent");
			} else {
				ajaxObject = new AjaxObject("新增失败");
			}
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Bankcard:edi")
	@RequestMapping(value="/edi/{bankcardid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("bankcardid") int bankcardid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = bankcardDaoImpl.getBankcardById(bankcardid);
		request.setAttribute("form", form);
		
		this.getSelects(request);
		
		return "bankcard/edi";
	}

	@RequiresPermissions("Bankcard:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = bankcardDaoImpl.ediBankcard(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "bankcard_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Bankcard:delete")
	@RequestMapping(value="/delete/{bankcardid}")
	public @ResponseBody String delete(@PathVariable int bankcardid) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		iReturn = bankcardDaoImpl.deleteBankcard(bankcardid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "bankcard_list", "");
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
		String sql = "select * from cbanktype order by banktypeid";
		List<CodeTableForm> banktypeList = dbUtils.getListBySql(sql); //银行类型
		sql = "select * from cstatus order by statusid";
		List<CodeTableForm> statusList = dbUtils.getListBySql(sql); //状态
		request.setAttribute("banktypeList", banktypeList);
		request.setAttribute("statusList", statusList);
	}
	
	/**
	 * 进入内部银行卡转账
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Bankcard:other")
	@RequestMapping(value="/transferAccount/{bankcardid}", method=RequestMethod.GET)
	public String toTransferAccount(@PathVariable("bankcardid") int bankcardid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = bankcardDaoImpl.getBankcardById(bankcardid);
		request.setAttribute("form", form);
		
		List<CodeTableForm> allBankcardList = bankcardDaoImpl.getAllBankcardList(form); //所有银行卡账号
		request.setAttribute("allBankcardList", allBankcardList);
		
		return "bankcard/transferAccount";
	}
	
	/**
	 * 内部银行卡转账
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Bankcard:other")
	@RequestMapping(value="/transferAccount", method=RequestMethod.POST)
	public @ResponseBody String transferAccount(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		form.setValue("createtime", StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"));
		int iReturn = bankcardDaoImpl.transferAccount(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("转账成功！", "bankcard_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("转账失败");
		}
		return ajaxObject.toString();
	}
	
	@RequiresPermissions("Bankcard:other")
	@RequestMapping(value="/transferAccount_list", method={RequestMethod.GET, RequestMethod.POST})
	public String transferAccount_list(CodeTableForm form, HttpServletRequest request) {

		bankcardDaoImpl.initAction(request);

		int totalCount = bankcardDaoImpl.getTransferaccountCount(form);
		List<CodeTableForm> transferaccountList = bankcardDaoImpl.getTransferaccountList(form);
		request.setAttribute("totalCount", totalCount); //列表总数量
		request.setAttribute("transferaccountList", transferaccountList); //转账列表
		request.setAttribute("sn", "bankcard"); //授权名称
		request.setAttribute("form", form);

		return "bankcard/transferAccount_list";
	}
	
	/**
	 * 进入其它收支管理
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Bankcard:other")
	@RequestMapping(value="/receandpay/{bankcardid}", method=RequestMethod.GET)
	public String toReceandpay(@PathVariable("bankcardid") int bankcardid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = bankcardDaoImpl.getBankcardById(bankcardid);
		request.setAttribute("form", form);
		
		String sql = "select * from creceandpaytype order by receandpaytypeid";
		DbUtils dbUtils = new DbUtils();
		List<CodeTableForm> receandpaytypeList = dbUtils.getListBySql(sql); //收支类型
		request.setAttribute("receandpaytypeList", receandpaytypeList);
		
		return "bankcard/receandpay";
	}
	
	/**
	 * 其它收支管理
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Bankcard:other")
	@RequestMapping(value="/receandpay", method=RequestMethod.POST)
	public @ResponseBody String receandpay(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		form.setValue("createtime", StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"));
		int iReturn = bankcardDaoImpl.receandpay(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("其它收支操作成功！", "bankcard_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("其它收支操作失败");
		}
		return ajaxObject.toString();
	}
	/**
	 * 其它收支管理列表
	 * @param form
	 * @param request
	 * @return
	 */
	@RequiresPermissions("Bankcard:other")
	@RequestMapping(value="/receandpay_list", method={RequestMethod.GET, RequestMethod.POST})
	public String receandpay_list(CodeTableForm form, HttpServletRequest request) {

		bankcardDaoImpl.initAction(request);

		int totalCount = bankcardDaoImpl.getReceandpayCount(form);
		List<CodeTableForm> receandpayList = bankcardDaoImpl.getReceandpayList(form);
		request.setAttribute("totalCount", totalCount); //列表总数量
		request.setAttribute("receandpayList", receandpayList); //转账列表
		request.setAttribute("sn", "bankcard"); //授权名称
		request.setAttribute("form", form);

		String sql = "select * from creceandpaytype order by receandpaytypeid";
		DbUtils dbUtils = new DbUtils();
		List<CodeTableForm> receandpaytypeList = dbUtils.getListBySql(sql); //收支类型
		request.setAttribute("receandpaytypeList", receandpaytypeList);
		
		return "bankcard/receandpay_list";
	}
}