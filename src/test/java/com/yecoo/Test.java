package com.yecoo;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import com.yecoo.util.StrUtils;

public class Test {
	
	public String getUrl() {
		String url = this.getClass().getResource("/").getPath() + "../classes/message.properties";
		String sqliteUrl = "";
		InputStream in;
		System.out.println(url);
		try {
			in = new BufferedInputStream(new FileInputStream(url));
			Properties p = new Properties();
			p.load(in);
			sqliteUrl = p.getProperty("sqliteUrl");
			in.close();
		} catch (Exception e) {
			StrUtils.WriteLog(this.getClass().getName() + ".getSqliteUrl()", e);
		}
		return sqliteUrl;
	}
	
	public static void main(String[] args) throws Exception {
		Test test = new Test();
		String sqliteUrl = test.getUrl();
		
		Class.forName("org.sqlite.JDBC");
		Connection connection = DriverManager.getConnection(sqliteUrl);
		System.out.println(sqliteUrl);
		Statement statement = connection.createStatement();
		ResultSet resultSet = statement.executeQuery("PRAGMA table_info('SUSER')");
//		while (resultSet.next()) {
//			System.out.print("字段名： " + resultSet.getString("name"));
//			System.out.println(">>>字段类型： " + resultSet.getString("type"));
//		}
		resultSet = statement.executeQuery("SELECT COUNT(t.userid) count FROM suser t");
		if (resultSet.next()) {
//			if ("".equals(StrUtils.nullToStr(resultSet.getString("count")))) {
				System.out.println(resultSet.getString("count"));
//			}
		}
		resultSet.close();
		statement.close();
		connection.close();
	}
}