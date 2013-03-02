package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.yecoo.dao.BankcardDaoImpl;
import com.yecoo.dao.ManuDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 查找带回管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/backselect")
public class BackselectAction {
	/**
	 * 供应商
	 * @param form
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/manu", method={RequestMethod.GET, RequestMethod.POST})
	public String manu(CodeTableForm form, HttpServletRequest request) {
		
		ManuDaoImpl manuDaoImpl = new ManuDaoImpl();
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

		int totalCount = manuDaoImpl.getManuCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> manuList = manuDaoImpl.getManuList(form, pageNum, numPerPage);
		request.setAttribute("manuList", manuList); // 供应商列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		request.setAttribute("sn", "backselect"); //授权名称
		
		DbUtils dbUtils = new DbUtils();
		String sql = "select * from cmanutype order by manutypeid";
		List<CodeTableForm> manuTypeList = dbUtils.getListBySql(sql); //供应商类型
		request.setAttribute("manuTypeList", manuTypeList);
		
		return "backselect/manu";
	}
	
	@RequestMapping(value="/bankcard", method={RequestMethod.GET, RequestMethod.POST})
	public String bankcard(CodeTableForm form, HttpServletRequest request) {

		BankcardDaoImpl bankcardDaoImpl = new BankcardDaoImpl();
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
		List<CodeTableForm> bankcardList = bankcardDaoImpl.getBankcardList(form, pageNum, numPerPage);
		request.setAttribute("bankcardList", bankcardList); // 银行卡列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		request.setAttribute("sn", "backselect"); //授权名称
		return "backselect/bankcard";
	}
}