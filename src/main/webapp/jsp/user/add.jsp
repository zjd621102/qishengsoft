<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<style>
.pageContent label {
	width: 80px;
}
</style>

<div class="pageContent">
	<form method="post" action="<%=path%>/user/add" class="pageForm required-validate"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="54">
			<p>
				<label>用户账号：</label>
				<input type="text" class="required alphanumeric" minlength="4" maxlength="32" size="30" name="map[userid]"
					alt="" />
			</p>
			<p>
				<label>用户姓名：</label>
				<input type="text" class="required" size="30" name="map[username]" al" />
			</p>
			<p>
				<label>用户密码：</label>
				<input type="text" class="required" minlength="4" maxlength="32" size="30" name="map[passwd]"
					value="888888" alt="" />
			</p>
			<p>
				<label>手机号码：</label>
				<input type="text" class="phone" size="30" name="map[tele]" />
			</p>
			<p>
				<label>是否客户：</label>
				<st:select dictType="是否" name="map[ismanu]" expStr="style='width: 212px;'" />
			</p>
			<p>
				<label>角&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
				<c:forEach items="${roleList}" var="role">
						<input type="checkbox" name="map[roleid]" value="${role.map.roleid}"
							 ${fn:contains(form.map.roleid,role.map.roleid) ? "checked=\"checked\"" : ""} />
						${role.map.rolename}
				</c:forEach>
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
				</li>
				<li>
					<div class="button">
						<div class="buttonContent">
							<button type="button" class="close">取消</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</form>
</div>