<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/materialtype/edi"
		class="required-validate pageForm"
		onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[materialtype]" value="${form.map.materialtype}" />
		<input type="hidden" name="map[parent]" value="${form.map.parent}" />
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>物资类型编码：</dt>
				<dd>
					<input type="text" name="map[materialtypeno]" class="required" size="25"
						maxlength="8" value="${form.map.materialtypeno}" readonly="readonly" />
				</dd>
			</dl>
			<dl>
				<dt>物资类型名称：</dt>
				<dd>
					<input type="text" name="map[materialtypename]" class="required" size="25"
						maxlength="32" value="${form.map.materialtypename}" />
				</dd>
			</dl>
			<dl>
				<dt>优先级：</dt>
				<dd style="width: 65%">
					<input type="text" name="map[priority]" class="required digits"
						size="25" min="1" max="999" value="${form.map.priority}" />
					<span class="info">&nbsp;&nbsp;默认:99</span>
				</dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<textarea name="map[remark]" cols="27" rows="8" maxlength="256">${form.map.remark}</textarea>
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
</div>