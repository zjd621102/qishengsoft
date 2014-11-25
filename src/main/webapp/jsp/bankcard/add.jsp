<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/bankcard/add" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>银行卡卡号：</dt>
				<dd>
					<input type="text" name="map[bankcardno]" class="required" size="25" maxlength="32"
						 value="${form.map.bankcardno}"/>
				</dd>
			</dl>
			<dl>
				<dt>开户银行名称：</dt>
				<dd>
					<input type="text" name="map[bankname]" class="required" size="25" maxlength="32"
						 value="${form.map.bankname}"/>
				</dd>
			</dl>
			<dl>
				<dt>账户名称：</dt>
				<dd>
					<input type="text" name="map[accountname]" class="required" size="25" maxlength="32"
						 value="${form.map.accountname}"/>
				</dd>
			</dl>
			<dl>
				<dt>银行卡类别：</dt>
				<dd>
					<st:select dictType="银行类型" name="map[banktype]" value="${form.map.banktype}" expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>金额：</dt>
				<dd>
					<input type="text" name="map[money]" class="required number" size="25" maxlength="12"
						 value="${form.map.money}"/>
				</dd>
			</dl>
			<dl>
				<dt>是否可用：</dt>
				<dd>
					<st:select dictType="状态" name="map[status]" value="1" expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>优先级：</dt>
				<dd>
					<input type="text" name="map[priority]" size="25" maxlength="2" value="9" />
				</dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<textarea name="map[remark]" cols="27" rows="6" maxlength="256">${form.map.remark}</textarea>
				</dd>
			</dl>
		</div>
		
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>