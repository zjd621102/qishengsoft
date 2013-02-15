<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">修改单位</h2>
<form method="post" action="<%=path%>/unit/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[unitid]" value="${form.map.unitid}"/>
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>单位名称：</dt>
			<dd>
				<input type="text" name="map[unitname]" class="required" size="30" maxlength="64" alt="请输入单位名称"
					value="${form.map.unitname}"/>
			</dd>
		</dl>
		<dl>
			<dt>优先级：</dt>
			<dd style="width: 65%;">
				<input type="text" name="map[priority]" class="required digits" size="30" min="1" max="99"
					value="${form.map.priority}"/>
				<span class="info">&nbsp;&nbsp;默认:99</span>
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