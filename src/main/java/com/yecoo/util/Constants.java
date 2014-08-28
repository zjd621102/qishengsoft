package com.yecoo.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 静态变量
 * @author zhoujd
 */
public class Constants {

	public final static String USER_INFO_SESSION = "userSessionInfo";// 保存在session的用户信息名称
	public final static String MENU_INFO_SESSION = "menuSessionInfo";// 保存在session的用户信息名称

	/**
	 * 分页信息
	 */
	public final static int NUMPERPAGE = 15;// 每页数量
	public final static int NUMPERPAGE_EXCEL = 1000;// 导出最大数量

	/**
	 * 操作
	 */
	public final static String OPERATION_SAVE = "save";// 新增
	public final static String OPERATION_EDIT = "edit";// 编辑
	public final static String OPERATION_VIEW = "view";// 查询
	public final static String OPERATION_DELETE = "delete";// 删除

	public static String dbName = "";// 数据库名
	
	static {
		InputStream in = null;
		try {
			String url = Constants.class.getResource("/").getPath() + "application.properties";
			in = new BufferedInputStream(new FileInputStream(url));
			Properties p = new Properties();
			p.load(in);
			dbName = p.getProperty("dbName");
		} catch (Exception e) {
			StrUtils.WriteLog(Constants.class.getName() + ".Constants()", e);
		} finally {
			if(in != null) {
				try {
					in.close();
				} catch (IOException e) {
					StrUtils.WriteLog(Constants.class.getName() + ".Constants()", e);
				}
			}
		}
	}
}