package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class BankcardDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();

	/**
	 * 获取所有银行卡
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getAllBankcardList(CodeTableForm form) {
		
		String sql = "SELECT t.* FROM sbankcard t WHERE t.status = 1";
		String bankcardid = StrUtils.nullToStr(form.getValue("bankcardid"));
		if(!bankcardid.equals("")) {
			sql += " AND t.bankcardid <> '" + bankcardid + "'";
		}
		sql += " ORDER BY t.priority ASC, t.bankcardid ASC";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
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
	public List<CodeTableForm> getBankcardList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getDictName('银行类型', t.banktype) banktypename,"
				+ " func_getDictName('状态', t.status) statusname FROM sbankcard t WHERE 1 = 1";
		String cond = getBankcardListCondition(form);
		sql  += cond;
		sql += " ORDER BY t.priority ASC, t.bankcardid ASC";
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
		String status = StrUtils.nullToStr(form.getValue("status"));
		
		if(!bankcardno.equals("")) {
			cond.append(" AND t.bankcardno like '%").append(bankcardno).append("%'");
		}
		if(!status.equals("")) {
			cond.append(" AND t.status = '").append(status).append("'");
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
		
		String sql = "SELECT a.*, func_getDictName('银行类型', a.banktype) banktypename,"
				+ " func_getDictName('状态', a.status) FROM sbankcard a WHERE a.bankcardid = '" + bankcardid + "'";
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
	/**
	 * 内部银行卡转账
	 * @param bankcardid
	 * @return
	 */
	public int transferAccount(CodeTableForm form) {
		int iReturn = -1;
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false);//事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "btransferaccount", "");
			
			if(iReturn >= 1) {
				String fromBankcardid = StrUtils.nullToStr(form.getValue("bankcardid"));
				String toBankcardid = StrUtils.nullToStr(form.getValue("transferbankcardid"));
				double transfermoney = Double.parseDouble(StrUtils.nullToStr(form.getValue("transfermoney")));
				
				int changeid = StrUtils.getMaxId("btransferaccount", "transferaccountid") + 1;
				
				String[] sqls = new String[2];
				sqls[0] = "UPDATE sbankcard t SET t.money = t.money - " + transfermoney
						+ ", changetype = 'btransferaccount', changeid = '" + changeid + "'"
						+ " WHERE t.bankcardid = '" + fromBankcardid + "'";
				sqls[1] = "UPDATE sbankcard t SET t.money = t.money + " + transfermoney
						+ ", changetype = 'btransferaccount', changeid = '" + changeid + "'"
						+ " WHERE t.bankcardid = '" + toBankcardid + "'";
				iReturn =  dbUtils.executeSQLs(conn, sqls);
			}
			if(iReturn >= 1) {
				conn.commit();
			} else {
				conn.rollback();
				iReturn = -1;
			}
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {

			}
			iReturn = -1;
			StrUtils.WriteLog(this.getClass().getName() + ".transferAccount()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

			}
		}
		return iReturn;
	}
	/**
	 * 获取转账列表数量
	 * @param form
	 * @return
	 */
	public int getTransferaccountCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM btransferaccount t WHERE 1 = 1";
		String cond = getTransferaccountListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取转账列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getTransferaccountList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getBankcardno(t.bankcardid) bankcardno,"
			+ " func_getBankcardno(t.transferbankcardid) transferbankcardno,"
			+ " IFNULL(a.oldmoney, '') fromoldmoney, IFNULL(a.newmoney, '') fromnewmoney,"
			+ " IFNULL(b.oldmoney, '') tooldmoney, IFNULL(b.newmoney, '') tonewmoney"
			+ " FROM btransferaccount t"
			+ " LEFT JOIN sbankcard_log a ON a.changeid = t.transferaccountid"
			+ " AND a.changetype = 'btransferaccount' AND a.bankcardid = t.bankcardid"
			+ " LEFT JOIN sbankcard_log b ON b.changeid = t.transferaccountid"
			+ " AND b.changetype = 'btransferaccount' AND b.bankcardid = t.transferbankcardid"
			+ " WHERE 1 = 1";
		String cond = getTransferaccountListCondition(form);
		sql += cond;
		sql += " ORDER BY t.createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取转账列表-条件
	 * @param form
	 * @return
	 */
	public String getTransferaccountListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String bankcardno = StrUtils.nullToStr(form.getValue("bankcardno"));
		String transferbankcardno = StrUtils.nullToStr(form.getValue("transferbankcardno"));
		
		if(!bankcardno.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM sbankcard a WHERE a.bankcardid = t.bankcardid AND a.bankcardno like '%")
				.append(bankcardno).append("%')");
		}
		if(!transferbankcardno.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM sbankcard a WHERE a.bankcardid = t.transferbankcardid")
				.append(" AND a.bankcardno like '%").append(transferbankcardno).append("%')");
		}
		
		return cond.toString();
	}
	/**
	 * 其它收支管理
	 * @param bankcardid
	 * @return
	 */
	public int receandpay(CodeTableForm form) {
		int iReturn = -1;
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false);//事务开启
			
			iReturn = dbUtils.setInsert(conn, form, "breceandpay", "");
			
			if(iReturn >= 1) {
				String bankcardid = StrUtils.nullToStr(form.getValue("bankcardid"));
				String receandpaytype = StrUtils.nullToStr(form.getValue("receandpaytype"));
				double money = Double.parseDouble(StrUtils.nullToStr(form.getValue("money")));
				
				int changeid = StrUtils.getMaxId("breceandpay", "receandpay") + 1;
				
				String sql = "";
				if(receandpaytype.equals("1")) {
					sql = "UPDATE sbankcard t SET t.money = t.money + " + money
						+ ", changetype = 'breceandpay', changeid = '" + changeid + "'"
						+ " WHERE t.bankcardid = '" + bankcardid + "'";
					iReturn =  dbUtils.executeSQL(conn, sql);
				} else if(receandpaytype.equals("2")) {
					sql = "UPDATE sbankcard t SET t.money = t.money - " + money
						+ ", changetype = 'breceandpay', changeid = '" + changeid + "'"
						+ " WHERE t.bankcardid = '" + bankcardid + "'";
					iReturn =  dbUtils.executeSQL(conn, sql);
				} else {
					iReturn = -1;
				}
			}
			if(iReturn >= 1) {
				conn.commit();
			} else {
				conn.rollback();
				iReturn = -1;
			}
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {

			}
			iReturn = -1;
			StrUtils.WriteLog(this.getClass().getName() + ".receandpay()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

			}
		}
		return iReturn;
	}
	/**
	 * 其它收支列表数量
	 * @param form
	 * @return
	 */
	public int getReceandpayCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM breceandpay t WHERE 1 = 1";
		String cond = getReceandpayListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 其它收支列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getReceandpayList(CodeTableForm form) {
		
		String sql = "SELECT t.*, t.money*if(t.receandpaytype='1', 1, -1) changemoney, func_getBankcardno(t.bankcardid) bankcardno,"
			+ " func_getDictName('收支类型', t.receandpaytype) receandpaytypename,"
			+ " a.oldmoney, a.newmoney FROM breceandpay t"
			+ " LEFT JOIN sbankcard_log a ON t.receandpay = a.changeid AND t.bankcardid = a.bankcardid"
			+ " AND a.changetype = 'breceandpay' WHERE 1 = 1";
		String cond = getReceandpayListCondition(form);
		sql += cond;
		sql += " ORDER BY t.createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 其它收支列表-条件
	 * @param form
	 * @return
	 */
	public String getReceandpayListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String bankcardno = StrUtils.nullToStr(form.getValue("bankcardno"));
		String receandpaytype = StrUtils.nullToStr(form.getValue("receandpaytype"));
		
		if(!bankcardno.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM sbankcard a WHERE a.bankcardid = t.bankcardid AND a.bankcardno like '%")
				.append(bankcardno).append("%')");
		}
		if(!receandpaytype.equals("")) {
			cond.append(" AND t.receandpaytype = '").append(receandpaytype).append("'");
		}
		return cond.toString();
	}
	/**
	 * 交易列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getTransactionList(CodeTableForm form) {
		
		String sql = "SELECT b.bankcardno, b.realsum*if(a.btype='SKD', 1, -1) realsum, a.paydate, a.payid, a.relateno,"
				+ " func_getDictName('单据类型', a.btype) btypename, c.oldmoney, c.newmoney"
				+ " FROM bpay a, bpayrow b LEFT JOIN sbankcard_log c ON b.payrowid = c.changeid"
				+ " AND EXISTS (SELECT 1 FROM sbankcard d WHERE d.bankcardid = c.bankcardid AND d.bankcardno = b.bankcardno)"
				+ " WHERE a.payid = b.payid AND a.currflow = '结束'";
		String cond = getTransactionListCondition(form);
		sql += cond;
		sql += " ORDER BY a.operatetime DESC, a.paydate DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 交易列表-条件
	 * @param form
	 * @return
	 */
	public String getTransactionListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String bankcardno = StrUtils.nullToStr(form.getValue("bankcardno"));
		String btype = StrUtils.nullToStr(form.getValue("btype"));
		String payid = StrUtils.nullToStr(form.getValue("payid"));
		String paydateFrom = StrUtils.nullToStr(form.getValue("paydateFrom"));
		String paydateTo = StrUtils.nullToStr(form.getValue("paydateTo"));
		
		if(!bankcardno.equals("")) {
			cond.append(" AND b.bankcardno LIKE '%").append(bankcardno).append("%'");
		}
		if(!btype.equals("")) {
			cond.append(" AND a.btype = '").append(btype).append("'");
		}
		if(!payid.equals("")) {
			cond.append(" AND a.payid = '").append(payid).append("'");
		}
		if(!paydateFrom.equals("")) {
			cond.append(" AND a.paydate >= '").append(paydateFrom).append("'");
		}
		if(!paydateTo.equals("")) {
			cond.append(" AND a.paydate <= '").append(paydateTo).append("'");
		}
		return cond.toString();
	}
}