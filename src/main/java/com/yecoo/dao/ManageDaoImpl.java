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
		
		String sql = "SELECT IFNULL(SUM(b.num * (b.realprice - IFNULL(c.costprice, 0))), 0) profit"
				+ " FROM bsell a INNER JOIN bsellrow b ON a.sellid = b.sellid"
				+ " LEFT JOIN sproduct c ON b.productid = c.productid"
				+ " WHERE 1 = 1" + dSQL;

		String iReturn = dbUtils.execQuerySQL(sql);
		
		return iReturn;
	}
	
	// 获取账户金额
	public double getZhje() {
		
		String sql = "SELECT parametervalue FROM cparameter t WHERE parametername = '账户金额'";
		double zhje = Double.valueOf(dbUtils.execQuerySQL(sql));
		
		return zhje;
	}
	
	// 单据已收款
	public double getDjysk() {
		
		String sql = "SELECT IFNULL(SUM(b.realsum), 0) FROM bpay t, bpayrow b WHERE 1 = 1 AND t.payid = b.payid AND t.currflow = '申请'";
		double djysk = Double.valueOf(dbUtils.execQuerySQL(sql));
		
		return djysk;
	}
	
	// 销售已收款
	public double getXsysk() {
		
		String sql = "SELECT IFNULL(SUM(t.paymentmade), 0) FROM bsell t WHERE 1 = 1 AND t.currflow = '发货'";
		double xsysk = Double.valueOf(dbUtils.execQuerySQL(sql));
		
		return xsysk;
	}
	
	// 采购已付款
	public double getCgyfk() {
		
		String sql = "SELECT IFNULL(SUM(t.paymentmade), 0) FROM bbuy t WHERE 1 = 1 AND t.currflow = '申请'";
		double cgyfk = Double.valueOf(dbUtils.execQuerySQL(sql));
		
		return cgyfk;
	}
	
}