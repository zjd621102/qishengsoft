<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/module/add"
		class="required-validate pageForm"
		onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[parentid]" value="${form.map.parentid}" />
		
		<div class="pageFormContent" layoutH="56">
			<dl>
				<dt>模块名称：</dt>
				<dd>
					<input type="text" name="map[modulename]" class="required" size="25"
						maxlength="32" />
				</dd>
			</dl>
			<dl>
				<dt>优先级：</dt>
				<dd style="width: 65%">
					<input type="text" name="map[priority]" class="required digits" size="25"
						value="99" min="1" max="99" />
					<span class="info">&nbsp;&nbsp;默认:99</span>
				</dd>
			</dl>
			<dl>
				<dt>URL：</dt>
				<dd>
					<input type="text" name="map[url]" size="25" maxlength="255" />
				</dd>
			</dl>
			<dl>
				<dt>授权名称：</dt>
				<dd>
					<input type="text" name="map[sn]" class="required" size="25" maxlength="32" />
				</dd>
			</dl>
			<dl>
				<dt>页面标识：</dt>
				<dd>
					<input type="text" name="map[rel]" size="25" maxlength="32" />
				</dd>
			</dl>
			<dl>
				<dt>描述：</dt>
				<dd>
					<textarea name="map[description]" cols="27" rows="6" maxlength="127"></textarea>
				</dd>
			</dl>
		</div>
	
		<div class="formBar">
			<ul>
				<li><div class="buttonActive">
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
</div>