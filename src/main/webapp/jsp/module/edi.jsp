<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">修改模块</h2>
<form method="post" action="<%=path%>/module/edi"
	class="required-validate pageForm"
	onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[moduleid]" value="${form.map.moduleid}" />
	<input type="hidden" name="map[parentid]" value="${form.map.parentid}" />
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>模块名称：</dt>
			<dd>
				<input type="text" name="map[modulename]" class="required" size="30"
					maxlength="32" value="${form.map.modulename}" alt="请输入模块名称" />
			</dd>
		</dl>
		<dl>
			<dt>优先级：</dt>
			<dd style="width: 65%">
				<input type="text" name="map[priority]" class="required digits"
					size="30" min="1" max="99" value="${form.map.priority}" />
				<span class="info">&nbsp;&nbsp;默认:99</span>
			</dd>
		</dl>
		<dl>
			<dt>URL：</dt>
			<dd>
				<input type="text" name="map[url]" class="required" size="30"
					maxlength="255" alt="请输入访问地址" value="${form.map.url}" />
			</dd>
		</dl>
		<dl>
			<dt>授权名称：</dt>
			<dd>
				<input type="text" name="map[sn]" class="required" size="30"
					maxlength="32" alt="授权名称" value="${form.map.sn}" />
			</dd>
		</dl>
		<dl>
			<dt>描述：</dt>
			<dd>
				<textarea name="map[description]" cols="30" rows="3" maxlength="255">${form.map.description}</textarea>
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