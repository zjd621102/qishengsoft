<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/parameter/edi"
		class="required-validate pageForm"
		onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[parameterid]" value="${form.map.parameterid}" />
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>系统参数名称：</dt>
				<dd>
					<input type="text" name="map[parametername]" class="required" style="width: 150px;"
						maxlength="32" value="${form.map.parametername}" />
				</dd>
			</dl>
			<dl>
				<dt>系统参数值：</dt>
				<dd>
					<input type="text" name="map[parametervalue]" class="required" style="width: 150px;"
						maxlength="32" value="${form.map.parametervalue}" />
				</dd>
			</dl>
			<dl>
				<dt>创建时间：</dt>
				<dd>
					<input type="text" name="map[createtime]" style="width: 150px;"
						maxlength="32" value="${form.map.createtime}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>描述：</dt>
				<dd>
					<textarea name="map[remark]" cols="57" rows="6" maxlength="127"
						>${form.map.remark}</textarea>
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