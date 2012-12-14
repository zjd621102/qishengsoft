<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>增加用户</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=path%>/js/calendar.js">
		</script>
	</head>
	<body>
		<form action="<%=path%>/user/add" method="post">
			用户编号：<input type="text" name="map[userid]"><br />
			用户姓名：<input type="text" name="map[username]"><br />
			用户密码：<input type="password" name="map[passwd]"><br />
			手机号码：<input type="text" name="map[tele]"><br />
			出生日期：<input type="text" name="map[birthday]" onClick="calendar()"><br />
			用户部门：
			<select name="map[deptid]">
				<option value=""></option>
				<c:forEach items="${deptList}" var="dept">
					<option value="${dept.map.deptid}">
						${dept.map.deptname}
					</option>
				</c:forEach>
			</select>
			<input type="submit" value="提交">
		</form>
	</body>
</html>