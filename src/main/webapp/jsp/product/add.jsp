<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	$(function() {
		autoCom("[name='map[materialno]']:visible");
		
		setTimeout(function() {
			changeValue();
		}, 100);
	});
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
		setMultiply('materialprice', 'materialnum', 'materialsum');
		setAllSum('materialsum', 'costprice');
		setReduction('realprice', 'costprice', 'profit');
	}
	
	// 修改排序的值
	function addRowOther() {
		$("[name='map[sort]']:last").val($("#productRowTbody tr").size()-3);
		autoCom("[name='map[materialno]']:visible");
	}
	
	// 重新计算成本、利润
	function delRowOther() {
		setAllSum('materialsum', 'costprice');
		setReduction('realprice', 'costprice', 'profit');
	}
	
	function autoCom(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.post(
						"<%=path%>/material/getMaterialsByKeyword",
						{keyword : request.term},
						function(data) {
							response($.map(data, function(item) {
			                    return {
			                        label: item.map.materialno + "　" + item.map.materialname,
			                        value: item.map.materialno,
			                        materialname: item.map.materialname,
			                        materialid: item.map.materialid,
			                        price: item.map.price,
			                        manuname: item.map.manuname
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
					row.find("[name='map[materialprice]']").val(ui.item.price);
					row.find("[name='map[manuname]']").val(ui.item.manuname);
					
					changeValue();// 重新计算
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
</script>

<form method="post" action="<%=path%>/product/add" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="curTime" value="${curTime}"/>
	<div class="pageFormContent" layoutH="52">
		<dl>
			<dt>产品编码：</dt>
			<dd>
				<input type="text" name="map[productno]" class="required" size="25" maxlength="17"
					value="${form.map.productno}"
					remote="<%=path%>/checkOnlyone/product/-1" />
			</dd>
		</dl>
		<dl>
			<dt>产品名称：</dt>
			<dd>
				<input type="text" name="map[productname]" class="required" size="25" maxlength="32"
					value="${form.map.productname}"/>
			</dd>
		</dl>
		<dl>
			<dt>一盒数量：</dt>
			<dd>
				<input type="text" name="map[numofcase]" class="required digits" size="25" maxlength="999"/>
			</dd>
		</dl>
		<dl>
			<dt>一件数量：</dt>
			<dd>
				<input type="text" name="map[numofonebox]" class="required digits" size="25" maxlength="999"/>
			</dd>
		</dl>
		<dl>
			<dt>排序：</dt>
			<dd>
				<input type="text" name="map[productsort]" class="digits" size="25" maxlength="99"
					value="50"/>
			</dd>
		</dl>
		<dl>
			<dt>买家：</dt>
			<dd>
				<input type="text" name="map[buyers]" size="25" maxlength="128" value=""/>
			</dd>
		</dl>
		<dl>
			<dt>产品类型：</dt>
			<dd>
				<input type="hidden" name="map[producttype]" value="${form.map.producttype}"/>
				<input type="text" name="map[producttypename]" size="25" value="${form.map.producttypename}"
					 readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>计量单位：</dt>
			<dd>
				<st:select dictType="计量单位" name="map[unit]" value="${form.map.unit}" expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>成本单价：</dt>
			<dd>
				<input type="text" name="map[costprice]" class="required number" size="25" maxlength="12"
					value="0.00" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>利润：</dt>
			<dd>
				<input type="text" name="map[profit]" class="required number" size="25" maxlength="12"
					value="0.00" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>产品单价：</dt>
			<dd>
				<input type="text" name="map[realprice]" class="required number" size="25" maxlength="12"
					value="0.00" onchange="changeValue();"/>
			</dd>
		</dl>
		<dl>
			<dt>新增时间：</dt>
			<dd>
				<input type="text" name="map[createdate]" size="25" maxlength="19"
					value="${form.map.createdate}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>使用状态：</dt>
			<dd>
				<st:select dictType="状态" name="map[statusid]" value="1"
				 expStr="style='width: 184px;'" />
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="89" maxlength="256"
					value="${form.map.remark}"/>
			</dd>
		</dl>
		
		<div class="divider"></div>
		
		<h1 class="margin10px">产品清单（成本单价=人力成本+其他成本+配件成本）</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="30px">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="30px">序号</th>
					<th width="100px">物资编码</th>
					<th width="120px">物资名称</th>
					<th width="70px">物资单价</th>
					<th width="70px">物资数量</th>
					<th width="70px">物资总价</th>
					<th width="120px">供应商</th>
					<th width="50px">排序</th>
					<th width="70px">采购备注</th>
					<th width="70px">生产备注</th>
					<th>备注</th>
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
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[productrowid]"/>
						<a href="#" class="btnDel delRow"></a>
					</td>
			   		<td></td>
			   		<td>
			   			<input type="hidden" name="map[materialid]" />
						<input type="text" name="map[materialno]" style="width: 50%" maxlength="13"
							suggestFields="materialid,materialno,materialname,materialprice,manuname" />
						<a class="btnLook" href="<%=path%>/material/tree?act=backselect" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear"
						 suggestFields="materialid,materialno,materialname,materialprice,manuname"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 94%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialprice]" style="width: 90%" maxlength="12"
							class="number" value="0.00" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialnum]" style="width: 90%" maxlength="9"
							class="number" value="1" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialsum]" style="width: 90%" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manuname]" style="width: 94%" maxlength="256"
							 readonly="readonly" class="readonly" />
			   		</td>
			   		<td>
						<input type="text" name="map[sort]" style="width: 84%" maxlength="2" class="number"
							value="9"/>
			   		</td>
				   	<td>
						<input type="text" name="map[remarkshow]" style="width: 84%" maxlength="256"/>
				   	</td>
				   	<td>
						<input type="text" name="map[productionshow]" style="width: 84%" maxlength="256"/>
				   	</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 98%" maxlength="256"/>
			   		</td>
			   	</tr>
			   	<tr id="IDEndRow"></tr>
		   	</tbody>
		</table>
	</div>
	
	<div class="formBar">
		<ul>
			<!--
			<li>
				<div class="buttonActive">
					<div class="buttonContent">
						<button type="button" class="btnAdd addRow">新增</button>
					</div>
				</div>
			</li>
			-->
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>