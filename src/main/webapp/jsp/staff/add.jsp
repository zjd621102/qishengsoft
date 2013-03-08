<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">新增员工</h2>
<form method="post" action="<%=path%>/staff/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>员工名称：</dt>
			<dd>
				<input type="text" name="map[staffname]" class="required" size="30" maxlength="64"/>
			</dd>
		</dl>
		<dl>
			<dt>员工类别：</dt>
			<dd>
				<select name="map[stafftype]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${stafftypeList}" var="stafftype">
						<option value="${stafftype.map.stafftypeid}"
							${stafftype.map.stafftypeid==1?"selected":""}
						>
							${stafftype.map.stafftypename}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>员工状态：</dt>
			<dd>
				<select name="map[staffstatus]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${staffstatusList}" var="staffstatus">
						<option value="${staffstatus.map.staffstatusid}"
							${staffstatus.map.staffstatusid==1?"selected":""}
						>
							${staffstatus.map.staffstatusname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>联系电话：</dt>
			<dd>
				<input type="text" name="map[tel]" class="required" size="30" maxlength="32"/>
			</dd>
		</dl>
		<dl>
			<dt>工资开户银行：</dt>
			<dd>
				<input type="text" name="map[bank]" size="30" maxlength="32"/>
			</dd>
		</dl>
		<dl>
			<dt>工资银行账号：</dt>
			<dd>
				<input type="text" name="map[accountno]" size="30" maxlength="32"/>
			</dd>
		</dl>
		<dl>
			<dt>工资帐户名称：</dt>
			<dd>
				<input type="text" name="map[accountname]" size="30" maxlength="32"/>
			</dd>
		</dl>
		<dl style="width: 100%;">
			<dt>工资：</dt>
			<dd style="width: 70%;">
				<input type="text" name="map[salary]" class="required number" size="30" maxlength="12"
					value="0.00"/>
				<span style="color: red;">（单位：元/天）</span>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="30" maxlength="512"/>
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