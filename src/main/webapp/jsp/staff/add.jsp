<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/staff/add" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>员工名称：</dt>
				<dd>
					<input type="text" name="map[staffname]" class="required" size="25" maxlength="64"/>
				</dd>
			</dl>
			<dl>
				<dt>员工类别：</dt>
				<dd>
					<st:select dictType="员工类别" name="map[stafftype]" value="1"
						expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>员工状态：</dt>
				<dd>
					<st:select dictType="员工状态" name="map[staffstatus]" value="1"
						expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>联系电话：</dt>
				<dd>
					<input type="text" name="map[tel]" class="required" size="25" maxlength="32"/>
				</dd>
			</dl>
			<dl>
				<dt>工资开户银行：</dt>
				<dd>
					<input type="text" name="map[bank]" size="25" maxlength="32"/>
				</dd>
			</dl>
			<dl>
				<dt>工资银行账号：</dt>
				<dd>
					<input type="text" name="map[accountno]" size="25" maxlength="32"/>
				</dd>
			</dl>
			<dl>
				<dt>工资帐户名称：</dt>
				<dd>
					<input type="text" name="map[accountname]" size="25" maxlength="32"/>
				</dd>
			</dl>
			<dl style="width: 100%;">
				<dt>工资：</dt>
				<dd style="width: 70%;">
					<input type="text" name="map[salary]" class="required number" size="25" maxlength="12"
						value="0.00"/>
					<span style="color: red;">（单位：元/天）</span>
				</dd>
			</dl>
			<dl style="width: 100%;">
				<dt>加班工资：</dt>
				<dd style="width: 70%;">
					<input type="text" name="map[overtimepay]" class="required number" size="25" maxlength="12"
						value="0.00"/>
					<span style="color: red;">（单位：元/天）</span>
				</dd>
			</dl>
			<dl>
				<dt>优先级</dt>
				<dd>
					<input type="text" name="map[priority]" size="25" maxlength="2" value="9"/>
				</dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<textarea name="map[remark]" cols="27" rows="6" maxlength="512"></textarea>
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