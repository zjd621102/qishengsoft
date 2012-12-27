<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	response.setStatus(200);
//alertMsg.error("用户权限不足。");
%>
{"statusCode":"403", "message":"用户权限不足。", "navTabId":"", "forwardUrl":"", "callbackType":"closeCurrent"}