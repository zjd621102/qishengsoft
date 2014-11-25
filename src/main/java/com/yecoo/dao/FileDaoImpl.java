package com.yecoo.dao;

import java.io.File;
import java.util.List;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
/**
 * 附件管理DAO
 * @author zhoujd
 * @date   2014年11月24日 下午2:58:51
 */
public class FileDaoImpl extends BaseDaoImpl {

	private DbUtils dbUtils = new DbUtils();
	/**
	 * 获取附件列表
	 * @param pid	所属单据ID
	 * @param btype	附件类型
	 * @return
	 */
	public List<CodeTableForm> getFileList(int pid, String btypes) {
		
		String sql = "SELECT t.* FROM sfile t WHERE t.pid = '" + pid + "'";
		if(!btypes.equals("")) {
			sql += " AND t.btype IN (" + btypes + ")";
		}
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		return list;
	}
	
	/**
	 * 删除附件
	 * @param fileid
	 * @param filePath
	 * @return
	 */
	public int delFile(int fileid, String filePath) {
		int iRes = -1;
		
		CodeTableForm form = dbUtils.getFormByColumn("sfile", "fileid", String.valueOf(fileid));

		String sql = "DELETE FROM sfile WHERE fileid = '" + fileid + "'";
		iRes = dbUtils.executeSQL(sql);
		
		if(iRes >= 1) {
			String fileFullPath = filePath + fileid + "." + form.getValue("suffix");
			File file = new File(fileFullPath);
			if (file.exists()) {
				file.delete();
			}
		}
		
		return iRes;
	}
}