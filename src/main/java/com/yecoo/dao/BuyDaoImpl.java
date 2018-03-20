package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.IdSingleton;
import com.yecoo.util.StrUtils;

public class BuyDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取采购单数量
	 * @param form
	 * @return
	 */
	public int getBuyCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM bbuy t WHERE 1 = 1";
		String cond = getBuyListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取采购单列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getBuyList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getUserName(t.maker) makername, func_getDictName('单据类型', t.btype) btypename,"
				+ " func_getSum(t.buyid, 'CGD') allsum FROM bbuy t WHERE 1 = 1";
		String cond = getBuyListCondition(form);
		sql  += cond;
		sql += " ORDER BY t.buydate DESC, t.buyid DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取采购额
	 * @param form
	 * @return
	 */
	public String getBuySum(CodeTableForm form) {
		
		String sql = "SELECT IFNULL(SUM(b.sum), 0) FROM bbuy t, bbuyrow b WHERE 1 = 1 AND t.buyid = b.buyid";
		String cond = getBuyListCondition(form);
		sql  += cond;
		String sum = dbUtils.execQuerySQL(sql);
		return sum;
	}
	/**
	 * 获取采购单列表-条件
	 * @param form
	 * @return
	 */
	public String getBuyListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String buyname = StrUtils.nullToStr(form.getValue("buyname"));
		String buyno = StrUtils.nullToStr(form.getValue("buyno"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		String btype = StrUtils.nullToStr(form.getValue("btype"));
		String buydateFrom = StrUtils.nullToStr(form.getValue("buydateFrom"));
		String buydateTo = StrUtils.nullToStr(form.getValue("buydateTo"));
		String manuname = StrUtils.nullToStr(form.getValue("manuname"));
		String materialno = StrUtils.nullToStr(form.getValue("materialno"));
		String materialname = StrUtils.nullToStr(form.getValue("materialname"));
		
		if(!buyname.equals("")) {
			cond.append(" AND t.buyname like '%").append(buyname).append("%'");
		}
		if(!buyno.equals("")) {
			cond.append(" AND t.buyno like '%").append(buyno).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		if(!btype.equals("")) {
			cond.append(" AND t.btype = '").append(btype).append("'");
		}
		if(!buydateFrom.equals("")) {
			cond.append(" AND t.buydate >= '").append(buydateFrom).append("'");
		}
		if(!buydateTo.equals("")) {
			cond.append(" AND t.buydate <= '").append(buydateTo).append("'");
		}
		if(!manuname.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM smanu m, smaterial n, bbuyrow o")
				.append(" WHERE m.manuid = n.manuid AND n.materialid = o.materialid")
				.append(" AND o.buyid = t.buyid AND m.manuname LIKE '%").append(manuname).append("%')");
		}
		if(!materialno.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM smaterial m, bbuyrow n WHERE m.materialid = n.materialid")
				.append(" AND n.buyid = t.buyid AND m.materialno LIKE '%").append(materialno).append("%')");
		}
		if(!materialname.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM bbuyrow n WHERE n.buyid = t.buyid AND n.materialname LIKE '%")
				.append(materialname).append("%')");
		}
		
		return cond.toString();
	}
	/**
	 * 新增采购单
	 * @param form
	 * @return
	 */
	public int addBuy(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			String buyid = IdSingleton.getInstance().getNewId();
			form.setValue("buyid", buyid);
			
			iReturn = dbUtils.setInsert(conn, form, "bbuy", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bbuyrow", "buyrowid", "buyid", "", 1);
			}
			
			if(iReturn >= 0) {
				conn.commit();
			} else {
				conn.rollback();
				iReturn = -1;
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				if(conn != null && !conn.isClosed()) {
					conn.rollback();
				}
			} catch (SQLException e1) {
				
			}
			StrUtils.WriteLog(this.getClass().getName() + ".addBuy()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取采购单
	 * @param buyid
	 * @return
	 */
	public CodeTableForm getBuyById(int buyid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getUserName(a.maker) makername, func_getDictName('单据类型', a.btype) btypename"
				+ " FROM bbuy a WHERE a.buyid = '" + buyid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);

		sql = "SELECT a.*, b.materialno, c.manucou, truncate(c.manusum, 1) manusum, e.address"
				+ " FROM bbuyrow a LEFT JOIN smaterial b ON a.materialid = b.materialid"
				+ " LEFT JOIN (SELECT DISTINCT d.manuid, COUNT(1) manucou, SUM(d.sum) manusum FROM bbuyrow d "
				+ " WHERE d.buyid = '" + buyid
				+ "' GROUP BY d.manuid) c ON (a.manuid = c.manuid OR (a.manuid IS NULL AND c.manuid IS NULL))"
				+ " LEFT JOIN smanu e ON b.manuid = e.manuid"
				+ " WHERE a.buyid = '" + buyid
				+ "' ORDER BY a.sort, a.manuid, b.materialid";
		
		List<CodeTableForm> buyrowList = dbUtils.getListBySql(sql);
		request.setAttribute("buyrowList", buyrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改采购单
	 * @param form
	 * @return
	 */
	public int ediBuy(CodeTableForm form, HttpServletRequest request) {

		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(conn, form, "", "bbuy", "buyid", ""); //保存主表
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bbuyrow", "buyrowid", "buyid", "", 1);
			}
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				//计算库存
				StringBuffer sql = new StringBuffer("UPDATE smaterial m, bbuyrow n SET m.stock = (m.stock + n.num)")
					.append(" WHERE m.materialid = n.materialid AND m.usestock = '1' AND n.buyid = '")
					.append(form.getValue("buyid")).append("'");
				iReturn = dbUtils.executeSQL(conn, sql.toString());
				
				if(iReturn >= 1) {// 生成付款单
					CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
					String maker = StrUtils.nullToStr(user.getValue("userid")); //当前登录用户
					String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss");
					String buyid = StrUtils.nullToStr(form.getValue("buyid"));

					sql.delete(0, sql.length());
					sql.append("SELECT b.manuid FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.buyid = '")
						.append(buyid).append("' GROUP BY b.manuid");
					List<CodeTableForm> manuidList = dbUtils.getListBySql(sql.toString());
					// 根据供应商新增付款单
					for(CodeTableForm manuid2Form : manuidList) {
					
						String payid = IdSingleton.getInstance().getNewId();
						
						sql.delete(0, sql.length());
						sql.append("INSERT INTO bpay(manuid, payid, btype, maker, paydate, relateno, relatemoney,")
							.append(" currflow, createtime)	SELECT b.manuid, '").append(payid).append("', 'FKD', '").append(maker)
							.append("', a.buydate, a.buyno, SUM(b.sum), '申请', '").append(createdate)
							.append("' FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.buyid = '")
							.append(buyid).append("' AND b.manuid = '" + manuid2Form.getValue("manuid") + "'");
		
						iReturn = dbUtils.executeSQL(conn, sql.toString()); //直接保存，用于下面获取payid
						
						if(iReturn >= 0) {
							sql.delete(0,sql.length());
							sql.append("INSERT INTO bpayrow(payid, manuid, plansum, realsum)")
								.append(" SELECT ").append(payid).append(", t.manuid,")
								.append(" t.sum, 0")
								.append(" FROM (SELECT manuid, SUM(sum) sum FROM bbuyrow WHERE buyid = '").append(buyid)
								.append("' AND manuid = '" + manuid2Form.getValue("manuid") + "') t");
							iReturn = dbUtils.executeSQL(conn, sql.toString());
						} else {
							break;
						}
					}
				}
			}
			
			if(iReturn >= 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediBuy()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除采购单
	 * @param buyid
	 * @return
	 */
	public int deleteBuy(int buyid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM bbuy WHERE buyid = '" + buyid + "'";
		sqls[1] = "DELETE FROM bbuyrow WHERE buyid = '" + buyid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
	
	/**
	 * 合并采购单
	 * @param buyids
	 * @return
	 */
	public int mergeBuy(String buyids, String maker) {
		
		String sql = null;
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启

			String remark = "";
			/*			
			sql = "SELECT relateno FROM bbuy t WHERE t.buyid IN (" + buyids + ")";
			String remark = dbUtils.getStrJoinBySql(sql, ",");
			if(remark.equals("")) {
				remark = "合并采购单";
			} else {
				remark = "合并采购单（" + remark + "）";
			}
			 */
			CodeTableForm buyForm = new CodeTableForm(); //采购单
			buyForm.setValue("btype", "CGD");
			buyForm.setValue("buyname", StrUtils.getSysdate("yyyy.MM.dd") + "采购");
			buyForm.setValue("buyno", StrUtils.getNewNO("CGD", "buyno", "bbuy"));
			buyForm.setValue("buydate", StrUtils.getSysdate());
			buyForm.setValue("currflow", "申请");
			buyForm.setValue("maker", maker);
			buyForm.setValue("createtime", StrUtils.getSysdatetime());
			buyForm.setValue("alldiscount", "1");
			buyForm.setValue("remark", remark);

			String buyid = IdSingleton.getInstance().getNewId();
			buyForm.setValue("buyid", buyid);
			
			iReturn = dbUtils.setInsert(conn, buyForm, "bbuy", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
				sql = "INSERT INTO bbuyrow"
					+ " SELECT NULL, '" + buyid + "', n.materialid, n.materialname, n.unit, n.price, m.num, 1,"
					+ " n.price * m.num sum, o.manuid, o.manuname, o.manucontact, o.manutel, NULL, n.numofonebox, NULL FROM ("
					+ "SELECT a.materialid, SUM(a.num) num FROM bbuyrow a WHERE a.buyid IN (" + buyids
					+ ") GROUP BY a.materialid"
					+ ") m, smaterial n, smanu o WHERE m.materialid = n.materialid AND n.manuid = o.manuid";
	
				String[] sqls = new String[3];
				sqls[0] = sql;
				sqls[1] = "DELETE FROM bbuy WHERE buyid IN (" + buyids + ")";
				sqls[2] = "DELETE FROM bbuyrow WHERE buyid IN (" + buyids + ")";
				iReturn = dbUtils.executeSQLs(conn, sqls);
			}
			
			if(iReturn >= 1) {
				conn.commit();
			} else {
				conn.rollback();
				iReturn = -1;
			}
		} catch(Exception e) {
			iReturn = -1;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
			}
			StrUtils.WriteLog(this.getClass().getName() + ".mergeBuy()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	
	/**
	 * 获取采购待付数量
	 * @param form
	 * @return
	 */
	public int getToPayCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM (SELECT 1 FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.currflow = '待付'";
		String cond = getToPayCondition(form);
		sql  += cond;
		sql += " GROUP BY b.manuid) k";
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	
	/**
	 * 获取待付列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getToPayList(CodeTableForm form) {
		
		String sql = "SELECT o.*, k.sum FROM (SELECT b.manuid, SUM(b.sum) sum"
				+ " FROM bbuy a, bbuyrow b WHERE a.buyid = b.buyid AND a.currflow = '待付'";
		String cond = getToPayCondition(form);
		sql  += cond;
		sql += " GROUP BY b.manuid ORDER BY SUM(b.sum) DESC) k, smanu o WHERE k.manuid = o.manuid";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	
	/**
	 * 获取待付条件
	 * @param form
	 * @return
	 */
	public String getToPayCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String buydateFrom = StrUtils.nullToStr(form.getValue("buydateFrom"));
		String buydateTo = StrUtils.nullToStr(form.getValue("buydateTo"));
		String manuname = StrUtils.nullToStr(form.getValue("manuname"));
		
		if(!buydateFrom.equals("")) {
			cond.append(" AND a.buydate >= '").append(buydateFrom).append("'");
		}
		if(!buydateTo.equals("")) {
			cond.append(" AND a.buydate <= '").append(buydateTo).append("'");
		}
		if(!manuname.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM smanu m WHERE m.manuid = b.manuid AND m.manuname LIKE '%")
				.append(manuname).append("%')");
		}
		
		return cond.toString();
	}
}