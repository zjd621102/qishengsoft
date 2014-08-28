<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">其它收支</h1>
<form method="post" action="<%=path%>/bankcard/receandpay" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[bankcardid]" value="${form.map.bankcardid}" />
	<div class="pageFormContent" layoutH="97">
		<dl style="width: 100%;">
			<dt>发生日期：</dt>
			<dd style="width: 60%;">
				<input type="text" name="map[happendate]" size="30" class="required date" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
				<span class="info">yyyy-MM-dd</span>
			</dd>
		</dl>
		<dl>
			<dt>银行卡卡号：</dt>
			<dd>
				<input type="text" name="map[bankcardno]" size="30"
					 value="${form.map.bankcardno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>收支类型：</dt>
			<dd>
				<st:select dictType="收支类型" name="map[receandpaytype]" value="${form.map.receandpaytype}" expStr="style='width: 184px;'" />
			</dd>
		</dl>
		<dl>
			<dt>金额：</dt>
			<dd>
				<input type="text" name="map[money]" class="required number" size="30" maxlength="9"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" class="required" size="30" maxlength="512"/>
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