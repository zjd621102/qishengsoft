package com.yecoo.dao;

import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class BankcardDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	
	/**
	 * 获取银行卡数量
	 * @param form
	 * @return
	 */
	public int getBankcardCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.bankcardid) FROM sbankcard t WHERE 1 = 1";
		String cond = getBankcardListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取银行卡列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getBankcardList(CodeTableForm form, int pageNum, int numPerPage) {
		
		String sql = "SELECT t.*, func_getBanktypeName(t.banktype) banktypename,"
				+ " func_getStatusName(t.status) statusname FROM sbankcard t WHERE 1 = 1";
		String cond = getBankcardListCondition(form);
		sql  += cond;
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取银行卡列表-条件
	 * @param form
	 * @return
	 */
	public String getBankcardListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String bankcardno = StrUtils.nullToStr(form.getValue("bankcardno"));
		
		if(!bankcardno.equals("")) {
			cond.append(" AND t.bankcardno like '%").append(bankcardno).append("%'");
		}
		
		return cond.toString();
	}
	/**
	 * 新增银行卡
	 * @param form
	 * @return
	 */
	public int addBankcard(CodeTableForm form) {
		
		int iReturn = dbUtils.setInsert(form, "sbankcard", "");
		return iReturn;
	}
	/**
	 * 通过ID获取银行卡
	 * @param bankcardid
	 * @return
	 */
	public CodeTableForm getBankcardById(int bankcardid) {
		
		String sql = "SELECT a.*, func_getBanktypeName(a.banktype) banktypename,"
				+ " func_getStatusName(a.status) FROM sbankcard a WHERE a.bankcardid = '" + bankcardid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	/**
	 * 修改银行卡
	 * @param form
	 * @return
	 */
	public int ediBankcard(CodeTableForm form) {
		
		int iReturn = dbUtils.setUpdate(form, "", "sbankcard", "bankcardid", "");
		return iReturn;
	}
	/**
	 * 删除银行卡
	 * @param bankcardid
	 * @return
	 */
	public int deleteBankcard(int bankcardid) {
		
		String sql = "DELETE FROM sbankcard WHERE bankcardid = '" + bankcardid + "'";
		int iReturn = dbUtils.executeSQL(sql);
		return iReturn;
	}
}