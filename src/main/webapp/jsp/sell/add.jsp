<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<!-- 有“销售:其它”权限，可查看产品成本、利润权限 -->
<%-- <shiro:lacksPermission name="Sell:other"> --%>
	<c:set var="showProfit" value="none" scope="page" />
<%-- </shiro:lacksPermission> --%>

<script>
	$(function() {
		autoCom("[name='map[productno]']:visible");
	});
	
	function addRowOther() {
		autoCom("[name='map[productno]']:last");
	}
	
	function autoCom(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.ajax({
						url : "<%=path%>/product/getSelectByKeyword",
						dataType : "json",
						data : {
							keyword : request.term
						},
						success : function(data) {
							response($.map(data, function(item) {
			                    return {
			                        label: item.map.productno + "　" + item.map.productname,
			                        value: item.map.productno,
			                        productname: item.map.productname,
			                        productid: item.map.productid,
			                        unit: item.map.unit,
			                        costprice: item.map.costprice,
			                        realprice: item.map.realprice,
			                        numofonebox: item.map.numofonebox
			                    }
			                }));
						}
					});
				},
				minLength : 1,
				select : function(event, ui) {
					var row = $(this).parents("tr:first");
					row.find("[name='map[productname]']").val(ui.item.productname);
					row.find("[name='map[productid]']").val(ui.item.productid);
					row.find("[name='map[unit]']").val(ui.item.unit);
					row.find("[name='map[costprice]']").val(ui.item.costprice);
					row.find("[name='map[planprice]']").val(ui.item.realprice);
					row.find("[name='map[realprice]']").val(ui.item.realprice);
					row.find("[name='map[numofonebox]']").val(ui.item.numofonebox);
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
	 * 重写提交之前操作
	 * @returns {Boolean}
	 */
	function doBeforeSubmit() {
		changeValue();
		return true;
	}
	 
	/**
	 * 修改数量
	 */
	function changeNum() {
		setMultiply('boxnum', 'numofonebox', 'num');
		changeValue();
	}
	 
	/**
	 * 修改值
	 */
	function changeValue() {
		setMultiply('realprice', 'num', 'realsum');
		setAllSum('realsum', 'allrealsum');
		
		$("input[name*='map[realprice]']").each(function() {
			var row = $(this).parents("tr:first");
			var realprice = row.find("[name*='map[realprice]']").val();
			var costprice = row.find("[name*='map[costprice]']").val();
			var profit = realprice - costprice;
			profit = Math.round(profit * 100) / 100;
			row.find("[name*='map[profit]']").val(profit);
		});

		var allprofit = 0.00;
		$("input[name*='map[profit]']").each(function() {
			var row = $(this).parents("tr:first");
			var profit = row.find("[name*='map[profit]']").val();
			var num = row.find("[name*='map[num]']").val();
			allprofit += multiply(profit, num);
		});
		allprofit = Math.round(allprofit * 100) / 100;
		$("[name*='map[allprofit]']").val(allprofit);
	}
</script>

<form method="post" action="<%=path%>/sell/add" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="52">
		<dl>
			<dt>定单日期：</dt>
			<dd>
				<input type="text" name="map[selldate]" class="required date" size="25"
					value="${form.map.selldate}" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>客户名称：</dt>
			<dd>
				<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
				<input type="text" class="required" name="map[manuname]" value="${form.map.manuname}"
					size="25" suggestFields="manuid,manuname" readonly="readonly"/>
				
				<!-- 客户无值才须显示 -->
				<c:if test="${empty form.map.manuid}">
					<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=2" lookupGroup="manuLookup"
						width="1000" height="500">查找带回</a>
					<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname"></a>
				</c:if>
			</dd>
		</dl>
		<dl>
			<dt>当前流程：</dt>
			<dd>
				<input type="text" name="map[currflow]" class="readonly" size="25"
					value="申请" readonly="readonly" />
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" style="width: 556px;" maxlength="256" value="${form.map.remark}" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<h1 class="margin10px">销售清单</h1>
		
		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="30px">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="30px">序号</th>
					<th width="150px">产品编码</th>
					<th width="150px">产品名称</th>
					<th width="60px">计量单位</th>
					<th width="60px">产品单价</th>
					<th width="60px">实付单价</th>
					<th width="60px" style="display: ${showProfit};">成本单价</th>
					<th width="60px" style="display: ${showProfit};">利润</th>
					<th width="60px">数量</th>
					<th width="60px">件数</th>
					<th width="60px">一件数量</th>
					<th width="80px">实付总价</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="display: ${showProfit};"></td>
					<td style="display: ${showProfit};">
						<input type="text" name="map[allprofit]" style="width: 65px;" class="number"
							value="0.00" readonly="readonly"/>
					</td>
					<td></td>
					<td></td>
					<td style="font-size: 13px; font-weight: bold; color: red;">
						合计：
					</td>
					<td>
						<input type="text" name="map[allrealsum]" style="width: 65px;" class="number"
							value="0.00" readonly="readonly"/>
					</td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[sellrowid]"/>
						<a href="#" class="btnDel delRow"></a>
					</td>
			   		<td></td>
			   		<td>
				   		<input type="hidden" name="map[productid]" value="" />
						<input type="text" name="map[productno]" style="width: 90px;" maxlength="13"
							suggestFields="productid,productno,productname,unit,costprice,planprice,realprice,num,boxnum,numofonebox,realsum"/>
						<a class="btnLook" href="<%=path%>/product/tree" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear"
							suggestFields="productid,productno,productname,unit,costprice,planprice,realprice"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[productname]" style="width: 130px;" maxlength="32" class="required"/>
			   		</td>
			   		<td>
			   			<st:select dictType="计量单位" name="map[unit]" expStr="style='width: 100%;'" />
			   		</td>
			   		<td>
						<input type="text" name="map[planprice]" style="width: 45px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realprice]" style="width: 45px;" maxlength="12"
							class="number required" value="0.00" onchange="changeValue();" readonly="readonly"/>
			   		</td>
			   		<td style="display: ${showProfit};">
						<input type="text" name="map[costprice]" style="width: 45px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td style="display: ${showProfit};">
						<input type="text" name="map[profit]" style="width: 45px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[num]" style="width: 45px;" maxlength="12"
							class="digits required" value="0" onchange="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[boxnum]" style="width: 45px;" maxlength="12"
							class="digits" value="0" onchange="changeNum();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[numofonebox]" style="width: 45px;" maxlength="12"
							class="digits" value="0" onchange="changeNum();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 65px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 155px;" maxlength="256"/>
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