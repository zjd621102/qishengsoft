<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/fixings/add"
		class="required-validate pageForm"
		onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[parentid]" value="${form.map.parentid}" />
		
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>配件名称：</dt>
				<dd>
					<input type="text" name="map[fixingsname]" class="required" size="25" maxlength="64" />
				</dd>
			</dl>
			<dl>
				<dt>物资编码：</dt>
				<dd>
					<input type="text" name="map[materialno]" class="required" size="25" maxlength="11" value="0"/>
				</dd>
			</dl>
			<dl>
				<dt>优先级：</dt>
				<dd style="width: 65%">
					<input type="text" name="map[priority]" class="required digits" size="25"
						value="9" min="1" max="99" />
					<span class="info">&nbsp;&nbsp;默认:9</span>
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