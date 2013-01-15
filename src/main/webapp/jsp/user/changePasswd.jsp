<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=path%>/user/changePasswd" class="pageForm required-validate"
		onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[task]" value="changePasswd" />
		<input type="hidden" name="map[userid]" value="${userSessionInfo.map.userid}" />
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>原&nbsp;&nbsp;密&nbsp;&nbsp;码：</label>
				<input type="password" name="map[oldPasswd]" class="required" size="30" alt="请输入用户密码"/>
			</p>
			<p>
				<label>新&nbsp;&nbsp;密&nbsp;&nbsp;码：</label>
				<input type="password" name="map[passwd]" id="passwd" class="required" size="30" alt="请输入新密码"/>
			</p>
			<p>
				<label>确认密码：</label>
				<input type="password" name="map[rePasswd]" class="required" equalTo="#passwd"
					size="30" alt="请输入确认密码"/>
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
				</li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>