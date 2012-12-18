package com.yecoo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Test {
	
	public static void main(String[] args) throws Exception {
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/qishengsoft?user=root&password=a86211027");
		Statement statement = connection.createStatement();
		ResultSet resultSet = statement.executeQuery("select * from information_schema.COLUMNS where TABLE_NAME = upper('suser')");
		while (resultSet.next()) {
			System.out.print("字段名： " + resultSet.getString("column_name"));
			System.out.println(">>>字段类型： " + resultSet.getString("data_type"));
		}
//		resultSet = statement.executeQuery("SELECT COUNT(t.userid) count FROM suser t");
//		if (resultSet.next()) {
//			if ("".equals(StrUtils.nullToStr(resultSet.getString("count")))) {
//				System.out.println(resultSet.getString("count"));
//			}
//		}
		resultSet.close();
		statement.close();
		connection.close();
	}
}