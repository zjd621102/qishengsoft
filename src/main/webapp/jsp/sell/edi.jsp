<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script>
	$(function() {
		autoCom("[name='map[productno]']:visible");
		
		setTimeout(function() {
			setAllSum('realsum', 'allrealsum');
		}, 100);
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
			                        realprice: item.map.realprice
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
					row.find("[name='map[planprice]']").val(ui.item.realprice);
					row.find("[name='map[realprice]']").val(ui.item.realprice);
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

		 setMultiply(this, 'realprice', 'num', 'realsum');
		 setAllSum('realsum', 'allrealsum');
		return true;
	}
</script>

<h1 class="margin10px">修改销售单</h1>
<form method="post" action="<%=path%>/sell/edi" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[sellid]" value="${form.map.sellid}" />
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>销售编号：</dt>
			<dd>
				<input type="text" name="map[sellno]" class="required" size="25" maxlength="16"
					 value="${form.map.sellno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>销售日期：</dt>
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
				<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=2" lookupGroup="manuLookup"
					width="1000" height="500">查找带回</a>
				<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname"></a>
			</dd>
		</dl>
		<dl>
			<dt>当前流程：</dt>
			<dd>
				<select name="map[currflow]" style="width: 159px;" class="required">
					<option value=""></option>
					<c:forEach items="${currflowList}" var="currflow">
						<option value="${currflow.map.flowname}"
							${currflow.map.flowname==form.map.currflow?"selected":""}
						>
							${currflow.map.flowname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>制单人：</dt>
			<dd>
				<input type="hidden" name="map[maker]" value="${form.map.maker}" />
				<input type="text" name="map[makername]" class="required" size="25" maxlength="16"
					value="${form.map.makername}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>创建日期：</dt>
			<dd>
				<input type="text" name="map[createtime]" size="25" maxlength="19"
					value="${form.map.createtime}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="177" maxlength="256" value="${form.map.remark}" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<h1 class="margin10px">销售清单</h1>
		
		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="3%">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="3%">序号</th>
					<th width="10%">产品编码</th>
					<th width="15%">产品名称</th>
					<th width="6%">计量单位</th>
					<th width="6%">应付单价</th>
					<th width="6%">实付单价</th>
					<th width="6%">数量</th>
					<th width="6%">实付总价</th>
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
					<td style="font-size: 13px; font-weight: bold; color: red;">
						合计：
					</td>
					<td>
						<input type="text" name="map[allrealsum]" style="width: 91%" class="number"
							value="${form.map.allrealsum}" readonly="readonly"/>
					</td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display: none;">
					<td>
						<input type="hidden" name="map[sellrowid]"/>
						<a href="#" class="btnDel delRow"></a>
					</td>
			   		<td></td>
			   		<td>
				   		<input type="hidden" name="map[productid]" value="" />
						<input type="text" name="map[productno]" style="width: 60%" maxlength="13"
							suggestFields="productid,productno,productname,unit,planprice,realprice" />
						<a class="btnLook" href="<%=path%>/product/tree" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear"
							suggestFields="productid,productno,productname,unit,planprice,realprice,num,realsum"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[productname]" style="width: 96%" maxlength="32"
							class="required"/>
			   		</td>
			   		<td>
						<select name="map[unit]" style="width: 100%;">
							<option value=""></option>
							<c:forEach items="${unitList}" var="unit">
								<option value="${unit.map.unitid}">
									${unit.map.unitname}
								</option>
							</c:forEach>
						</select>
			   		</td>
			   		<td>
						<input type="text" name="map[planprice]" style="width: 92%" maxlength="12"
							class="number" value="0.00"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realprice]" style="width: 92%" maxlength="12"
							class="number required" value="0.00" onchange="setMultiply(this, 'realprice', 'num', 'realsum');
							setAllSum('realsum', 'allrealsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[num]" style="width: 91%" maxlength="12"
							class="number required" value="0.00" onchange="setMultiply(this, 'realprice', 'num', 'realsum');
							setAllSum('realsum', 'allrealsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 91%" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 98%" maxlength="256"/>
			   		</td>
			   	</tr>
				<c:forEach items="${sellrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[sellrowid]" value="${bean.map.sellrowid}"/>
							<a href="#" class="btnDel delRow"></a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
				   			<input type="hidden" name="map[productid]" value="${bean.map.productid}" />
							<input type="text" name="map[productno]" style="width: 60%" maxlength="13"
								suggestFields="productid,productno,productname,unit,planprice,realprice"
								value="${bean.map.productno}" />
							<a class="btnLook" href="<%=path%>/product/tree" lookupGroup="lookup" width="1200"></a>
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="productid,productno,productname,unit,planprice,realprice,num,realsum"></a>
				   		</td>
				   		<td>
							<input type="text" name="map[productname]" style="width: 96%" maxlength="32"
								value="${bean.map.productname}" class="required"/>
				   		</td>
				   		<td>
							<select name="map[unit]" style="width: 100%;">
								<option value=""></option>
								<c:forEach items="${unitList}" var="unit">
									<option value="${unit.map.unitid}"
										${unit.map.unitid==bean.map.unit?"selected":""}
									>
										${unit.map.unitname}
									</option>
								</c:forEach>
							</select>
				   		</td>
				   		<td>
							<input type="text" name="map[planprice]" style="width: 92%" maxlength="12"
								class="number" value="${bean.map.planprice}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realprice]" style="width: 92%" maxlength="12"
								class="number required" value="${bean.map.realprice}"
								onchange="setMultiply(this, 'realprice', 'num', 'realsum');
								setAllSum('realsum', 'allrealsum');"/>
				   		</td>
				   		<td>
							<input type="text" name="map[num]" style="width: 91%" maxlength="12"
								class="number required" value="${bean.map.num}"
								onchange="setMultiply(this, 'realprice', 'num', 'realsum');
								setAllSum('realsum', 'allrealsum');"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realsum]" style="width: 91%" maxlength="12"
								class="number" value="${bean.map.realsum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 98%" maxlength="256"
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
				onclick="window.open('<%=path%>/sell/edi/${form.map.sellid}?act=print');">打印</button></div></div></li>
		</ul>
	</div>
</form>