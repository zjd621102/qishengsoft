<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">新增产品类别</h1>
<form method="post" action="<%=path%>/producttype/add"
	class="required-validate pageForm"
	onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[parent]" value="${form.map.parent}" />
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>产品类别名称：</dt>
			<dd>
				<input type="text" name="map[producttypename]" class="required" size="30"
					maxlength="32" value="${form.map.producttypename}" alt="请输入产品类别名称" />
			</dd>
		</dl>
		<dl>
			<dt>优先级：</dt>
			<dd style="width: 65%">
				<input type="text" name="map[priority]" class="required digits"
					size="30" min="1" max="99" value="99" />
				<span class="info">&nbsp;&nbsp;默认:99</span>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<textarea name="map[remark]" cols="30" rows="3" maxlength="256">${form.map.remark}</textarea>
			</dd>
		</dl>
	</div>

	<div class="formBar">
		<ul>
			<li>
				<div class="buttonActive">
					<div class="buttonContent">
						<button type="submit">确定</button>
					</div>
				</div>
			</li>
			<li>
				<div class="button">
					<div class="buttonContent">
						<button type="button" class="close">关闭</button>
					</div>
				</div>
			</li>
		</ul>
	</div>
</form>