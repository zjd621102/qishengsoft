package com.yecoo.dao;

import java.util.List;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class UserDaoImpl {

	private DbUtils dbUtils = new DbUtils();

	public int getUserCount(CodeTableForm form) {
		String sql = "SELECT COUNT(t.userid) FROM suser t WHERE 1 = 1";
		String cond = getUserListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}

	public List<CodeTableForm> getUserList(CodeTableForm form, int pageNum, int numPerPage) {
		String sql = "SELECT * FROM suser t WHERE 1 = 1";
		String cond = getUserListCondition(form);
		sql  += cond;
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	
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

	public CodeTableForm getUserById(String userid) {
		String sql = "SELECT a.* FROM suser a WHERE a.userid = upper('" + userid + "')";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}

	public int addUser(CodeTableForm form) {
		return dbUtils.setInsert(form, "suser");
	}

	public int updateUser(CodeTableForm form) {
		return dbUtils.setUpdate(form, "suser", "userid");
	}

	public int deleteUsers(String userids) {
		String sql = "DELETE FROM suser WHERE userid IN (" + userids + ")";
		return dbUtils.executeSQL(sql);
	}
}
