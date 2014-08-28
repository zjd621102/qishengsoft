<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">银行卡信息</h1>
<form method="post" action="<%=path%>/bankcard/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[bankcardid]" value="${form.map.bankcardid}" />
	<div class="pageFormContent" layoutH="88">
		<dl>
			<dt>银行卡卡号：</dt>
			<dd>
				<input type="text" name="map[bankcardno]" class="required" size="30" maxlength="32" alt="请输入银行卡卡号"
					 value="${form.map.bankcardno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>开户银行名称：</dt>
			<dd>
				<input type="text" name="map[bankname]" class="required" size="30" maxlength="32" alt="开户银行名称"
					 value="${form.map.bankname}"/>
			</dd>
		</dl>
		<dl>
			<dt>账户名称：</dt>
			<dd>
				<input type="text" name="map[accountname]" class="required" size="30" maxlength="32" alt="账户名称"
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
				<input type="text" name="map[money]" class="required number" size="30" maxlength="12" alt="金额"
					 value="${form.map.money}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>是否可用：</dt>
			<dd>
				<st:select dictType="状态" name="map[status]" value="${form.map.status}" expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>优先级：</dt>
			<dd>
				<input type="text" name="map[priority]" size="30" maxlength="2" value="${form.map.priority}" />
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<textarea name="map[remark]" cols="27" rows="5" maxlength="256">${form.map.remark}</textarea>
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