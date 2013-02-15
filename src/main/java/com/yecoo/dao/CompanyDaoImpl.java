package com.yecoo.dao;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;

public class CompanyDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 通过ID获取公司信息
	 * @param companyid
	 * @return
	 */
	public CodeTableForm getCompanyById(int companyid) {
		
		String sql = "SELECT a.* FROM scompany a WHERE a.companyid = '" + companyid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	/**
	 * 修改公司信息
	 * @param form
	 * @return
	 */
	public int ediCompany(CodeTableForm form) {
		
		int iReturn = dbUtils.setUpdate(form, "scompany", "companyid");
		return iReturn;
	}
}