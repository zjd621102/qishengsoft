package com.yecoo.dao;

import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import sun.misc.BASE64Encoder;
/**
 * author	zhoujd
 * creadate	2012-3-2
 */
@SuppressWarnings("restriction")
public class BaseDao extends JdbcDaoSupport {
	/**
	 * 通过SQL语句获取列表
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryMapListBySql(String sql) throws Exception {
		List<Map<String, String>> list = this.getJdbcTemplate().query(sql.toString(), new RowMapper<Map<String, String>>() {
			public Map<String, String> mapRow(final ResultSet rs, final int arg1) throws SQLException {
				Map<String, String> form = null;
				try {
					form = getRowDataOfResultSet(rs);
				} catch (Exception e) {
					e.printStackTrace();
				}
				return form;
			}
		});
		return list;
	}
	/**
	 * 封装数据到Map
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getRowDataOfResultSet(ResultSet rs) throws Exception {
		ResultSetMetaData rsmd = rs.getMetaData();
		Map<String, String> map = new HashMap<String, String>();
		String colName = null;
		String colValue = null;
		/* 循环获取字段名和字段 */
		for (int i = 1; i <= rsmd.getColumnCount(); i++) {
			colName = rsmd.getColumnName(i).toUpperCase();
			if (colName.equalsIgnoreCase("rowno"))
				continue;
			switch (rsmd.getColumnType(i)) {
			case Types.DATE: // 对日期字段格式化
				Timestamp time = rs.getTimestamp(i);
				if (null != time) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					colValue = String.valueOf(sdf.format(time));
				} else
					colValue = "";
				break;
			case Types.TIMESTAMP: // 对日期字段格式化
				Timestamp timestamp = rs.getTimestamp(i);
				if (null != timestamp) {
					SimpleDateFormat sdf = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm:ss");
					colValue = String.valueOf(sdf.format(timestamp));
				} else
					colValue = "";
				break;
			case Types.BLOB: // 对BLOB字段进行BASE64编码
				Blob blob = rs.getBlob(i);
				if (null != blob) {
					byte[] bytes = blob.getBytes(1l, (int) blob.length());
					BASE64Encoder encoder = new BASE64Encoder();
					colValue = encoder.encode(bytes);
				} else {
					colValue = "";
				}
				break;
			default: // 其他字段直接取
				colValue = rs.getString(i);
				if (null == colValue)
					colValue = "";
			}
			map.put(colName, colValue);
		}
		return map;
	}
	/**
	 * 通过SQL语句获取记录数
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public int queryCountBySql(String sql) throws Exception {
		int rscount = this.getJdbcTemplate().queryForInt(sql);
		return rscount;
	}
}
