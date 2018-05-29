<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	// 修改排序的值
	function addRowOther() {
		$("[name='map[priorityrow]']:last").val($("#productRowTbody tr").size()-3);
	}
</script>

<div class="pageContent">
	<form method="post" action="<%=path%>/manu/add" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);" style="margin-top: -10px;">
		<div class="pageFormContent" layoutH="42">
			<dl>
				<dt>供应商名称</dt>
				<dd>
					<input type="text" name="map[manuname]" class="required" size="25" maxlength="32" value="${form.map.manuname}"/>
				</dd>
			</dl>
			<dl>
				<dt>名称首字母</dt>
				<dd>
					<input type="text" name="map[manunamepy]" size="25" maxlength="16" />
				</dd>
			</dl>
			<dl>
				<dt>供应商类别</dt>
				<dd>
					<st:select dictType="供应商类别" name="map[manutypeid]" value="${form.map.manutypeid}"
						expStr="style='width: 184px;' class='required'" />
					<span class="_required">✽</span>
				</dd>
			</dl>
			<dl>
				<dt>供应商状态</dt>
				<dd>
					<st:select dictType="状态" name="map[statusid]" value="1"
						expStr="style='width: 184px;' class='required'" />
				</dd>
			</dl>
			<dl>
				<dt>联系人</dt>
				<dd>
					<input type="text" name="map[manucontact]" size="25" maxlength="32"
						value="${form.map.manucontact}"/>
				</dd>
			</dl>
			<dl>
				<dt>手机号码</dt>
				<dd>
					<input type="text" name="map[manuphone]" size="25" maxlength="11"/>
				</dd>
			</dl>
			<dl>
				<dt>座机电话</dt>
				<dd>
					<input type="text" name="map[manutel]" size="25" maxlength="32"/>
				</dd>
			</dl>
			<dl>
				<dt>优先级</dt>
				<dd>
					<input type="text" name="map[priority]" size="25" maxlength="3" value="99"/>
				</dd>
			</dl>
			<dl>
				<dt>地址</dt>
				<dd>
					<input type="text" name="map[address]" size="88" maxlength="128" />
				</dd>
			</dl>
			<dl>
				<dt></dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>备注</dt>
				<dd>
					<input type="text" name="map[remark]" size="88" maxlength="512" />
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