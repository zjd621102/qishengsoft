<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">银行卡信息</h1>
<form method="post" action="<%=path%>/bankcard/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="88">
		<dl>
			<dt>银行卡卡号：</dt>
			<dd>
				<input type="text" name="map[bankcardno]" class="required" size="30" maxlength="32" alt="请输入银行卡卡号"
					 value="${form.map.bankcardno}"/>
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
					 value="${form.map.money}"/>
			</dd>
		</dl>
		<dl>
			<dt>是否可用：</dt>
			<dd>
				<select name="map[status]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${statusList}" var="status">
						<option value="${status.map.statusid}"
							${status.map.statusid==1?"selected":""}
						>
							${status.map.statusname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>优先级：</dt>
			<dd>
				<input type="text" name="map[priority]" size="30" maxlength="2" value="9" />
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