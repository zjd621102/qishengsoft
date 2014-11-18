package com.yecoo.util;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * 获取Id单例
 * 
 * @author zhoujd
 * @date 2014年11月18日 上午11:15:54
 */
public class IdSingleton {

	private volatile static IdSingleton instance = null;

	private IdSingleton() {

	}

	public static synchronized IdSingleton getInstance() {
		// 先检查实例是否存在，如果不存在才进入下面的同步块
		if (instance == null) {
			// 同步块，线程安全的创建实例
			synchronized (IdSingleton.class) {
				// 再次检查实例是否存在，如果不存在才真正的创建实例
				if (instance == null) {
					instance = new IdSingleton();
				}
			}
		}
		return instance;
	}

	/**
	 * 获取新ID
	 * @return
	 */
	public String getNewId() {
		
		int id = -1;
		DbUtils dbUtils = new DbUtils();
		Connection conn = null;
		try {
			conn = dbUtils.dbConnection();
			String sql = "UPDATE cseq SET seq = LAST_INSERT_ID(seq+1)";
			int iReturn = dbUtils.executeSQL(conn, sql);
			if (iReturn >= 1) {
				sql = "SELECT last_insert_id() seq";
				id = Integer.parseInt(dbUtils.execQuerySQL(conn, sql));
			}
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getNewId()", e);
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					
				}
			}
		}

		return String.valueOf(id);
	}
}