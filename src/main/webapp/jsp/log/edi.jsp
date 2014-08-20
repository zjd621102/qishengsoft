<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=path%>/user/edi" class="pageForm required-validate"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
 		<input type="hidden" name="map[logid]" value="${form.map.logid}" />
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>操作类型：</label>
				<input type="text" readonly="readonly" size="30" name="map[logtype]" value="${form.map.logtype}" />
			</p>
			<p>
				<label>操作人：</label>
				<input type="text" readonly="readonly" size="30" name="map[operatername]" value="${form.map.operatername}" />
			</p>
			<p>
				<label>操作时间：</label>
				<input type="text" readonly="readonly" size="30" name="map[operatetime]" value="${form.map.operatetime}" />
			</p>
			<p>
				<label>备注：</label>
				<textarea readonly="readonly" name="map[remark]" cols="27" rows="6">${form.map.remark}</textarea>
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="button">
						<div class="buttonContent"><button type="button" class="close">取消</button></div>
					</div>
				</li>
			</ul>
		</div>
	</form>
</div>