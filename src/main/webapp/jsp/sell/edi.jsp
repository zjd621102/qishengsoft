<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<!-- 有“销售:其它”权限，可查看产品成本、利润权限 -->
<%-- <shiro:lacksPermission name="Sell:other"> --%>
	<c:set var="showProfit" value="none" scope="page" />
<%-- </shiro:lacksPermission> --%>

<!-- 有“销售:其它”权限，可修改“产品单价”权限 -->
<shiro:lacksPermission name="Sell:other">
	<c:set var="planpriceReadonly" value="readonly" scope="page" />
</shiro:lacksPermission>

<script>
	$(function() {
		autoCom("[name='map[productno]']:visible");
		autoComManu("[name='map[manuname]']");
		
		setTimeout(function() {
			changeValue();
		}, 100);
	});
	
	function addRowOther() {
		autoCom("[name='map[productno]']:last");
// 		$("[name='map[sort]']:last").val($("#rowTbody tr").size()-3);
	}
	
	function autoCom(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.post(
						"<%=path%>/product/getSelectByKeyword",
						{keyword : request.term, manuid : $("[name='map[manuid]']").val()},
						function(data) {
							response($.map(data, function(item) {
			                    return {
			                        label: item.map.productno + "　" + item.map.productname,
			                        value: item.map.productno,
			                        productname: item.map.productname,
			                        productid: item.map.productid,
			                        unit: item.map.unit,
			                        costprice: item.map.costprice,
			                        realprice: item.map.realprice,
			                        historyprice: item.map.historyprice,
			                        numofonebox: item.map.numofonebox
			                    }
			                }));
						},
						"json"
					);
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
					if(ui.item.historyprice && (ui.item.realprice != ui.item.historyprice)) {
						row.find("[name='map[remarkrow]']").val("上批次价格：" + ui.item.historyprice);
					}
					
					changeValue();
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
	
	// 查询客户
	function autoComManu(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.post(
						"<%=path%>/manu/getSelectByKeyword",
						{keyword : request.term, manutypeid : '2'},
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
	 * 重写提交之前操作
	 * @returns {Boolean}
	 */
	function doBeforeSubmit() {
		changeValue();
		return true;
	}
	 
	/**
	 * 修改值
	 */
	function changeValue() {
		setMultiply_sell('realprice', 'num', 'realsum');
		setAllSum('realsum', 'allrealsum', 'sellJspFormId');
		
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
	
	// 删除行
	function delRowOther() {
		setAllSum('realsum', 'allrealsum', 'sellJspFormId');
	}
	
	/**
	 * 生成采购单
	 */
	function addBuy() {
		$("[name='map[addBuy]']").val("1");
		if(checkFormSubmit()) {
			validateCallback($(".pageForm")[0], dialogAjaxDone);
		}
	}
	
	// 重新生成编码
	function newNo() {
		$.post(
			"<%=path%>/sell/newNo",
			{sellid: ${form.map.sellid}},
			function(data) {
				if(data == "true") {// 成功
					$.pdialog.reload("<%=path%>/sell/edi/${form.map.sellid}",
							{data:{}, dialogId:"sell_edi", callback:null});
				} else {// 失败
					
				}
			}
		);
	}

	/**
	 * 重写方法 - 赋值相乘的值
	 * @param name1 相乘字段
	 * @param name2 相乘字段
	 * @param name3 赋值字段
	 * @param obj 	所在行的对象
	 */
	function setMultiply_sell(name1, name2, name3) {
		$("input[name*='map[" + name1 + "]']").each(function() {
			var row = $(this).parents("tr:first");
			
			var planprice = row.find("[name*='map[planprice]']").val();
			var discount = row.find("[name*='map[discount]']").val();

			var realprice = Math.round(planprice * discount * 100) / 100;
			row.find("[name*='map[" + name1 + "]']").val(realprice);
			
			var num = row.find("[name*='map[" + name2 + "]']").val();
			var realsum = (multiply(realprice, num)).toFixed(2);// 四舍五入为2位小数
			row.find("[name*='map[" + name3 + "]']").val(realsum);
		});
	}
	
	/**
	 * 修改折扣
	 */
	function changeDiscount() {
		var changeDiscount = $("#alldiscount").val();
		$("[name*='map[discount]']").val(changeDiscount);
		setMultiply_sell('realprice', 'num', 'realsum');
		setAllSum('realsum', 'allrealsum', 'sellJspFormId');
	}
</script>

<form id="sellJspFormId" method="post" action="<%=path%>/sell/edi" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);" style="margin-top: -10px;">
 	<input type="hidden" name="map[sellid]" value="${form.map.sellid}" />
 	<input type="hidden" name="map[addBuy]" value="" />
	<div class="pageFormContent" layoutH="42">
		<dl>
			<dt>销售编号：</dt>
			<dd>
				<input type="text" name="map[sellno]" class="required" size="24" maxlength="16"
					 value="${form.map.sellno}" readonly="readonly"/>
				<c:if test="${form.map.currflow == '申请'}"><!-- 申请状态才能修改编码 -->
				<div class="button" style="margin-left: 5px; float: left;">
					<div class="buttonContent">
						<button type="button" onclick="newNo();">新编</button>
					</div>
				</div>
				</c:if>
			</dd>
		</dl>
		<dl>
			<dt>下单日期：</dt>
			<dd>
				<input type="text" name="map[selldate]" class="required date" size="25"
					value="${form.map.selldate}" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>客户名称：</dt>
			<dd>
				<input type="hidden" name="map[manuid]" class="required" value="${form.map.manuid}"/>
				<input type="text" class="required" name="map[manuname]" value="${form.map.manuname}"
					size="25" suggestFields="manuid,manuname"/>
				<!-- 
				<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=2" lookupGroup="manuLookup"
					width="1000" height="500">查找带回</a>
				<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname"></a>
				-->
			</dd>
		</dl>
		<dl>
			<dt>当前流程：</dt>
			<dd>
				<st:select dictType="销售状态" name="map[currflow]" value="${form.map.currflow}" expStr="style='width: 184px;' class='required'" />
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
					<th width="130px">产品编码</th>
					<th width="150px">产品名称</th>
					<!--
 					<th width="60px">计量单位</th>
 					-->
					<th width="60px">产品单价</th>
					<th width="60px">实付单价</th>
					<!--
					<th width="60px" style="display: ${showProfit};">成本单价</th>
					<th width="60px" style="display: ${showProfit};">利润</th>
					-->
					<th width="60px">数量</th>
					<th width="60px">折扣</th>
					<th width="60px" style="display: none;">件数</th>
					<th width="60px" style="display: none;">一件数量</th>
					<th width="80px">实付总价</th>
					<th width="50px">排序</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody id="rowTbody">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<!--
 					<td></td>
 					-->
					<td style="display: none;"></td>
					<td style="display: none;"></td>
					<!--
					<td style="display: ${showProfit};"></td>
					<td style="display: ${showProfit};">
						<input type="text" name="map[allprofit]" style="width: 65px;" class="number"
							value="0.00" readonly="readonly"/>
					</td>
					-->
					<td></td>
					<td></td>
					<td></td>
					<td>
						<input type="text" id="alldiscount" name="map[alldiscount]" style="width: 45px"
							class="number required" value="${form.map.alldiscount}" onchange="changeDiscount();"/>
					</td>
					<td>
						<input type="text" name="map[allrealsum]" style="width: 65px;" class="number"
							value="0.00" readonly="readonly"/>
					</td>
					<td></td>
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
						<input type="text" name="map[productno]" style="width: 90px; margin-right: 5px;" maxlength="13"
							suggestFields="productid,productno,productname,unit,costprice,planprice,realprice" />
						<!-- 
						<a class="btnLook" href="<%=path%>/product/tree" lookupGroup="lookup" width="1200"></a>
						-->
						<a href="javascript:void(0);" class="btnClear"
							suggestFields="productid,productno,productname,unit,costprice,planprice,realprice,num,realsum"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[productname]" style="width: 130px;" maxlength="32"
							class="required"/>
			   		</td>
			   		<!--
			   		<td>
			   			<st:select dictType="计量单位" name="map[unit]" expStr="style='width: 100%;'" />
			   		</td>
			   		-->
			   		<td>
						<input type="text" name="map[planprice]" style="width: 45px;" maxlength="12"
							class="number" value="0.00" ${planpriceReadonly} onchange="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realprice]" style="width: 45px;" maxlength="12"
							class="number required" value="0.00" onchange="changeValue();" readonly="readonly"/>
			   		</td>
			   		<!--
			   		<td style="display: ${showProfit};">
						<input type="text" name="map[costprice]" style="width: 45px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td style="display: ${showProfit};">
						<input type="text" name="map[profit]" style="width: 45px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		-->
			   		<td>
						<input type="text" name="map[num]" style="width: 45px;" maxlength="12"
							class="digits required" value="0" onchange="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[discount]" style="width: 45px" maxlength="12"
							class="number required" value="1" onchange="setMultiply_sell('realprice', 'num', 'realsum');
							setAllSum('realsum', 'allrealsum', 'sellJspFormId');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 65px;" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sort]" style="width: 35px;" maxlength="4" class="number"
							value="5"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 240px;" maxlength="256"/>
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
							<input type="text" name="map[productno]" style="width: 90px; margin-right: 5px;" maxlength="13"
								suggestFields="productid,productno,productname,unit,costprice,planprice,realprice"
								value="${bean.map.productno}" />
							<!-- 
							<a class="btnLook" href="<%=path%>/product/tree" lookupGroup="lookup" width="1200"></a>
							-->
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="productid,productno,productname,unit,costprice,planprice,realprice,num,realsum"></a>
				   		</td>
				   		<td>
							<input type="text" name="map[productname]" style="width: 130px;" maxlength="32"
								value="${bean.map.productname}" class="required"/>
				   		</td>
				   		<!--
				   		<td>
				   			<st:select dictType="计量单位" name="map[unit]" value="${bean.map.unit}" expStr="style='width: 100%;'" />
				   		</td>
				   		-->
				   		<td>
							<input type="text" name="map[planprice]" style="width: 45px;" maxlength="12"
								class="number" value="${bean.map.planprice}" ${planpriceReadonly}
								onchange="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realprice]" style="width: 45px;" maxlength="12"
								class="number required" value="${bean.map.realprice}" onchange="changeValue();"
								readonly="readonly"/>
				   		</td>
				   		<!--
				   		<td style="display: ${showProfit};">
							<input type="text" name="map[costprice]" style="width: 45px;" maxlength="12"
								class="number" value="${bean.map.costprice}" readonly="readonly"/>
				   		</td>
				   		<td style="display: ${showProfit};">
							<input type="text" name="map[profit]" style="width: 45px;" maxlength="12"
								class="number" value="${bean.map.profit}" readonly="readonly"/>
				   		</td>
				   		-->
				   		<td>
							<input type="text" name="map[num]" style="width: 45px;" maxlength="12"
								class="digits required" value="${bean.map.num}" onchange="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[discount]" style="width: 45px" maxlength="12"
								class="number required" value="${bean.map.discount}"
								onchange="setMultiply_sell('realprice', 'num', 'realsum');
								setAllSum('realsum', 'allrealsum', 'sellJspFormId');"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realsum]" style="width: 65px;" maxlength="12"
								class="number" value="${bean.map.realsum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[sort]" style="width: 35px;" maxlength="4"
								class="number" value="${bean.map.sort}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 240px;" maxlength="256"
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
			<shiro:hasPermission name="Sell:edi">
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			</shiro:hasPermission>
			</c:if>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button"
				onclick="window.open('<%=path%>/sell/edi/${form.map.sellid}?act=print');">打印</button></div></div></li>
		</ul>
	</div>
</form>