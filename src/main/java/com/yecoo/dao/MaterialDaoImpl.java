package com.yecoo.dao;

import java.util.List;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

public class MaterialDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取所有物资
	 * @return
	 */
	public List<CodeTableForm> getMaterialList() {
		
		String sql = "SELECT t.* FROM smaterial t ORDER BY materialid";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取物资数量
	 * @param form
	 * @return
	 */
	public int getMaterialCount(CodeTableForm form) {
		
		String sql = "SELECT COUNT(1) FROM smaterial t WHERE 1 = 1";
		String cond = getMaterialListCondition(form);
		sql  += cond;
		int count = dbUtils.getIntBySql(sql);
		return count;
	}
	/**
	 * 获取物资列表
	 * @param form
	 * @param pageNum
	 * @param numPerPage
	 * @return
	 */
	public List<CodeTableForm> getMaterialList(CodeTableForm form) {
		
		String sql = "SELECT t.*, func_getMaterialtypeName(t.materialtype) materialtypename,"
				+ " func_getDictName('计量单位', t.unit) unitname, sm.manuname, sm.manucontact, sm.manutel"
				+" FROM smaterial t LEFT JOIN smanu sm on t.manuid = sm.manuid WHERE 1 = 1";
		String cond = getMaterialListCondition(form);
		sql  += cond;
		sql += " ORDER BY materialid";
		sql += " LIMIT " + (pageNum-1)*numPerPage + "," + numPerPage;
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	/**
	 * 获取物资列表-条件
	 * @param form
	 * @return
	 */
	public String getMaterialListCondition(CodeTableForm form) {
		
		StringBuffer cond = new StringBuffer("");
		String materialno = StrUtils.nullToStr(form.getValue("materialno"));
		String materialname = StrUtils.nullToStr(form.getValue("materialname"));
		String materialtype = StrUtils.nullToStr(form.getValue("materialtype"));

		if(!materialno.equals("")) {
			cond.append(" AND t.materialno like '%").append(materialno).append("%'");
		}
		if(!materialname.equals("")) {
			cond.append(" AND t.materialname like '%").append(materialname).append("%'");
		}
		if(!materialtype.equals("")) {
			cond.append(" AND EXISTS (SELECT 1 FROM smaterialtype m WHERE m.materialtype = t.materialtype AND CONCAT('-', m.materialtypeall, '-') LIKE '%-").append(materialtype).append("-%')");
		}
		
		return cond.toString();
	}
	/**
	 * 新增物资
	 * @param form
	 * @return
	 */
	public int addMaterial(CodeTableForm form) {
		
		int iReturn = dbUtils.setInsert(form, "smaterial", "");
		return iReturn;
	}
	/**
	 * 通过ID获取物资
	 * @param materialid
	 * @return
	 */
	public CodeTableForm getMaterialById(int materialid) {
		
		String sql = "SELECT a.*, func_getMaterialtypeName(a.materialtype) materialtypename,"
				+ " func_getDictName('计量单位', a.unit) unitname, func_getManuName(a.manuid) manuname"
				+ " FROM smaterial a WHERE a.materialid = '" + materialid + "'";
		CodeTableForm codeTableForm = dbUtils.getFormBySql(sql);
		return codeTableForm;
	}
	/**
	 * 修改物资
	 * @param form
	 * @return
	 */
	public int ediMaterial(CodeTableForm form) {
		
		int iReturn = dbUtils.setUpdate(form, "smaterial", "materialid");
		return iReturn;
	}
	/**
	 * 删除物资
	 * @param materialid
	 * @return
	 */
	public int deleteMaterial(int materialid) {
		
		String sql = "DELETE FROM smaterial WHERE materialid = '" + materialid + "'";
		int iReturn = dbUtils.executeSQL(sql);
		return iReturn;
	}
	
	/**
	 * 获取物资树
	 * @param form
	 * @param path		项目路径
	 * @param curTime	当前时间HHmmss
	 * @return
	 */
	public String tree(CodeTableForm form, String path, String curTime) {
		if (form.getValue("childrenList")==null || ((List<CodeTableForm>) form.getValue("childrenList")).isEmpty()) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul>" + "\n");
		for (Object obj : (List) form.getValue("childrenList")) {
			CodeTableForm o = (CodeTableForm) obj;
			buffer.append("<li><a href=\"" + path + "/material/list/"
					+ o.getValue("materialtype")
					+ "?curTime=" + curTime + "\" target=\"ajax\" rel=\"jbsxBox2material" + curTime + "\">"
					+ o.getValue("materialtypename") + "</a>" + "\n");
			buffer.append(tree(o, path, curTime));
			buffer.append("</li>" + "\n");
		}
		buffer.append("</ul>" + "\n");
		return buffer.toString();
	}
}