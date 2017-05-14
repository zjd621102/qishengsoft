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

public class SellDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取销售单数量
	 * @param form
	 * @return
	 */
	public int getSellCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM bsell t WHERE 1 = 1";
		String cond = getSellListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取销售单列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getSellList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getUserName(t.maker) makername, func_getManuName(t.manuid) manuname,"
				+ " func_getSum(t.sellid, 'XSD') allrealsum FROM bsell t WHERE 1 = 1";
		String cond = getSellListCondition(form);
		sql  += cond;
		sql += " ORDER BY t.currflow DESC, selldate DESC, createtime DESC";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取销售额
	 * @param form
	 * @return
	 */
	public String getSellSum(CodeTableForm form) {
		
		String sql = "SELECT IFNULL(SUM(b.realsum), 0) FROM bsell t, bsellrow b WHERE 1 = 1 AND t.sellid = b.sellid";
		String cond = getSellListCondition(form);
		sql  += cond;
		String sum = dbUtils.execQuerySQL(sql);
		return sum;
	}
	/**
	 * 获取销售单列表-条件
	 * @param form
	 * @return
	 */
	public String getSellListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String sellno = StrUtils.nullToStr(form.getValue("sellno"));
		String currflow = StrUtils.nullToStr(form.getValue("currflow"));
		String selldateFrom = StrUtils.nullToStr(form.getValue("selldateFrom"));
		String selldateTo = StrUtils.nullToStr(form.getValue("selldateTo"));
		String manuname = StrUtils.nullToStr(form.getValue("manuname"));
		String productno = StrUtils.nullToStr(form.getValue("productno"));
		String productname = StrUtils.nullToStr(form.getValue("productname"));
		String first = StrUtils.nullToStr(form.getValue("first"));
		
		if(!sellno.equals("")) {
			cond.append(" AND t.sellno like '%").append(sellno).append("%'");
		}
		if(!currflow.equals("")) {
			cond.append(" AND t.currflow = '").append(currflow).append("'");
		}
		if(!selldateFrom.equals("")) {
			cond.append(" AND t.selldate >= '").append(selldateFrom).append("'");
		}
		if(!selldateTo.equals("")) {
			cond.append(" AND t.selldate <= '").append(selldateTo).append("'");
		}
		if(!manuname.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM smanu m WHERE m.manuid = t.manuid AND m.manuname LIKE '%")
				.append(manuname).append("%')");
		}
		if(!productno.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM bsellrow n, sproduct o WHERE n.productid = o.productid")
				.append(" AND n.sellid = t.sellid AND o.productno LIKE '%").append(productno).append("%')");
		}
		if(!productname.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM bsellrow n WHERE n.sellid = t.sellid AND n.productname LIKE '%")
				.append(productname).append("%')");
		}
		if(first.equals("true")) {// 首次显示列表
			cond.append(" AND t.currflow IN ('申请', '发货')");
		}
		
		return cond.toString();
	}
	/**
	 * 新增销售单
	 * @param form
	 * @return
	 */
	public int addSell(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			String sellid = IdSingleton.getInstance().getNewId();
			form.setValue("sellid", sellid);
			
			iReturn = dbUtils.setInsert(conn, form, "bsell", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bsellrow", "sellrowid", "sellid", "", 1);
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
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			StrUtils.WriteLog(this.getClass().getName() + ".addSell()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 通过ID获取销售单
	 * @param sellid
	 * @return
	 */
	public CodeTableForm getSellById(int sellid, HttpServletRequest request) {
		
		String sql = "SELECT a.*, func_getUserName(a.maker) makername, func_getManuName(a.manuid) manuname"
				+ " FROM bsell a WHERE a.sellid = '" + sellid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT a.*, b.productno, func_getDictName('计量单位', a.unit) unitname,"
				+ " if(b.productno REGEXP '[A-Z]+1', '1', (if(b.productno REGEXP '[A-Z]+2', '2', '3'))) iscu, b.printname,"
				+ " (SELECT group_concat(c.productionshow) FROM sproductrow c"
				+ " WHERE c.productid = b.productid AND c.productionshow IS NOT NULL) productionshow,";
				
		String hidePrint = new ParameterDaoImpl().getParameterName("是否打印隐藏");
		if(hidePrint.equals("Y")) {// 打印隐藏
			sql += " SUBSTRING(a.productname, 1, LOCATE('(', a.productname)-1) productname2";
		} else {
			sql += " '' productname2";
		}
		
		String act = StrUtils.nullToStr(request.getParameter("act"));
		if(act.equals("printDo") || act.equals("printBox")) {// 生产单、打印箱子
			sql += ", c. ptprintname, (SELECT producttypename FROM sproducttype"
				+ " WHERE producttypeno = "
				+ "substring_index(substring_index(substring_index(productno,'1','1'), '2', '1'), '3', '1')) producttypename";
		}
		
		sql += " FROM bsellrow a LEFT JOIN sproduct b ON a.productid = b.productid"
				+ " LEFT JOIN sproducttype c ON c.producttypeno = "
				+ "substring_index(substring_index(substring_index(productno,'1','1'), '2', '1'), '3', '1')"
				+ " WHERE a.sellid = '"
				+ sellid + "' ORDER BY a.sort, c.priority, b.productno";
		List<CodeTableForm> sellrowList = dbUtils.getListBySql(sql);
		request.setAttribute("sellrowList", sellrowList);
		
		return codeTableForm;
	}
	/**
	 * 修改销售单
	 * @param form
	 * @return
	 */
	public int ediSell(CodeTableForm form, HttpServletRequest request) {
		
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
			
			iReturn = dbUtils.setUpdate(conn, form, "", "bsell", "sellid", ""); //保存主表，不做事务处理，否则表被锁定不能进行下面的操作
			if(iReturn >= 1) { //保存行项表
			  	iReturn = dbUtils.saveRowTable(request, conn, form, "bsellrow", "sellrowid", "sellid", "", 1);
			}
			
			String currflow = StrUtils.nullToStr(form.getValue("currflow"));
			if(iReturn >= 1 && currflow.equals("结束")) { //流程结束
				
				//计算库存
				StringBuffer sql = new StringBuffer("UPDATE smaterial m, (")
					.append("SELECT a.materialid, SUM(b.materialnum * d.num) sum FROM smaterial a, sproductrow b, sproduct c, bsellrow d")
					.append(" WHERE a.materialid = b.materialid AND b.productid = c.productid AND c.productid = d.productid")
					.append(" AND a.usestock = '1' AND d.sellid = '").append(form.getValue("sellid")).append("' GROUP BY a.materialid")
					.append(") n SET m.stock = (m.stock - n.sum) WHERE m.materialid = n.materialid");
				iReturn = dbUtils.executeSQL(conn, sql.toString());
				
				if(iReturn >= 0) {
					CodeTableForm user = (CodeTableForm)request.getSession().getAttribute(Constants.USER_INFO_SESSION);
					String maker = StrUtils.nullToStr(user.getValue("userid")); //当前登录用户
					String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss");
					String sellid = StrUtils.nullToStr(form.getValue("sellid"));
					
					String payid = IdSingleton.getInstance().getNewId();
					
					sql.delete(0, sql.length());
					sql.append("INSERT INTO bpay(payid, btype, maker, paydate, relateno, relatemoney,")
						.append(" currflow, createtime, manuid)	SELECT '").append(payid).append("', 'SKD', '")
						.append(maker).append("', selldate, sellno, func_getSum(sellid, 'XSD'), '申请', '").append(createdate)
						.append("', '").append(form.getValue("manuid")).append("' FROM bsell WHERE sellid = '")
						.append(sellid).append("'");
	
					iReturn = dbUtils.executeSQL(conn, sql.toString()); //直接保存，用于下面获取payid
					
					if(iReturn >= 1) { //生成收款单
						sql.delete(0,sql.length());
						sql.append("INSERT INTO bpayrow(payid, plansum, realsum)")
							.append(" SELECT ").append(payid).append(", func_getSum(t.sellid, 'XSD'), 0.00")
							.append(" FROM bsell t WHERE sellid = '").append(sellid).append("'");
						iReturn = dbUtils.executeSQL(conn, sql.toString());
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
			StrUtils.WriteLog(this.getClass().getName() + ".ediSell()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
	/**
	 * 删除销售单
	 * @param sellid
	 * @return
	 */
	public int deleteSell(int sellid) {

		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM bsell WHERE sellid = '" + sellid + "'";
		sqls[1] = "DELETE FROM bsellrow WHERE sellid = '" + sellid + "'";
		int iReturn = dbUtils.executeSQLs(sqls);
		return iReturn;
	}
	
	/**
	 * 通过销售单新增采购单
	 * @param sellid
	 * @return
	 */
	public int addBuy(CodeTableForm form, String maker) {
		int iReturn = -1;
		String sql = null;

		CodeTableForm buyForm = new CodeTableForm(); //采购单
		buyForm.setValue("btype", "CGD");
		buyForm.setValue("buyname", StrUtils.getSysdate("yyyy.MM.dd") + "采购");
		buyForm.setValue("buyno", StrUtils.getNewNO("CGD", "buyno", "bbuy"));
		buyForm.setValue("relateno", form.getValue("sellno"));
		buyForm.setValue("buydate", StrUtils.getSysdate());
		buyForm.setValue("currflow", "申请");
		buyForm.setValue("maker", maker);
		buyForm.setValue("alldiscount", "1");
		buyForm.setValue("createtime", StrUtils.getSysdatetime());

		String buyid = IdSingleton.getInstance().getNewId();
		buyForm.setValue("buyid", buyid);
		
		iReturn = dbUtils.setInsert(buyForm, "bbuy", ""); //保存主表
		
		if(iReturn >= 1) { //保存行项表
			sql = "INSERT INTO bbuyrow"
				+ " SELECT NULL, '" + buyid + "', n.materialid, n.materialname, n.unit, n.price, m.num, 1,"
				+ " n.price * m.num sum, o.manuid, o.manuname, o.manucontact, o.manutel, NULL, n.numofonebox, NULL FROM ("
				+ "SELECT a.materialid, SUM(b.materialnum * c.num) num"
				+ " FROM smaterial a, sproductrow b, bsellrow c WHERE a.materialid = b.materialid"
				+ " AND b.productid = c.productid AND c.sellid = '" + form.getValue("sellid") + "' GROUP BY a.materialid"
				+ ") m, smaterial n, smanu o WHERE m.materialid = n.materialid AND n.manuid = o.manuid"
				+ " AND (o.istobuy = '1' OR n.istobuy = '1')";
			iReturn = dbUtils.executeSQL(sql);
			if(iReturn == -1) { //保存失败，删除主表
				sql = "DELETE FROM bbuy WHERE buyid = '" + buyid + "'";
				dbUtils.execQuerySQL(sql);
			}
		}
		
		return iReturn;
	}
	
	/**
	 * 合并销售单
	 * 价格记忆失效
	 * @param sellids
	 * @return
	 */
	public int mergeSell(String sellids, String maker) {
		
		String sql = null;
		Connection conn = null;
		int iReturn = -1;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false); //事务开启
		
			String remark = "";
			/*
			sql = "SELECT remark FROM bsell t WHERE t.sellid IN (" + sellids + ")";
			String remark = dbUtils.getStrJoinBySql(sql, ",");
			if(!remark.equals("")) {
				remark = "合并销售单（" + remark + "）";
			}
			*/
			
			sql = "SELECT manuid FROM bsell t WHERE t.sellid IN (" + sellids + ")";
			String manuid = dbUtils.execQuerySQL(sql);
		
			CodeTableForm sellForm = new CodeTableForm(); //销售单
			sellForm.setValue("sellno", StrUtils.getNewNO("XSD", "sellno", "bsell"));
			sellForm.setValue("selldate", StrUtils.getSysdate());
			sellForm.setValue("manuid", manuid);
			sellForm.setValue("currflow", "申请");
			sellForm.setValue("maker", maker);
			sellForm.setValue("createtime", StrUtils.getSysdatetime());
			sellForm.setValue("remark", remark);

			String sellid = IdSingleton.getInstance().getNewId();
			sellForm.setValue("sellid", sellid);
			
			iReturn = dbUtils.setInsert(conn, sellForm, "bsell", ""); //保存主表
			
			if(iReturn >= 1) { //保存行项表
				sql = "INSERT INTO bsellrow"
					+ " SELECT NULL, '" + sellid + "', n.productid, n.productname, n.unit, n.costprice,"
					+ " n.realprice, n.realprice, m.num, m.boxnum, n.numofonebox,"
					+ " n.profit * m.num profit, n.realprice * m.num realsum, '5', NULL FROM ("
					+ "SELECT a.productid, SUM(a.num) num, SUM(a.boxnum) boxnum"
					+ " FROM bsellrow a WHERE a.sellid IN (" + sellids + ") GROUP BY a.productid"
					+ ") m, sproduct n WHERE m.productid = n.productid";
				
				// 非系统产品
				String sql2 = "INSERT INTO bsellrow (sellid, productname, realprice, num, boxnum, numofonebox,"
					+ " realsum, sort, remarkrow) SELECT " + sellid + ", productname, realprice, num, boxnum, numofonebox,"
					+ " realsum, sort, remarkrow FROM bsellrow a WHERE a.sellid IN (" + sellids
					+ ") AND a.productid IS NULL";
	
				String[] sqls = new String[4];
				sqls[0] = sql;
				sqls[1] = sql2;
				sqls[2] = "DELETE FROM bsell WHERE sellid IN (" + sellids + ")";
				sqls[3] = "DELETE FROM bsellrow WHERE sellid IN (" + sellids + ")";
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
			StrUtils.WriteLog(this.getClass().getName() + ".mergeSell()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				
			}
		}
		
		return iReturn;
	}
}