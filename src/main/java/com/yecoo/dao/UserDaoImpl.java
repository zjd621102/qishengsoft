package com.yecoo.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.Md5;
import com.yecoo.util.StrUtils;
/**
 * 用户管理
 * @author zhoujd
 */
public class UserDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 用户数量
	 * @param form
	 * @return
	 */
	public int getUserCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.userid) FROM suser t WHERE 1 = 1";
		String cond = getUserListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 用户列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getUserList(CodeTableForm form) {
		
		String sql = "SELECT * FROM suser t WHERE 1 = 1";
		String cond = getUserListCondition(form);
		sql  += cond;
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 用户列表-条件
	 * @param form
	 * @return
	 */
	public String getUserListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String username = StrUtils.nullToStr(form.getValue("username"));
		String roleid = StrUtils.nullToStr(form.getValue("roleid"));
		String fromBirthday = StrUtils.nullToStr(form.getValue("fromBirthday"));
		String toBirthday = StrUtils.nullToStr(form.getValue("toBirthday"));
		
		if(!username.equals("")) {
			cond.append(" AND t.username like '%").append(username).append("%'");
		}
		if(!roleid.equals("")) {
			cond.append(" AND t.roleid = '").append(roleid).append("'");
		}
		if(!fromBirthday.equals("")) {
			cond.append(" AND t.birthday >= '").append(fromBirthday).append("'");
		}
		if(!toBirthday.equals("")) {
			cond.append(" AND t.birthday <= '").append(toBirthday).append("'");
		}
		
		return cond.toString();
	}
	/**
	 * 获取用户信息
	 * @param userid
	 * @return
	 */
	public CodeTableForm getUserById(String userid) {
		
		String sql = "SELECT a.* FROM suser a WHERE a.userid = upper('" + userid + "')";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		sql = "SELECT t.roleid FROM suser_role t WHERE t.userid = '" + userid + "'";
		String roleid = dbUtils.execQuerySQLReturnMulti(sql, ";");
		if(!roleid.equals("")) {
			roleid = ";" + roleid + ";";
			codeTableForm.setValue("roleid", roleid);
		}
		return codeTableForm;
	}
	/**
	 * 新增用户
	 * @param form
	 * @return
	 */
	public int addUser(CodeTableForm form) {
		
		int iReturn = -1;
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false);
			
			//密码加密
			String passwd = StrUtils.nullToStr(form.getValue("passwd"));
			if(!passwd.equals("")) {
				Md5 md5 = new Md5();
				form.setValue("passwd", md5.md5(passwd));
			}
			
			iReturn = dbUtils.setInsert(conn, form, "suser", "");
			//插入用户角色表
			if(iReturn >= 0 && form.getValue("roleid")!=null) {
				if(form.getValue("roleid").toString().indexOf("@") == -1) { //只有一个角色
					String sql = "INSERT INTO suser_role(userid,roleid) VALUES ('"
							+ form.getValue("userid") + "','" + form.getValue("roleid") + "')";
					iReturn = dbUtils.executeSQL(conn, sql);
				} else {//多个角色
					String[] roleid = (String[])form.getValue("roleid");
					String[] sqls  = new String[roleid.length];
					for(int i = 0; i< sqls.length; i++) {
						sqls[i] = "INSERT INTO suser_role(userid,roleid) VALUES ('"
								+ form.getValue("userid") + "','" + roleid[i] + "')";
					}
					iReturn = dbUtils.executeSQLs(conn, sqls);
				}
			}
			
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
				iReturn = -1;
			} catch (SQLException e1) {

			}
			StrUtils.WriteLog(this.getClass().getName() + ".addUser()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

			}
		}
		return iReturn;
	}
	/**
	 * 修改用户
	 * @param form
	 * @return
	 */
	public int ediUser(CodeTableForm form) {
		
		int iReturn = -1;
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			conn.setAutoCommit(false);
			
			//密码加密
			String passwd = StrUtils.nullToStr(form.getValue("passwd"));
			if(!passwd.equals("")) {
				Md5 md5 = new Md5();
				form.setValue("passwd", md5.md5(passwd));
			}
			
			iReturn = dbUtils.setUpdate(conn, form, "", "suser", "userid", "");
			if(iReturn >= 0) {
				String sql = "DELETE FROM suser_role WHERE userid = '" + form.getValue("userid") + "'";
				iReturn = dbUtils.executeSQL(conn, sql);
				//插入用户角色表
				if(iReturn >= 0 && form.getValue("roleid")!=null) {
					if(form.getValue("roleid").toString().indexOf("@") == -1) {//只有一个角色
						sql = "INSERT INTO suser_role(userid,roleid) VALUES ('"
								+ form.getValue("userid") + "','" + form.getValue("roleid") + "')";
						iReturn = dbUtils.executeSQL(conn, sql);
					} else {//多个角色
						String[] roleid = (String[])form.getValue("roleid");
						String[] sqls  = new String[roleid.length];
						for(int i = 0; i< sqls.length; i++) {
							sqls[i] = "INSERT INTO suser_role(userid,roleid) VALUES ('"
									+ form.getValue("userid") + "','" + roleid[i] + "')";
						}
						iReturn = dbUtils.executeSQLs(conn, sqls);
					}
				}
			}
			
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
				iReturn = -1;
			} catch (SQLException e1) {
				iReturn = -1;
			}
			StrUtils.WriteLog(this.getClass().getName() + ".ediUser()", e);
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				iReturn = -1;
			}
		}
		return iReturn;
	}
	/**
	 * 删除用户
	 * @param userids
	 * @return
	 */
	public int deleteUsers(String userids) {
		
		String[] sqls = new String[2];
		sqls[0] = "DELETE FROM suser WHERE userid IN (" + userids + ")";
		sqls[1] = "DELETE FROM suser_role WHERE userid IN (" + userids + ")";
		return dbUtils.executeSQLs(sqls);
	}
	
	public int changePassword(CodeTableForm form) {
		
		//密码加密
		String passwd = StrUtils.nullToStr(form.getValue("passwd"));
		if(!passwd.equals("")) {
			Md5 md5 = new Md5();
			form.setValue("passwd", md5.md5(passwd));
		}
		
		int iReturn = dbUtils.setUpdate(form, "suser", "userid");
		return iReturn;
	}
}