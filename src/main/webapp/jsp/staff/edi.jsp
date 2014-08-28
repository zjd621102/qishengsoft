<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/staff/edi" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[staffid]" value="${form.map.staffid}"/>
		<div class="pageFormContent" layoutH="56">
			<dl>
				<dt>员工名称：</dt>
				<dd>
					<input type="text" name="map[staffname]" class="required" size="30" maxlength="64" alt="请输入员工名称"
						value="${form.map.staffname}"/>
				</dd>
			</dl>
			<dl>
				<dt>员工类别：</dt>
				<dd>
					<st:select dictType="员工类别" name="map[stafftype]" value="${form.map.stafftype}"
						expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>员工状态：</dt>
				<dd>
					<st:select dictType="员工状态" name="map[staffstatus]" value="${form.map.staffstatus}"
						expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>联系电话：</dt>
				<dd>
					<input type="text" name="map[tel]" class="required" size="30" maxlength="32" alt="联系电话"
						value="${form.map.tel}"/>
				</dd>
			</dl>
			<dl>
				<dt>工资开户银行：</dt>
				<dd>
					<input type="text" name="map[bank]" size="30" maxlength="32" value="${form.map.bank}"/>
				</dd>
			</dl>
			<dl>
				<dt>工资银行账号：</dt>
				<dd>
					<input type="text" name="map[accountno]" size="30" maxlength="32" value="${form.map.accountno}"/>
				</dd>
			</dl>
			<dl>
				<dt>工资帐户名称：</dt>
				<dd>
					<input type="text" name="map[accountname]" size="30" maxlength="32" value="${form.map.accountname}"/>
				</dd>
			</dl>
			<dl style="width: 100%;">
				<dt>工资：</dt>
				<dd style="width: 70%;">
					<input type="text" name="map[salary]" class="required number" size="30" maxlength="12"
						value="${form.map.salary}"/>
					<span style="color: red;">（单位：元/天）</span>
				</dd>
			</dl>
			<dl>
				<dt>优先级</dt>
				<dd>
					<input type="text" name="map[priority]" size="30" maxlength="2" value="${form.map.priority}"/>
				</dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<textarea name="map[remark]" cols="27" rows="5" maxlength="512">${form.map.remark}</textarea>
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
</div>