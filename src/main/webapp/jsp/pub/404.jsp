<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>404 - 页面不存在</title>
</head>

<body>
	<div>
		<div>
			<h1>页面不存在.</h1>
		</div>
		<div>
			<a href="<%=path%>/index" target="_top">返回首页</a>
		</div>
	</div>
</body>
</html>