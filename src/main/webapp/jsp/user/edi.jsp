<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
%>
<div class="pageContent">
	<form method="post" action="<%=path%>/user/edi" class="pageForm required-validate"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>用户账号：</label>
				<input type="text" class="required alphanumeric" readonly="readonly" minlength="4" maxlength="32" size="30"
				 name="map[userid]" value="${form.map.userid}" />
			</p>
			<p>
				<label>用户姓名：</label>
				<input type="text" class="required" size="30" name="map[username]" value="${form.map.username}"
				 alt="请输入用户姓名"/>
			</p>
			<p>
				<label>用户密码：</label>
				<input type="text" class="required" minlength="4" maxlength="32" size="30" name="map[passwd]"
				 value="${form.map.passwd}" alt="请输入用户密码"/>
			</p>
			<p>
				<label>手机号码：</label>
				<input type="text" class="phone" size="30" name="map[tele]" value="${form.map.tele}" />
			</p>
			<p>
				<label>出生日期：</label>
				<input type="text" class="date" size="30" name="map[birthday]" value="${form.map.birthday}"  />
				<a class="inputDateButton" href="javascript:;">选择</a>
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive">
						<div class="buttonContent"><button type="submit">保存</button></div>
					</div>
				</li>
				<li>
					<div class="button">
						<div class="buttonContent"><button type="button" class="close">取消</button></div>
					</div>
				</li>
			</ul>
		</div>
	</form>
</div>