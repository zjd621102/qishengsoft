<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=path%>/loginDialog" class="pageForm required-validate"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<%-- 指定为ajax请求 --%>
		<input type="hidden" name="isDialog" value="true"/>
		<div class="pageFormContent" layoutH="54">
			<p>
				<label>用户账号：</label>
				<input type="text" class="required alphanumeric" minlength="4" maxlength="32" size="30" name="username" />
			</p>
			<p>
				<label>用户密码：</label>
				<input type="password" class="required" minlength="4" maxlength="32" size="30" name="password" />
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit">登录</button>
						</div>
					</div>
				</li>
				<!-- 
				<li>
					<div class="button">
						<div class="buttonContent">
							<button type="button" class="close">关闭</button>
						</div>
					</div>
				</li>
				-->
			</ul>
		</div>
	</form>
</div>