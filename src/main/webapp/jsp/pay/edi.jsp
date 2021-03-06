<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	$().ready(function() {
		setTimeout(function() {
			changeValue();
		}, 100);
	});
	 
	/**
	 * 修改值
	 */
	function changeValue() {
		setAllSum('plansum', 'allplansum');
		setAllSum('realsum', 'allrealsum');
	}
</script>

<form method="post" action="<%=path%>/pay/edi" class="required-validate pageForm"
	onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);" style="margin-top: -10px;">
	<div class="pageFormContent" layoutH="42">
		<dl>
			<dt>单据ID：</dt>
			<dd>
				<input type="text" name="map[payid]" size="25" value="${form.map.payid}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>单据类型：</dt>
			<dd>
				<input type="hidden" name="map[btype]" value="${form.map.btype}" />
				<input type="text" name="map[btypename]" size="25" value="${form.map.btypename}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>制单人：</dt>
			<dd>
				<input type="hidden" name="map[maker]" value="${form.map.maker}" />
				<input type="text" name="map[makername]" class="required" size="25" maxlength="64"
					value="${form.map.makername}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>单据日期：</dt>
			<dd>
				<input type="text" name="map[paydate]" class="required date" size="25"
					value="${form.map.paydate}" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>关联单号：</dt>
			<dd>
				<input type="text" name="map[relateno]" size="25" maxlength="16"
					value="${form.map.relateno}" readonly="readonly" ondblclick="openBillByNo('<%=path%>', '${form.map.relateno}')"/>
			</dd>
		</dl>
		<dl>
			<dt>关联金额：</dt>
			<dd>
				<input type="text" name="map[relatemoney]" class="number" size="25" maxlength="12"
					value="${form.map.relatemoney}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>当前流程：</dt>
			<dd>
				<st:select dictType="流程状态" name="map[currflow]" value="${form.map.currflow}" expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>创建时间：</dt>
			<dd>
				<input type="text" name="map[createtime]" size="25" maxlength="19"
					value="${form.map.createtime}" readonly="readonly"/>
			</dd>
		</dl>
		<!-- 
		<dl>
			<dt>银行卡卡号</dt>
			<dd>
				<select name="map[bankcardno]" style="width: 184px;">
					<option value=""></option>
					<c:forEach items="${bankcardList}" var="bankcard">
						<option value="${bankcard.map.bankcardno}"
						 ${bankcard.map.bankcardno==form.map.bankcardno?"selected":""}>
							${bankcard.map.bankcardno}|${bankcard.map.bankname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		-->
		<dl>
			<dt>供应商</dt>
			<dd>
				<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
				<input type="text" name="map[manuname]" value="${form.map.manuname}"
					suggestFields="manuid,manuname" style="width: 176px;" readonly="readonly"/>
					<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=2" lookupGroup="manuLookup"
						width="1000" height="500">查找带回</a>
				<a href="javascript:void(0);" class="btnClear"
					suggestFields="manuid,manuname"></a>
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" style="width: 556px;" maxlength="256"
					value="${form.map.remark}"/>
			</dd>
		</dl>
	
		<div class="divider"></div>

		<h1 class="margin10px">单据清单</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="30px">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="30px">序号</th>
					<th width="100px"><span class="red">*</span>应付金额</th>
					<th width="100px"><span class="red">*</span>实付金额</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td style="font-size: 13px; font-weight: bold; color: red;">
						小计
					</td>
					<td>
						<input type="text" name="map[allplansum]" style="width: 85px" class="number"
							value="${form.map.allplansum}" readonly="readonly"/>
					</td>
					<td>
						<input type="text" name="map[allrealsum]" style="width: 85px" class="number"
							value="${form.map.allrealsum}" readonly="readonly"/>
					</td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[payrowid]"/>
						<a href="#" class="btnDel delRow" onmouseout="changeValue();"></a>
					</td>
			   		<td></td>
			   		<td>
						<input type="text" name="map[plansum]" style="width: 85px" maxlength="12"
							class="number" value="0.00"
							onchange="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 85px" maxlength="12"
							class="number" value="0.00"
							onchange="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 478px" maxlength="256"/>
			   		</td>
			   	</tr>
				<c:forEach items="${payrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[payrowid]" value="${bean.map.payrowid}"/>
							<a href="#" class="btnDel delRow" onmouseout="changeValue();"></a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
							<input type="text" name="map[plansum]" style="width: 85px" maxlength="12"
								class="number" value="${bean.map.plansum}"
								onchange="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realsum]" style="width: 85px" maxlength="12"
								class="number" value="${bean.map.realsum}"
								onchange="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 478px" maxlength="256"
								value="${bean.map.remarkrow}"/>
				   		</td>
				   	</tr>
			   	</c:forEach>
			   	<tr id="IDEndRow"></tr>
		   	</tbody>
		</table>
	</div>
	
	<div class="formBar">
		<ul>
			<c:if test="${form.map.currflow != '结束'}">
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			</c:if>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button"
				onclick="window.open('<%=path%>/pay/edi/${form.map.payid}?act=print');">打印</button></div></div></li>
		</ul>
	</div>
</form>