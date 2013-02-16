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
import com.yecoo.util.Constants;
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

		String act = StrUtils.nullToStr(request.getAttribute("act"));
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request
			.getParameter("numPerPage"));
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

		int totalCount = bankcardDaoImpl.getBankcardCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> bankcardList = bankcardDaoImpl.getBankcardList(form, pageNum,
			numPerPage);
		request.setAttribute("bankcardList", bankcardList); // 银行卡列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		request.setAttribute("sn", "bankcard"); //授权名称
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
}