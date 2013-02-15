package com.yecoo.web;

import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.CompanyDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 公司信息管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/company")
public class CompanyAction {

	private CompanyDaoImpl companyDaoImpl = new CompanyDaoImpl();

	@RequiresPermissions("Company:edi")
	@RequestMapping(value="/edi/{companyid}", method=RequestMethod.GET)
	public String toEdi(@PathVariable("companyid") int companyid, HttpServletRequest request) {
		
		CodeTableForm form = null;
		form = companyDaoImpl.getCompanyById(companyid);
		request.setAttribute("form", form);
		return "company/edi";
	}

	@RequiresPermissions("Company:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = companyDaoImpl.ediCompany(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "", "");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}
}