<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">

	$().ready(function() {
		autoComManu("[name='map[manuname]']");
	});

	// 查询供应商
	function autoComManu(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.post(
						"<%=path%>/manu/getSelectByKeyword",
						{keyword : request.term, manutypeid : ''},
						function(data) {
							response($.map(data, function(item) {
			                    return {
			                        label: item.map.manuname,
			                        value: item.map.manuname,
			                        manuid: item.map.manuid
			                    }
			                }));
						},
						"json"
					);
				},
				minLength : 1,
				select : function(event, ui) {
					$("[name='map[manuid]']").val(ui.item.manuid);
					$("[name='map[manuname]']").val(ui.item.manuname);
				},
				open : function() {
					$(this).removeClass("ui-corner-all").addClass(
							"ui-corner-top");
				},
				close : function() {
					$(this).removeClass("ui-corner-top").addClass(
							"ui-corner-all");
				}
			});
		}, 100);
	}
	
	/**
	 * 修改值
	 */
	function changeValue() {
		setAllSum('plansum', 'allplansum');
		setAllSum('realsum', 'allrealsum');
	}
</script>

<form method="post" action="<%=path%>/pay/add" class="required-validate pageForm"
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
				<select name="map[btype]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${btypeList}" var="btype">
						<option value="${btype.map.dictvalue}"
							${btype.map.dictvalue==form.map.btype?"selected":""}
						>
							${btype.map.dictname}
						</option>
					</c:forEach>
				</select>
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
			<dt>当前流程：</dt>
			<dd>
				<st:select dictType="流程状态" name="map[currflow]" value="申请" expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<!--
		<dl>
			<dt>银行卡卡号</dt>
			<dd>
				<select name="map[bankcardno]" style="width: 184px;">
					<option value=""></option>
					<c:forEach items="${bankcardList}" var="bankcard">
						<option value="${bankcard.map.bankcardno}">
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
				<input type="hidden" name="map[manuid]" class="required" />
				<input type="text" name="map[manuname]" class="required" 
					size="25" suggestFields="manuid,manuname" style="width: 176px;"/>
					<a class="btnLook" href="<%=path%>/manu/list?act=backselect" lookupGroup="manuLookup"
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
							onchange="setAllSum('plansum', 'allplansum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 85px" maxlength="12"
							class="number" value="0.00"
							onchange="setAllSum('realsum', 'allrealsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 478px" maxlength="256"/>
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