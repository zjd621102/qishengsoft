package com.yecoo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Test {
	/*
	public static void main(String[] args) throws Exception {
		Test test = new Test();
		test.test1();

	}
	
	public void test2() throws Exception {
		Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost/qishengsoft?user=root&password=888888");
		myConn.setAutoCommit(false);
		PreparedStatement pStmt = null;
//		String sql = "insert into suser values ('888888','888888','888888','888888','1','888888')";
		String sql = "delete from suser where userid = '888888'";
		pStmt = myConn.prepareStatement(sql);
		int iReturn = pStmt.executeUpdate();
		myConn.rollback();
		System.out.println(iReturn);
	}
	
	public void test1() throws Exception {
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/qishengsoft?user=root&password=888888");
		Statement statement = connection.createStatement();
		ResultSet resultSet = statement.executeQuery("select * from information_schema.COLUMNS where TABLE_NAME = upper('suser')");
		while (resultSet.next()) {
			System.out.print("columnName: " + resultSet.getString("column_name"));
			System.out.println(">>>columnType: " + resultSet.getString("data_type"));
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
	}*/
}