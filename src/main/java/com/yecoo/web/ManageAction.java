package com.yecoo.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 配置管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/manage")
public class ManageAction {

	DbUtils dbUtils = new DbUtils();
	
	/**
	 * 配置列表
	 * 
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("Manage:view")
	@RequestMapping(value = "/list")
	public String list(CodeTableForm form, HttpServletRequest request) {

		return "manage/list";
	}
	
    /**
     * 刷新产品列表
     * @param request
     * @return
     */
	@RequestMapping(value="/refreshProductList")
	public @ResponseBody String refreshProductList(HttpServletRequest request) {
		
		String result = "false";
		
		String sql = "UPDATE sproductrow b, smaterial c SET b.materialname = c.materialname, b.materialprice = c.price"
				+ " WHERE b.materialid = c.materialid AND b.materialprice <> c.price";
		
		int iReturn = dbUtils.executeSQL(sql);
		if (iReturn >= 0) {
			result = "true";
		}
		
		return result;
	}
}