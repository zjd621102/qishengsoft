package com.yecoo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import com.yecoo.model.CodeTableForm;

/**
 * 公用数据库操作
 * @author zhoujd
 * @date   2012年8月28日 上午10:48:04
 */
public class DbUtils {

	/**
	 * 从数据库连接池中获取一个数据库连接
	 * @return Connection
	 */
	public Connection dbConnection() {
		Connection myConn = null;
		try {
			Class.forName("org.logicalcobwebs.proxool.ProxoolDriver");
			myConn = DriverManager.getConnection("proxool.dbname");
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".dbConnection()", e);
			this.closeConnection(null, null, myConn);
			myConn = null;
		}
		return myConn;
	}

	/**
	 * 从数据库连接池中获取一个数据库连接
	 * 
	 * @param sWebLogicDS
	 *            指定WebLogic数据源
	 * @param sCatDS
	 *            指定TomCat数据源
	 * @return 数据库连接
	 */
	public Connection dbConnection(String sWebLogicDS, String sCatDS) {
		Connection myConn = null;
		try {
			Context ctx = new InitialContext();
			if (ctx.getEnvironment().toString().indexOf("weblogic") > -1) {
				// 当前服务是weblogic
				javax.sql.DataSource ds = (javax.sql.DataSource) ctx
						.lookup(sWebLogicDS);
				myConn = ds.getConnection();
			} else {
				// 当前服务是Tomcat
				InitialContext jndiCntx = new InitialContext();
				ctx = (Context) jndiCntx.lookup("java:comp/env");
				javax.sql.DataSource ds = (javax.sql.DataSource) ctx
						.lookup(sWebLogicDS);
				myConn = ds.getConnection();
			}

		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".dbConnection()", e);
			myConn = null;
		}
		return myConn;
	}

	/**
	 * 返回一个ResultSet结果集
	 * 
	 * @param myConn
	 * @param Stmt
	 * @return creadate 2012-3-9
	 */
	public ResultSet getResult(PreparedStatement Stmt) {
		ResultSet rs;
		try {
			rs = Stmt.executeQuery();
		} catch (Exception e) {
			rs = null;
		}
		return rs;
	}

	/**
	 * 关闭连接
	 * 
	 * @param rs
	 * @param pStmt
	 * @param myConn
	 *            creadate 2012-3-9
	 */
	public void closeConnection(ResultSet rs, PreparedStatement pStmt, Connection myConn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pStmt != null) {
				pStmt.close();
			}
			if (myConn != null) {
				myConn.close();
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".closeConnection()",
					e);
		}
	}

	/**
	 * 关闭连接
	 * 
	 * @param rs
	 * @param stmt
	 * @param myConn
	 *            creadate 2012-3-9
	 */
	public void closeConnection(ResultSet rs, Statement stmt, Connection myConn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (myConn != null) {
				myConn.close();
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".closeConnection()",
					e);
		}
	}

	/**
	 * 执行一条SQL语句
	 * 
	 * @param myConn
	 * @param sql
	 * @return creadate 2012-3-9
	 */
	public int executeSQL(String sql) {
		int rstval = 0;
		Connection myConn = this.dbConnection();
		PreparedStatement Stmt = null;
		try {
			Stmt = myConn.prepareStatement(sql);
			rstval = Stmt.executeUpdate();
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".executeSQL()", e);
			rstval = -1;
		} finally {
			this.closeConnection(null, Stmt, myConn);
		}
		return rstval;
	}

	/**
	 * 执行一条SQL语句
	 * 
	 * @param myConn
	 * @param strSQL
	 * @return creadate 2012-3-9
	 */
	public int executeSQL(Connection myConn, String strSQL) {
		int rstval = 0;
		PreparedStatement Stmt = null;
		try {
			Stmt = myConn.prepareStatement(strSQL);
			rstval = Stmt.executeUpdate();
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".executeSQL()", e);
			rstval = -1;
		} finally {
			this.closeConnection(null, Stmt, null);
		}
		return rstval;
	}

	/**
	 * 执行带多个参数值的动态sql语句
	 * 
	 * @param sql
	 *            执行语句
	 * @param paramValue
	 *            参数值
	 * @creadate 2007-12-20
	 * @return int (rstval==-1?操作失败:操作成功)
	 */
	public int executeSQLByArrayParam(String sql, String[] paramValues) {
		int rstval = 0;
		Connection myConn = null;
		try {
			myConn = this.dbConnection();
			rstval = this.executeSQLByArrayParam(myConn, sql, paramValues);
		} catch (Exception e) {
			rstval = -1;
		} finally {
			this.closeConnection(null, null, myConn);
		}
		return rstval;
	}

	/**
	 * 执行带多个参数值的动态sql语句
	 * 
	 * @param myConn
	 * @param sql
	 *            执行语句
	 * @param paramValue
	 *            参数值
	 * @return int (rstval==-1?操作失败:操作成功)
	 * @creadate 2007-12-20
	 */
	public int executeSQLByArrayParam(Connection myConn, String sql,
			String[] paramValues) {
		int rstval = 0;
		PreparedStatement pStmt = null;
		try {
			pStmt = myConn.prepareStatement(sql);
			int len = paramValues.length;
			for (int i = 0; i < len; i++) {
				pStmt.setString(i + 1, paramValues[i]);
			}
			rstval = pStmt.executeUpdate();
		} catch (Exception e) {
			rstval = -1;
			StrUtils.WriteLog(this.getClass().getName()
					+ ".executeSQLByArrayParam()", "ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName()
					+ ".executeSQLByArrayParam()", e);
		} finally {
			this.closeConnection(null, pStmt, null);
		}
		return rstval;
	}

	/**
	 * 执行多条SQL语句
	 * 
	 * @param sqls
	 *            多条SQL语句
	 * @return int 语句执行影响的记录数，失败返回-1
	 */
	public int executeSQLs(String[] sqls) {
		Connection myConn = null;
		PreparedStatement pStmt = null;
		int rstval = 0;
		int i = 0;
		try {
			myConn = this.dbConnection();
			myConn.setAutoCommit(false);
			for (i = 0; i < sqls.length; i++) {
				if (pStmt != null) {
					try {
						pStmt.close();
					} catch (Exception ignore) {

					}
				}
				if ((sqls[i] != null) && (!sqls[i].equals(""))) {
					pStmt = myConn.prepareStatement(sqls[i]);
					rstval = pStmt.executeUpdate();
				}
			}
			myConn.commit();
		} catch (Exception e) {
			try {
				myConn.rollback();
				rstval = -1;
			} catch (Exception re) {

			}
		} finally {
			this.closeConnection(null, pStmt, myConn);
		}
		return rstval;
	}

	/**
	 * 执行多条SQL语句
	 * 
	 * @param sqls
	 *            多条SQL语句
	 * @return int 语句执行影响的记录数，失败返回-1
	 */
	public int executeSQLs(Connection myConn, String[] sqls) {
		PreparedStatement pStmt = null;
		int rstval = 0;
		int i = 0;
		try {
			for (i = 0; i < sqls.length; i++) {
				if (pStmt != null) {
					try {
						pStmt.close();
					} catch (Exception ignore) {

					}
				}
				if ((sqls[i] != null) && (!sqls[i].equals(""))) {
					pStmt = myConn.prepareStatement(sqls[i]);
					rstval = pStmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			try {
				rstval = -1;
			} catch (Exception re) {

			}
		} finally {
			this.closeConnection(null, pStmt, null);
		}
		return rstval;
	}

	/**
	 * 取年度列表（从2005年起到sYear2年度）
	 * 
	 * @param sYear1
	 *            开始年度，""值则默认为2005年
	 * @param sYear2
	 *            截至年度，""值则默认为本年
	 * @return List<SelectOptionForm>
	 * @creadate 2012-3-9
	 */
	public List<Map<String, String>> getYearList(String sYear1, String sYear2) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		// 系统使用起始年度 作为列表的起始年
		int iYear1 = 2005;
		// 列表截止年度，默认为本年
		Calendar calendar = Calendar.getInstance();
		int iYear2 = calendar.get(Calendar.YEAR);
		try {
			if (!sYear1.equals("")) {
				iYear1 = Integer.parseInt(sYear1);
			}
			if (!sYear2.equals("")) {
				iYear2 = Integer.parseInt(sYear2);
			}
			for (int i = iYear2; i >= iYear1; i--) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("selectValue", String.valueOf(i));
				map.put("selectName", String.valueOf(i) + "年");
				list.add(map);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getYearList()", e);
		}
		return list;
	}

	/**
	 * 获取第一个列值的接接串
	 * 
	 * @param sql
	 * @param separator
	 *            拼接时的分隔符
	 * @return 格式：123,223,333,334
	 */
	public String getStrJoinBySql(String sql, String separator) {
		Connection myConn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String str = "";
		try {
			myConn = this.dbConnection();
			stmt = myConn.createStatement(
					java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
					java.sql.ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				str += separator + rs.getString(1);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getStrJoinBySql()",
					e);
		} finally {
			this.closeConnection(rs, stmt, myConn);
		}
		return str.replaceFirst(separator, "");
	}

	/**
	 * 执行一条SELECT语句,获取第一条记录的第一个字段值
	 * 
	 * @param sql
	 * @return String
	 * @creadate 2012-3-9
	 */
	public String execQuerySQL(String sql) {
		ResultSet rs = null;
		PreparedStatement pStmt = null;
		Connection myConn = null;
		String rstStr = "";
		try {
			myConn = this.dbConnection();
			pStmt = myConn.prepareStatement(sql);
			rs = this.getResult(pStmt);
			if (rs.next()) {
				rstStr = StrUtils.nullToStr(rs.getString(1));
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".execQuerySQL()",
					"ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName() + ".execQuerySQL()", e);
		} finally {
			this.closeConnection(rs, pStmt, myConn);
		}
		return rstStr;
	}

	/**
	 * 执行一条SELECT语句,获取第一条记录的第一个字段值
	 * 
	 * @param myConn
	 * @param sql
	 * @return String
	 * @creadate 2012-3-9
	 */
	public String execQuerySQL(Connection myConn, String sql) {
		ResultSet rs = null;
		PreparedStatement pStmt = null;
		String rstStr = "";
		try {
			myConn = this.dbConnection();
			pStmt = myConn.prepareStatement(sql);
			rs = this.getResult(pStmt);
			if (rs.next()) {
				rstStr = StrUtils.nullToStr(rs.getString(1));
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".execQuerySQL()",
					"ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName() + ".execQuerySQL()", e);
		} finally {
			this.closeConnection(rs, pStmt, myConn);
		}
		return rstStr;
	}

	/**
	 * 执行一条SELECT语句，返回所有记录的第一个字段值（多值以splitStr分隔）
	 * 
	 * @param sql
	 * @param splitStr
	 * @return String
	 * @creadate 2012-3-9
	 */
	public String execQuerySQLReturnMulti(String sql, String splitStr) {
		ResultSet rs = null;
		PreparedStatement pStmt = null;
		Connection myConn = null;
		String rstStr = "";
		String sReturn = "";
		try {
			myConn = this.dbConnection();
			pStmt = myConn.prepareStatement(sql);
			rs = this.getResult(pStmt);
			while (rs.next()) {
				rstStr = StrUtils.nullToStr(rs.getString(1));
				if (!"".equals(sReturn)) {
					sReturn += splitStr + rstStr;
				} else {
					sReturn = rstStr;
				}
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName()
					+ ".execQuerySQLReturnMulti()", e);
		} finally {
			this.closeConnection(rs, pStmt, myConn);
		}
		return sReturn;
	}

	/**
	 * 获取列表
	 * 
	 * @param sql
	 * @return List<Object>
	 * @creadate 2012-3-9
	 */
	public List<CodeTableForm> getListBySql(String sql) {
		Connection myConn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CodeTableForm> list = new ArrayList<CodeTableForm>();
		try {
			myConn = this.dbConnection();
			stmt = myConn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rmeta = rs.getMetaData();
			while (rs.next()) {
				CodeTableForm form = new CodeTableForm();
				this.setFormRecord(form, rs, myConn, rmeta);
				list.add(form);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getListBySql()",
					"ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName() + ".getListBySql()", e);
		} finally {
			this.closeConnection(rs, stmt, myConn);
		}
		return list;
	}

	/**
	 * 设置form对象数据
	 * 
	 * @param form
	 * @param rs
	 * @param myConn
	 * @param rmeta
	 * @return CodeTableForm
	 */
	public CodeTableForm setFormRecord(CodeTableForm form, ResultSet rs,
			Connection myConn, ResultSetMetaData rmeta) {
		try {
			for (int icol = 1; icol <= rmeta.getColumnCount(); ++icol) {
				String cloumn = rmeta.getColumnName(icol).toLowerCase();
				if (rmeta.getColumnTypeName(icol).equals("DATE")) {
					form.setValue(cloumn,
							StrUtils.nullToStr(rs.getDate(cloumn)));
				} else {
					form.setValue(cloumn,
							StrUtils.nullToStr(rs.getString(cloumn)));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			StrUtils.WriteLog(this.getClass().getName() + ".setFormRecord()", e);
		} finally {

		}
		return form;
	}

	public CodeTableForm setFormRecord(CodeTableForm form, ResultSet rs) {
		try {
			ResultSetMetaData rmeta = rs.getMetaData();
			for (int icol = 1; icol <= rmeta.getColumnCount(); ++icol) {
				String cloumn = rmeta.getColumnName(icol).toLowerCase();
				if (rmeta.getColumnTypeName(icol).equals("DATE")) {
					form.setValue(cloumn,
							StrUtils.nullToStr(rs.getDate(cloumn)));
				} else {
					form.setValue(cloumn,
							StrUtils.nullToStr(rs.getString(cloumn)));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			StrUtils.WriteLog(this.getClass().getName() + ".setFormRecord()", e);
		} finally {

		}
		return form;
	}

	/**
	 * 根据sql语句获取一条记录
	 * 
	 * @param sql
	 * @return CodeTableForm
	 * @creadate 2012-3-9
	 */
	public CodeTableForm getFormBySql(String sql) {
		CodeTableForm form = null;
		Connection myConn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			myConn = this.dbConnection();
			stmt = myConn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rmeta = rs.getMetaData();
			if (rs.next()) {
				form = new CodeTableForm();
				this.setFormRecord(form, rs, myConn, rmeta);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getFormBySql()",
					"ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName() + ".getFormBySql()", e);
		} finally {
			this.closeConnection(rs, stmt, myConn);
		}
		return form;
	}

	/**
	 * 根据某一字段语句获取一条记录
	 * 
	 * @param sql
	 * @return CodeTableForm
	 * @creadate 2012-3-9
	 */
	public CodeTableForm getFormByColumn(String tabName, String key,
			String value) {
		CodeTableForm codeTableForm = null;
		Connection myConn = null;
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		StringBuffer sql = null;
		try {
			myConn = this.dbConnection();
			sql = new StringBuffer("SELECT * FROM ").append(tabName)
					.append(" WHERE ").append(key).append(" = '").append(value)
					.append("'");
			pStmt = myConn.prepareStatement(sql.toString());
			rs = pStmt.executeQuery();
			ResultSetMetaData rmeta = rs.getMetaData();
			if (rs.next()) {
				codeTableForm = new CodeTableForm();
				this.setFormRecord(codeTableForm, rs, myConn, rmeta);
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getFormByColumn()",
					"ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName() + ".getFormByColumn()",
					e);
		} finally {
			this.closeConnection(rs, pStmt, myConn);
		}
		return codeTableForm;
	}

	/**
	 * 获取第一列的整形的值(一般获取记录数)
	 * 
	 * @param sql
	 * @return int
	 * @creadate 2012-3-9
	 */
	public int getIntBySql(String sql) {
		Connection myConn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			myConn = this.dbConnection();
			stmt = myConn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				if (!"".equals(StrUtils.nullToStr(rs.getString(1)))) {
					count = Integer.parseInt(rs.getString(1));
				}
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getIntBySql()", e);
		} finally {
			this.closeConnection(rs, stmt, myConn);
		}
		return count;
	}

	/**
	 * 插入或者修改一条记录
	 * 
	 * @param sql
	 * @param param
	 * @return int
	 * @creadate 2012-3-12
	 */
	public int insertOrUpdate(String sql, Object[] param) {
		Connection myConn = null;
		PreparedStatement pStmt = null;
		try {
			myConn = this.dbConnection();
			pStmt = myConn.prepareStatement(sql, ResultSet.TYPE_FORWARD_ONLY,
					ResultSet.CONCUR_READ_ONLY);
			if (param != null) {
				for (int i = 0; i < param.length; i++) {
					pStmt.setObject(i + 1, param[i]);
				}
			}
			return pStmt.executeUpdate() >= 1 ? 1 : 0;
		} catch (Exception ex) {
			ex.printStackTrace();
			return 0;
		} finally {
			this.closeConnection(null, pStmt, myConn);
		}
	}

	/**
	 * 批量插入或者修改记录（事务回滚）
	 * 
	 * @param sqls
	 * @param params
	 * @return int
	 * @creadate 2012-3-12
	 */
	public int batchInsertOrUpdate(List<String> sqls, List<Object[]> params) {
		Connection conn = null;
		PreparedStatement ps = null;
		boolean isRollBack = false;
		try {
			conn = this.dbConnection();
			conn.setAutoCommit(false); // 事务开启
			for (int i = 0, len = sqls.size(); i < len; i++) {
				String sql = sqls.get(i);
				Object[] param = params.get(i);
				ps = conn.prepareStatement(sql,
						ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
				if (param != null) {
					for (int j = 0; j < param.length; j++) {
						ps.setObject(j + 1, param[j]);
					}
				}
				ps.executeUpdate();
			}
			return isRollBack ? 0 : 1;
		} catch (Exception ex) {
			ex.printStackTrace();
			isRollBack = true;
			return 0;
		} finally {
			try {
				if (isRollBack) {
					conn.rollback();
				} else {
					conn.commit();
				}
				this.closeConnection(null, ps, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	/**
	 * 批量插入或者修改记录（事务回滚）
	 * 
	 * @param sql
	 * @param params
	 * @return int
	 * @creadate 2012-3-12
	 */
	public int batchInsertOrUpdate(String sql, List<Object[]> params) {
		Connection conn = null;
		PreparedStatement ps = null;
		boolean isRollBack = false;
		try {
			conn = this.dbConnection();
			conn.setAutoCommit(false);// 事务开启
			ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			for (int i = 0, len = params.size(); i < len; i++) {
				Object[] param = params.get(i);
				if (param != null) {
					for (int pi = 0, plen = param.length; pi < plen; pi++) {
						ps.setObject(pi + 1, param[pi]);
					}
					ps.addBatch();// 加入batch
				}
			}
			int[] resultArray = ps.executeBatch();
			for (int myresult : resultArray) {
				if (myresult == 0) {
					isRollBack = true;
					break;
				}
			}
			return isRollBack ? 0 : 1;
		} catch (Exception ex) {
			ex.printStackTrace();
			isRollBack = true;
			return 0;
		} finally {
			try {
				if (isRollBack) {
					conn.rollback();
				} else {
					conn.commit();
				}
				this.closeConnection(null, ps, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	/**
	 * 插入表数据函数
	 * 
	 * @param myConn
	 *            传进的连接对象
	 * @param form
	 *            保存的表单
	 * @param tabName
	 *            要保存的表名
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setInsert(CodeTableForm form, String tabName) {
		return this.setInsert(form, tabName, "");
	}

	/**
	 * 插入表数据函数
	 * 
	 * @param myConn
	 *            传进的连接对象
	 * @param form
	 *            保存的表单
	 * @param tabName
	 *            要保存的表名
	 * @param num
	 *            要保存的行项代号，针对凭证的同名多行项的情况，保存一个表单的多笔带主从表的记录
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setInsert(CodeTableForm form, String tabName, String num) {
		Connection myConn = this.dbConnection();
		String sql = "SELECT COLUMN_NAME NAME, DATA_TYPE TYPE, COLUMN_DEFAULT FROM information_schema.COLUMNS"
				+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')";
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		String count = this.execQuerySQL(myConn, "SELECT COUNT(*) FROM information_schema.COLUMNS"
			+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')");
		String[] str = new String[Integer.parseInt(count) + 5];
		str[0] = "";
		str[1] = "";
		int iReturn = -1;

		String fieldname = "";
		String fieldvalue = "";
		try {
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();
			int i = 2;
			while (rs.next()) {
				String columnname = rs.getString("name").toLowerCase();
				if (form.getValue(columnname + num) != null) {
					str[0] = str[0] + columnname + ",";
					fieldname = fieldname + columnname + ",";
					String sColVal = StrUtils.nullToStr(form.getValue(columnname + num));
					if (rs.getString("type").equals("DATE")) {
						if (sColVal.length() == 19) {
							str[1] = str[1]
									+ "to_date(trim(?),'yyyy-mm-dd hh24:mi:ss'),";
							fieldvalue = fieldvalue + "to_date('" + sColVal
									+ "','yyyy-mm-dd hh24:mi:ss'),";
						} else {
							str[1] = str[1] + "to_date(trim(?),'yyyy-mm-dd'),";
							fieldvalue = fieldvalue + "to_date('" + sColVal
									+ "','yyyy-mm-dd'),";
						}
					} else {
						// str[0]=str[0]+columnname+",";
						str[1] = str[1] + "?,";
						fieldvalue = fieldvalue
								+ "'"
								+ StrUtils.nullToStr(form.getValue(columnname + num)) + "',";
					}
					str[i] = StrUtils.nullToStr(form.getValue(columnname + num));
					i = i + 1;
					str[i] = "#";
				}
			}
			if (!str[0].equals("")) {
				str[0] = str[0].substring(0, str[0].length() - 1);
				str[1] = str[1].substring(0, str[1].length() - 1);
				// 写普通SQL
				fieldname = fieldname.substring(0, fieldname.length() - 1);
				fieldvalue = fieldvalue.substring(0, fieldvalue.length() - 1);
			}
			pStmt.close();
			// 更新表记录
			String sql2 = "insert into  " + tabName + "(" + str[0]
					+ ") values(" + str[1] + ")";
			pStmt = myConn.prepareStatement(sql2);
			for (i = 2; i < str.length; i++) {
				pStmt.setString(i - 1, str[i]);
				if (i < str.length - 1
						&& StrUtils.nullToStr(str[i + 1]).equals("#")) {
					break;
				}
			}
			iReturn = pStmt.executeUpdate();
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".setInsert()", e);
		} finally {
			this.closeConnection(rs, pStmt, myConn);
		}
		return iReturn;
	}

	/**
	 * 插入表数据函数
	 * 
	 * @param myConn
	 *            传进的连接对象
	 * @param form
	 *            保存的表单
	 * @param tabName
	 *            要保存的表名
	 * @param num
	 *            要保存的行项代号，针对凭证的同名多行项的情况，保存一个表单的多笔带主从表的记录
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setInsert(Connection myConn, CodeTableForm form, String tabName,
			String num) {
		String sql = "SELECT COLUMN_NAME NAME, DATA_TYPE TYPE, COLUMN_DEFAULT FROM information_schema.COLUMNS"
				+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')";
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		String count = this.execQuerySQL(myConn, "SELECT COUNT(*) FROM information_schema.COLUMNS"
			+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')");
		String[] str = new String[Integer.parseInt(count) + 5];
		str[0] = "";
		str[1] = "";
		int iReturn = -1;

		String fieldname = "";
		String fieldvalue = "";
		try {
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();
			int i = 2;
			while (rs.next()) {
				String columnname = rs.getString("name").toLowerCase();
				if (form.getValue(columnname + num) != null) {
					if(form.getValue(columnname + num).equals("")) {
						form.setValue(columnname + num, null);
					}
					str[0] = str[0] + columnname + ",";
					fieldname = fieldname + columnname + ",";
					String sColVal = StrUtils.nullToStr((String) form
							.getValue(columnname + num));
					if (rs.getString("type").equals("DATE")) {
						if (sColVal.length() == 19) {
							str[1] = str[1]
									+ "to_date(trim(?),'yyyy-mm-dd hh24:mi:ss'),";
							fieldvalue = fieldvalue + "to_date('" + sColVal
									+ "','yyyy-mm-dd hh24:mi:ss'),";
						} else {
							str[1] = str[1] + "to_date(trim(?),'yyyy-mm-dd'),";
							fieldvalue = fieldvalue + "to_date('" + sColVal
									+ "','yyyy-mm-dd'),";
						}
					} else {
						// str[0]=str[0]+columnname+",";
						str[1] = str[1] + "?,";
						fieldvalue = fieldvalue
								+ "'"
								+ StrUtils.nullToStr((String) form
										.getValue(columnname + num)) + "',";
					}
					str[i] = (String) form.getValue(columnname + num);
					i = i + 1;
					str[i] = "#";
				}
			}
			if (!str[0].equals("")) {
				str[0] = str[0].substring(0, str[0].length() - 1);
				str[1] = str[1].substring(0, str[1].length() - 1);
				// 写普通SQL
				fieldname = fieldname.substring(0, fieldname.length() - 1);
				fieldvalue = fieldvalue.substring(0, fieldvalue.length() - 1);
			}
			pStmt.close();
			// 更新表记录
			String sql2 = "insert into  " + tabName + "(" + str[0]
					+ ") values(" + str[1] + ")";
			pStmt = myConn.prepareStatement(sql2);
			for (i = 2; i < str.length; i++) {
				pStmt.setString(i - 1, str[i]);
				if (i < str.length - 1
						&& StrUtils.nullToStr(str[i + 1]).equals("#")) {
					break;
				}
			}
			iReturn = pStmt.executeUpdate();
		} catch (Exception e) {
			iReturn = -1;
			StrUtils.WriteLog(this.getClass().getName() + ".setInsert()", e);
		} finally {
			this.closeConnection(rs, pStmt, null);
		}
		return iReturn;
	}

	/**
	 * 更新表数据
	 * 
	 * @param form
	 *            保存的表单
	 * @param tabName
	 *            要保存的表名
	 * @param num
	 *            要保存的行项代号，针对凭证的同名多行项的情况，保存一个表单的多笔带主从表的记录
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setUpdate(CodeTableForm form, String tabName, String key) {
		return this.setUpdate(form, "", tabName, key, "");
	}

	/**
	 * 更新表数据
	 * 
	 * @param form
	 *            保存的表单
	 * @param strEdit
	 *            编辑域 strEdit=1表示更新所有记录，否则，根据编辑域来更新记录
	 * @param tabName
	 *            要保存的表名
	 * @param key
	 *            要保存的主键
	 * @param num
	 *            要保存的行项代号，针对凭证的同名多行项的情况，保存一个表单的多笔带主从表的记录
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setUpdate(CodeTableForm form, String strEdit, String tabName,
			String key, String num) {
		Connection myConn = this.dbConnection();
		int iReturn = -1;
		try {
			iReturn = this.setUpdate(myConn, form, strEdit, tabName, key, num);
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".setUpdate()", e);
			iReturn = -1;
		} finally {
			this.closeConnection(null, null, myConn);
		}
		return iReturn;
	}

	/**
	 * 更新表数据函数
	 * 
	 * @param myConn
	 *            传进的连接对象
	 * @param form
	 *            保存的表单
	 * @param strEdit
	 *            编辑域 strEdit=1表示更新所有记录，否则，根据编辑域来更新记录
	 * @param tabName
	 *            要保存的表名
	 * @param key
	 *            要保存的主键
	 * @param num
	 *            要保存的行项代号，针对凭证的同名多行项的情况，保存一个表单的多笔带主从表的记录
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setUpdate(Connection myConn, CodeTableForm form, String strEdit,
			String tabName, String key, String num) {
		String sql = "SELECT COLUMN_NAME NAME, DATA_TYPE TYPE, COLUMN_DEFAULT FROM information_schema.COLUMNS"
				+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')";
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		String count = this.execQuerySQL(myConn, "SELECT COUNT(*) FROM information_schema.COLUMNS"
			+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')");
		String[] str = new String[Integer.parseInt(count) + 5];
		str[0] = "";
		int iReturn = -1;
		strEdit = "";// 目前先不控制更改的编辑
		String sGeneSQL = "";
		try {
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();
			int i = 1;
			while (rs.next()) {
				String columnname = rs.getString("name").toLowerCase();
				if (form.getValue(columnname + num) != null
						&& !form.getValue(columnname + num).equals("undefined")
						&& ((strEdit.indexOf(";" + columnname + ";") > -1)
								|| strEdit.equals("") || strEdit.equals("1"))) {
					if(form.getValue(columnname + num).equals("")) {
						form.setValue(columnname + num, null);
					}
					if (rs.getString("type").equals("DATE")) {
						str[0] = str[0] + columnname
								+ "=to_date(?,'yyyy-mm-dd'),";
						sGeneSQL = sGeneSQL
								+ columnname
								+ "=to_date('"
								+ StrUtils.nullToStr((String) form
										.getValue(columnname + num))
								+ "','yyyy-mm-dd'),";
					} else {
						str[0] = str[0] + columnname + "=?,";
						sGeneSQL = sGeneSQL
								+ columnname
								+ "='"
								+ StrUtils.nullToStr((String) form
										.getValue(columnname + num)) + "',";
					}
					str[i] = StrUtils.nullToStr((String) form
							.getValue(columnname + num));
					i = i + 1;
					str[i] = "#";
				}
			}
			if (!str[0].equals("")) {
				str[0] = str[0].substring(0, str[0].length() - 1);
				sGeneSQL = sGeneSQL.substring(0, sGeneSQL.length() - 1);
			}
			pStmt.close();
			// 更新表记录
			if (!str[0].equals("")) {
				String sql2 = "update " + tabName + " set " + str[0]
						+ " WHERE " + key + "='" + form.getValue(key + num)
						+ "'";
				sGeneSQL = "update " + tabName + " set " + sGeneSQL + " WHERE "
						+ key + "='" + form.getValue(key + num) + "'";
				pStmt = myConn.prepareStatement(sql2);
				for (i = 1; i < str.length; i++) {
					pStmt.setString(i, str[i]);
					if (i < str.length - 1
							&& StrUtils.nullToStr(str[i + 1]).equals("#")) {
						break;
					}
				}
				iReturn = pStmt.executeUpdate();
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".setUpdate()", e);
			iReturn = -1;
		} finally {
			this.closeConnection(rs, pStmt, null);
		}
		return iReturn;
	}

	/**
	 * 通过多个字段来更新数据表
	 * 
	 * @param form
	 * @param strEdit
	 * @param tabName
	 * @param keys
	 * @param num
	 * @return int
	 * @creadate 2012-3-22
	 */
	public int setUpdate(CodeTableForm form, String strEdit, String tabName,
			String[] keys, String num) {
		Connection myConn = this.dbConnection();
		String sql = "SELECT COLUMN_NAME NAME, DATA_TYPE TYPE, COLUMN_DEFAULT FROM information_schema.COLUMNS"
				+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')";
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		String count = this.execQuerySQL(myConn, "SELECT COUNT(*) FROM information_schema.COLUMNS"
			+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')");
		String[] str = new String[Integer.parseInt(count) + 5];
		str[0] = "";
		int iReturn = 1;
		strEdit = "";// 目前先不控制更改的编辑
		String sGeneSQL = "";
		try {
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();
			int i = 1;
			while (rs.next()) {
				String columnname = rs.getString("name").toLowerCase();
				if (form.getValue(columnname + num) != null
						&& ((strEdit.indexOf(";" + columnname + ";") > -1)
								|| strEdit.equals("") || strEdit.equals("1"))) {
					if(form.getValue(columnname + num).equals("")) {
						form.setValue(columnname + num, null);
					}
					if (rs.getString("type").equals("DATE")) {
						str[0] = str[0] + columnname
								+ "=to_date(?,'yyyy-mm-dd'),";
						sGeneSQL = sGeneSQL
								+ columnname
								+ "=to_date('"
								+ StrUtils.nullToStr((String) form
										.getValue(columnname + num))
								+ "','yyyy-mm-dd'),";

					} else {
						str[0] = str[0] + columnname + "=?,";
						sGeneSQL = sGeneSQL
								+ columnname
								+ "='"
								+ StrUtils.nullToStr((String) form
										.getValue(columnname + num)) + "',";
					}
					str[i] = StrUtils.nullToStr((String) form
							.getValue(columnname + num));
					i = i + 1;
					str[i] = "#";
				}
			}
			if (!str[0].equals("")) {
				str[0] = str[0].substring(0, str[0].length() - 1);
			}
			pStmt.close();
			// 更新表记录
			if (!str[0].equals("")) {
				String sql2 = "update " + tabName + " set " + str[0]
						+ " WHERE 1=1";
				for (i = 0; i < keys.length; i++) {
					sql2 += " and " + keys[i] + "='"
							+ form.getValue(keys[i] + num) + "'";
				}
				pStmt = myConn.prepareStatement(sql2);
				for (i = 1; i < str.length; i++) {
					pStmt.setString(i, str[i]);
					if (i < str.length - 1
							&& StrUtils.nullToStr(str[i + 1]).equals("#")) {
						break;
					}
				}
				iReturn = pStmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			StrUtils.WriteLog(this.getClass().getName() + ".setUpdate()", e);
			iReturn = -1;
		} finally {
			this.closeConnection(rs, pStmt, myConn);
		}
		return iReturn;
	}

	/**
	 * 更新表数据
	 * 
	 * @param form
	 *            保存的表单
	 * @param tabName
	 *            要保存的表名
	 * @param num
	 *            要保存的行项代号，针对凭证的同名多行项的情况，保存一个表单的多笔带主从表的记录
	 * @return 返回 >=0 表示有操作成功，-1 表示操作失败
	 */
	public int setInsertOrUpdate(CodeTableForm form, String tabName, String key) {
		int icount = this.getIntBySql("SELECT COUNT(1) FROM " + tabName
				+ " WHERE " + key + " = '" + form.getValue(key) + "'");
		if (icount == 0) {
			return this.setInsert(form, tabName);
		} else {
			return this.setUpdate(form, "", tabName, key, "");
		}
	}

	/**
	 * 删除数据
	 * 
	 * @param form
	 * @param tabName
	 * @param key
	 * @return int
	 * @creadate 2012-4-5
	 */
	public int setDelete(String id, String tabName, String key) {
		StringBuffer sql = null;
		int iReturn = 0;
		try {
			sql = new StringBuffer("DELETE FROM ").append(tabName)
					.append(" WHERE ").append(key).append(" = '").append(id)
					.append("'");
			iReturn = this.executeSQL(sql.toString());
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".setDelete()",
					"ERROR sql=" + sql);
			StrUtils.WriteLog(this.getClass().getName() + ".setDelete()", e);
		}
		return iReturn;
	}

	/**
	 * 保存行项表数据
	 * 
	 * @param request
	 * @param myConn
	 * @param form
	 * @param tabName
	 *            表名
	 * @param key
	 *            主键
	 * @param fKey
	 *            外键
	 * @param seq
	 *            序列器
	 * @param beginrow
	 *            开始行，一般为0
	 * @return
	 * @creadate 2012-3-31
	 */
	@SuppressWarnings("resource")
	public int saveRowTable(HttpServletRequest request, Connection myConn,
			CodeTableForm form, String tabName, String key, String fKey,
			String seq, int beginrow) {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		HashMap<String, String[]> map = new HashMap<String, String[]>();
		String sql = "SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '"
				+ Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')";
		String[] str = new String[this.getIntBySql(sql)];
		int iReturn = 0;

		try {
			String[] record = request.getParameterValues("map[" + key + "]");
			if (record == null) { // 无行项
				return 1;
			}
			int recordcount = record.length;
			// 取出要保存的表结构
			sql = "SELECT COLUMN_NAME NAME, DATA_TYPE TYPE, COLUMN_DEFAULT FROM information_schema.COLUMNS"
					+ " WHERE TABLE_SCHEMA = '" + Constants.dbName + "' AND TABLE_NAME = UPPER('" + tabName + "')";
			pStmt = myConn.prepareStatement(sql);
			rs = pStmt.executeQuery();
			int i = 0;
			while (rs.next()) {
				str[i] = rs.getString("name").toLowerCase();
				i = i + 1;
			}
			// 通过map对接收到的对象分别赋给表结构字段做映射
			for (i = 0; i < str.length; i++) {
				map.put(str[i],
						request.getParameterValues("map[" + str[i] + "]"));
			}
			Integer c = 3;
			Integer c_1 = 1;
			String[] serialnos = new String[recordcount];
			for (i = 1; i < recordcount; i++) {
				serialnos[i] = c + "." + c_1++;
			}
			map.put("serialno", serialnos);
			
			sql = "DELETE FROM " + tabName + " WHERE " + fKey + " = '" + form.getValue(fKey) + "'";
			iReturn = this.executeSQL(myConn, sql);

			for (i = beginrow; i < recordcount; i++) {
				CodeTableForm subform = new CodeTableForm();
				Iterator<String> iter = map.keySet().iterator();
				while (iter.hasNext()) {
					String vname = (String) iter.next();
					String[] vvalue = (String[]) map.get(vname);
					if (vvalue != null) {
						if (vvalue.length > 1) {// 只针对行项
							subform.setValue(vname, vvalue[i]);
						}
					}
				}
//				sql = "SELECT COUNT(*) as icount FROM " + tabName + " WHERE "
//						+ key + "='" + subform.getValue(key) + "'";
//				String sCount = this.execQuerySQL(sql);
//				if ("0".equals(sCount)) {
//					if (!"".equals(seq)) {
//						String keyvalue = this.execQuerySQL("SELECT " + seq
//								+ ".nextval FROM dual");
//						subform.setValue(key, keyvalue);
//					}
					subform.setValue(fKey, StrUtils.nullToStr(form.getValue(fKey)));
					subform.setValue(key, null);
					iReturn = this.setInsert(myConn, subform, tabName, "");
//				} else {
//					iReturn = this.setUpdate(myConn, subform, "1", tabName,
//							key, "");
//				}
				if (iReturn == -1) {
					throw new Exception();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			iReturn = -1;
			StrUtils.WriteLog(this.getClass().getName() + ".saveRowTable()", e);
		} finally {
			this.closeConnection(rs, pStmt, null);
		}
		return iReturn;
	}
}