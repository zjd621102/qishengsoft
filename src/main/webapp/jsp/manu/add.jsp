<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	// 修改排序的值
	function addRowOther() {
		$("[name='map[priorityrow]']:last").val($("#productRowTbody tr").size()-3);
	}
</script>

<form method="post" action="<%=path%>/manu/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="52">
		<dl>
			<dt>供应商名称：</dt>
			<dd>
				<input type="text" name="map[manuname]" class="required" size="25" maxlength="32" value="${form.map.manuname}"/>
			</dd>
		</dl>
		<dl>
			<dt>供应商类别：</dt>
			<dd>
				<st:select dictType="供应商类别" name="map[manutypeid]" value="${form.map.manutypeid}"
				 expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>供应商状态：</dt>
			<dd>
				<st:select dictType="状态" name="map[statusid]" value="${form.map.statusid}"
				 expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>联系人：</dt>
			<dd>
				<input type="text" name="map[manucontact]" class="required" size="25" maxlength="32"
				 value="${form.map.manucontact}"/>
			</dd>
		</dl>
		<dl>
			<dt>手机号码：</dt>
			<dd>
				<input type="text" name="map[manuphone]" class="required" size="25" maxlength="11"/>
			</dd>
		</dl>
		<dl>
			<dt>座机电话：</dt>
			<dd>
				<input type="text" name="map[manutel]" size="25" maxlength="32"/>
			</dd>
		</dl>
		<dl>
			<dt>EMAIL：</dt>
			<dd>
				<input type="text" name="map[manuemail]" size="25" maxlength="64"/>
			</dd>
		</dl>
		<dl>
			<dt>创建时间：</dt>
			<dd>
				<input type="text" name="map[createdate]" size="25" maxlength="19"
					value="${form.map.createdate}" readonly/>
			</dd>
		</dl>
		<dl>
			<dt>优先级</dt>
			<dd>
				<input type="text" name="map[priority]" size="25" maxlength="3" value="99"/>
			</dd>
		</dl>
		<dl>
			<dt>推荐人</dt>
			<dd>
				<input type="text" name="map[referee]" size="25" maxlength="16" />
			</dd>
		</dl>
		<dl>
			<dt>关联用户ID</dt>
			<dd>
				<input type="text" name="map[relateuserid]" size="25" maxlength="64" />
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>地址：</dt>
			<dd>
				<input type="text" name="map[address]" size="88" maxlength="128" />
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="88" maxlength="512" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<h1 class="margin10px">银行帐户信息</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr style="text-align: center;">
					<th width="4%">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="4%">序号</th>
					<th width="20%">开户银行</th>
					<th width="20%">公司银行账号</th>
					<th width="20%">帐户名称</th>
					<th width="10%">优先级</th>
					<th width="22%">备注</th>
				</tr>
			</thead>
			<tbody id="productRowTbody">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[manurowid]"/>
						<a href="#" class="btnDel delRow"></a>
					</td>
			   		<td></td>
			   		<td>
						<st:select dictType="银行类型" name="map[bankrow]"
							expStr="style='width: 182px;' class='required'" />
			   		</td>
			   		<td>
						<input type="text" name="map[accountnorow]" style="width: 96%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[accountnamerow]" style="width: 96%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[priorityrow]" class="digits" style="width: 93%" maxlength="2"
							value="9"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 96%" maxlength="255"/>
			   		</td>
			   	</tr>
			   	<tr id="IDEndRow"></tr>
		   	</tbody>
		</table>
	</div>
	
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>