package com.yecoo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Test {
	
	public static void main(String[] args) throws Exception {
		Class.forName("org.sqlite.JDBC");
		Connection connection = DriverManager.getConnection("jdbc:sqlite:src/main/webapp/resources/erpsoft.s3db");
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