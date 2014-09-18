<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/bankcard/transferAccount" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
	 	<input type="hidden" name="map[bankcardid]" value="${form.map.bankcardid}" />
		<div class="pageFormContent" layoutH="56">
			<dl>
				<dt>银行卡卡号：</dt>
				<dd>
					<input type="text" name="map[bankcardno]" size="25"
						 value="${form.map.bankcardno}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>开户银行名称：</dt>
				<dd>
					<input type="text" name="map[bankname]" size="25"
						 value="${form.map.bankname}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>账户名称：</dt>
				<dd>
					<input type="text" name="map[accountname]" size="25"
						 value="${form.map.accountname}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>银行卡类别：</dt>
				<dd>
					<input type="text" name="map[banktypename]" size="25"
						 value="${form.map.banktypename}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>金额：</dt>
				<dd>
					<input type="text" name="map[money]" size="25"
						 value="${form.map.money}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<input type="text" name="map[remark]" size="25" value="${form.map.remark}"
						readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>转入账号：</dt>
				<dd>
					<select name="map[transferbankcardid]" style="width: 184px;" class="required">
						<option value=""></option>
						<c:forEach items="${allBankcardList}" var="bankcard">
							<option value="${bankcard.map.bankcardid}">
								${bankcard.map.bankcardno}|${bankcard.map.bankname}
							</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>转入金额：</dt>
				<dd>
					<input type="text" name="map[transfermoney]" class="required number" size="25" maxlength="12"
						 value="${form.map.transferMoney}"/>
				</dd>
			</dl>
			<dl>
				<dt>转入备注：</dt>
				<dd>
					<textarea name="map[transferremark]" cols="27" rows="6" maxlength="256" class="required"></textarea>
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