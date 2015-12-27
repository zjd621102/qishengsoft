package com.yecoo.dao;

import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
/**
 * 系统参数管理
 * @author zhoujd
 */
public class ParameterDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 系统参数数量
	 * @param form
	 * @return
	 */
	public int getParameterCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(t.parameterid) FROM cparameter t WHERE 1 = 1";
		String cond = getParameterListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 系统参数列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getParameterList(CodeTableForm form) {
		
		String sql = "SELECT * FROM cparameter t WHERE 1 = 1";
		String cond = getParameterListCondition(form);
		sql  += cond;
		sql += " ORDER BY createtime";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 系统参数列表-条件
	 * @param form
	 * @return
	 */
	public String getParameterListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String parametername = StrUtils.nullToStr(form.getValue("parametername"));
		String parametervalue = StrUtils.nullToStr(form.getValue("parametervalue"));
		
		if(!parametername.equals("")) {
			cond.append(" AND t.parametername like '%").append(parametername).append("%'");
		}
		if(!parametervalue.equals("")) {
			cond.append(" AND t.parametervalue like '%").append(parametervalue).append("%'");
		}
		
		return cond.toString();
	}
	/**
	 * 获取系统参数信息
	 * @param parameterid
	 * @return
	 */
	public CodeTableForm getParameterById(int parameterid) {
		
		String sql = "SELECT a.* FROM cparameter a WHERE a.parameterid = upper('"
				+ parameterid + "')";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		
		return codeTableForm;
	}
	/**
	 * 新增系统参数
	 * @param form
	 * @return
	 */
	public int addParameter(CodeTableForm form) {
		
		int iReturn = dbUtils.setInsert(form, "cparameter", "");
		return iReturn;
	}
	/**
	 * 修改系统参数
	 * @param form
	 * @return
	 */
	public int ediParameter(CodeTableForm form) {

		int iReturn = dbUtils.setUpdate(form, "", "cparameter", "parameterid", "");
		return iReturn;
	}
	/**
	 * 删除系统参数
	 * @param parameterids
	 * @return
	 */
	public int deleteParameter(int parameterid) {
		
		String sql = "DELETE FROM cparameter WHERE parameterid = '" + parameterid + "'";
		int iReturn = dbUtils.executeSQL(sql);
		return iReturn;
	}
	
	public String getParameterName(String parametername) {
		
		String sql = "SELECT parametervalue FROM cparameter t WHERE t.parametername = '" + parametername + "'";
		String parameterValue = dbUtils.execQuerySQL(sql);
		return parameterValue;
	}
}