<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<form method="post" action="<%=path%>/company/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[companyid]" value="${form.map.companyid}"/>
	<div class="pageFormContent" layoutH="56" style="width: 450px;">
		<dl>
			<dt>公司名称：</dt>
			<dd>
				<input type="text" name="map[companyname]" class="required" size="30" maxlength="32" alt="请输入公司信息名称"
					value="${form.map.companyname}"/>
			</dd>
		</dl>
		<dl>
			<dt>联&nbsp;系&nbsp;人：</dt>
			<dd>
				<input type="text" name="map[contact]" size="30" maxlength="16"
					value="${form.map.contact}"/>
			</dd>
		</dl>
		<dl>
			<dt>地&nbsp;&nbsp;&nbsp;&nbsp;址：</dt>
			<dd>
				<input type="text" name="map[address]" size="30" maxlength="128"
					value="${form.map.address}"/>
			</dd>
		</dl>
		<dl>
			<dt>传&nbsp;&nbsp;&nbsp;&nbsp;真：</dt>
			<dd>
				<input type="text" name="map[fax]" size="30" maxlength="32"
					value="${form.map.fax}"/>
			</dd>
		</dl>
		<dl>
			<dt>电&nbsp;&nbsp;&nbsp;&nbsp;话：</dt>
			<dd>
				<input type="text" name="map[tel]" size="30" maxlength="32"
					value="${form.map.tel}"/>
			</dd>
		</dl>
		<dl>
			<dt>邮政编码：</dt>
			<dd>
				<input type="text" name="map[zip]" size="30" maxlength="6"
					value="${form.map.zip}"/>
			</dd>
		</dl>
		<dl>
			<dt>电子邮箱：</dt>
			<dd>
				<input type="text" name="map[email]" size="30" maxlength="32"
					value="${form.map.email}"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<textarea name="map[remark]" cols="32" rows="6" maxlength="512">${form.map.remark}</textarea>
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