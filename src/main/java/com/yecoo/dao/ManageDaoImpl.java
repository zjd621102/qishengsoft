package com.yecoo.dao;

import com.yecoo.util.DbUtils;
/**
 * 管理管理
 * @author zhoujd
 */
public class ManageDaoImpl extends BaseDaoImpl {

	DbUtils dbUtils = new DbUtils();
	
	/**
	 * 获取利润
	 * @param form
	 * @param request
	 */
	public String getProfit(String sellno, String currflow, String selldateFrom, String selldateTo, String sellDate) {

		String dSQL = "";
		
		if(!sellno.equals("")) {
			dSQL += " AND a.sellno = '" + sellno + "'";
		}
		if(!currflow.equals("")) {
			dSQL += " AND a.currflow = '" + currflow + "'";
		}
		if(!selldateFrom.equals("")) {
			dSQL += " AND a.selldate >= '" + selldateFrom + "'";
		}
		if(!selldateTo.equals("")) {
			dSQL += " AND a.selldate <= '" + selldateTo + "'";
		}
		if(!sellDate.equals("")) {
			dSQL += " AND a.selldate LIKE '" + sellDate + "%'";
		}
		
		String sql = "SELECT SUM(b.num * (b.realprice - IFNULL(c.costprice, 0))) profit"
				+ " FROM bsell a INNER JOIN bsellrow b ON a.sellid = b.sellid"
				+ " LEFT JOIN sproduct c ON b.productid = c.productid"
				+ " WHERE 1 = 1" + dSQL;

		String iReturn = dbUtils.execQuerySQL(sql);
		
		return iReturn;
	}
}