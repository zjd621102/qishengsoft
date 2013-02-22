<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">修改银行卡</h1>
<form method="post" action="<%=path%>/bankcard/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[bankcardid]" value="${form.map.bankcardid}" />
	<div class="pageFormContent" layoutH="97">
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
				<select name="map[banktype]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${banktypeList}" var="banktype">
						<option value="${banktype.map.banktypeid}"
							${banktype.map.banktypeid==form.map.banktype?"selected":""}
						>
							${banktype.map.banktypename}
						</option>
					</c:forEach>
				</select>
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
				<select name="map[status]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${statusList}" var="status">
						<option value="${status.map.statusid}"
							${status.map.statusid==form.map.status?"selected":""}
						>
							${status.map.statusname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="30" maxlength="256" value="${form.map.remark}" />
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