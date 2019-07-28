<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script>
	$(function() {
		autoCom("[name='map[materialno]']:visible");
		
		$('.addRow').trigger("click");// 自动触发新增一行事件
	});
	
	function addRowOther() {
		autoCom("[name='map[materialno]']:last");
	}
	
	// 重新计算金额
	function delRowOther() {
		setAllSum('sum', 'allsum');
	}
	
	function autoCom(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.post(
						"<%=path%>/material/getSelectByKeyword",
						{keyword : request.term},
						function(data) {
							response($.map(data, function(item) {
			                    return {
			                        label: item.map.materialno + "　" + item.map.materialname,
			                        value: item.map.materialno,
			                        materialname: item.map.materialname,
			                        materialid: item.map.materialid,
			                        unit: item.map.unit,
			                        price: item.map.price,
			                 		manuid: item.map.manuid,
			                 		manuname: item.map.manuname,
			                        manucontact: item.map.manucontact,
			                        manutel: item.map.manutel,
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
					row.find("[name='map[materialname]']").val(ui.item.materialname);
					row.find("[name='map[materialid]']").val(ui.item.materialid);
					row.find("[name='map[unit]']").val(ui.item.unit);
					row.find("[name='map[price]']").val(ui.item.price);
					row.find("[name='map[manuid]']").val(ui.item.manuid);
					row.find("[name='map[manuname]']").val(ui.item.manuname);
					row.find("[name='map[manucontact]']").val(ui.item.manucontact);
					row.find("[name='map[manutel]']").val(ui.item.manutel);
					row.find("[name='map[numofonebox]']").val(ui.item.numofonebox);
					
					// 修改采购单名称
					var buyname = $("#buyname").val();
					if(/采购/.test(buyname)) {
						$("#buyname").val(buyname.replace("采购", ui.item.manuname))
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
	
	/**
	 * 重写提交之前操作
	 * @returns {Boolean}
	 */
	function doBeforeSubmit() {

		changeValue();
		return true;
	}
	 
	/**
	 * 计算价格
	 */
	function changeValue() {
		setMultiply_buy('price', 'num', 'sum');
		setAllSum('sum', 'allsum');
	}
	
	/**
	 * 重写方法 - 赋值相乘的值
	 * @param name1 相乘字段
	 * @param name2 相乘字段
	 * @param name3 赋值字段
	 * @param obj 	所在行的对象
	 */
	function setMultiply_buy(name1, name2, name3) {
		$("input[name*='map[" + name1 + "]']").each(function() {
			var row = $(this).parents("tr:first");
			var realprice = row.find("[name*='map[" + name1 + "]']").val();
			var num = row.find("[name*='map[" + name2 + "]']").val();
			var discount = row.find("[name*='map[discount]']").val();
			var realsum = (multiply(realprice, num)*discount).toFixed(2);// 四舍五入为2位小数
			row.find("[name*='map[" + name3 + "]']").val(realsum);
		});
	}

	/**
	 * 修改折扣
	 */
	function changeDiscount() {
		var changeDiscount = $("#changediscount").val();
		$("[name*='map[discount]']").val(changeDiscount);
		setMultiply_buy('price', 'num', 'sum');
		setAllSum('sum', 'allsum');
	}
</script>

<form method="post" action="<%=path%>/buy/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);" style="margin-top: -10px;">
	<div class="pageFormContent" layoutH="42">
		<dl>
			<dt>单据类型：</dt>
			<dd>
				<select name="map[btype]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${btypeList}" var="btype">
						<option value="${btype.map.dictvalue}">
							${btype.map.dictname}
						</option>
					</c:forEach>
				</select>
				<span class="_required">✽</span>
			</dd>
		</dl>
		<dl>
			<dt>采购单名称：</dt>
			<dd>
				<input type="text" name="map[buyname]" id="buyname" class="required" size="25" maxlength="32"
					 value="${form.map.buyname}"/>
			</dd>
		</dl>
		<dl>
			<dt>采购日期：</dt>
			<dd>
				<input type="text" name="map[buydate]" class="required date" style="width: 178px;"
					value="${form.map.buydate}" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
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
			<dt>已付款：</dt>
			<dd>
				<input type="text" name="map[paymentmade]" class="required number" size="25" maxlength="12" value="0.00"/>
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

		<h1 class="margin10px">采购清单</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="30px">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="30px">序号</th>
					<th width="82px">物资编码</th>
					<th width="120px">物资名称</th>
					<!--
					<th width="60px">计量单位</th>
					-->
					<th width="65px">单价</th>
					<th width="65px">数量</th>
					<th width="60px">折扣</th>
					<th width="75px">总价</th>
					<th width="55px">一件数量</th>
					<th width="100px">供应商名称</th>
					<!-- 
					<th width="7%">联系人</th>
					<th width="8%">联系电话</th>
					-->
					<th width="40px">排序</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<!--
					<td></td>
					-->
					<td></td>
					<td></td>
					<td>
						<input type="text" id="changediscount" name="map[alldiscount]" style="width: 45px"
							class="number required" value="1" onchange="changeDiscount();"/>
					</td>
					<td>
						<input type="text" name="map[allsum]" style="width: 59px" class="number"
							value="" readonly="readonly"/>
					</td>
					<td></td>
					<td></td>
				   	<!--
					<td></td>
					<td></td>
					-->
					<td></td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[buyrowid]"/>
						<a href="#" class="btnDel delRow"></a>
					</td>
			   		<td></td>
			   		<td>
						<input type="hidden" name="map[materialid]"/>
						<input type="text" name="map[materialno]" style="width: 50px; margin-right: 5px;" maxlength="13"
							suggestFields="materialid,materialno,materialname,unit,price,manuid,manuname,manucontact,manutel" />
						<!-- 
						<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
						-->
						<a href="javascript:void(0);" class="btnClear"
							suggestFields="materialid,materialno,materialname,unit,price,manuid,manuname,manucontact,manutel,num,sum"></a>
			   		 	
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 100px;" maxlength="32" class="required"/>
			   		</td>
			   		<!--
			   		<td>
			   			<st:select dictType="计量单位" name="map[unit]" expStr="style='width: 100%;'" />
			   		</td>
			   		-->
			   		<td>
						<input type="text" name="map[price]" style="width: 50px" maxlength="12"
							class="number required" value="0.00" onchange="setMultiply_buy('price', 'num', 'sum');
							setAllSum('sum', 'allsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[num]" style="width: 50px" maxlength="12"
							class="number required" value="0.00" onchange="setMultiply_buy('price', 'num', 'sum');
							setAllSum('sum', 'allsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[discount]" style="width: 45px" maxlength="12"
							class="number required" value="1" onchange="setMultiply_buy('price', 'num', 'sum');
							setAllSum('sum', 'allsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sum]" style="width: 59px" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[numofonebox]" style="width: 40px;" maxlength="12"
							value="" readonly="readonly" />
			   		</td>
			   		<td>
						<input type="hidden" name="map[manuid]"/>
						<input type="text" name="map[manuname]" style="width: 85px" readonly="readonly"/>
			   		</td>
			   		<!-- 
			   		<td>
						<input type="text" name="map[manucontact]" style="width: 93%" maxlength="32" class="required"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manutel]" style="width: 94%" maxlength="32" class="required"/>
			   		</td>
			   		-->
			   		<td>
						<input type="text" name="map[sort]" style="width: 27px;" maxlength="2" class="number"
							value=""/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 95%" maxlength="256"/>
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