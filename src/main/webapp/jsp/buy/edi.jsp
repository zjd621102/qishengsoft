<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script>
	$(function() {
		autoCom("[name='map[materialno]']:visible");
		
		setTimeout(function() {
			setAllSum('sum', 'allsum');
		}, 100);
	});
	
	function addRowOther() {
		autoCom("[name='map[materialno]']:last");
	}
	
	function autoCom(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.ajax({
						url : "<%=path%>/material/getSelectByKeyword",
						dataType : "json",
						data : {
							keyword : request.term
						},
						success : function(data) {
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
			                        manutel: item.map.manutel
			                    }
			                }));
						}
					});
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

		setMultiply('price', 'num', 'sum');
		setAllSum('sum', 'allsum');
		return true;
	}
</script>

<h1 class="margin10px">采购单信息</h1>
<form method="post" action="<%=path%>/buy/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[buyid]" value="${form.map.buyid}" />
	<div class="pageFormContent" layoutH="88">
		<dl>
			<dt>单据类型：</dt>
			<dd>
				<input type="hidden" name="map[btype]" value="${form.map.btype}" />
				<input type="text" name="map[btypename]" size="30" value="${form.map.btypename}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>采购单名称：</dt>
			<dd>
				<input type="text" name="map[buyname]" class="required" size="30" maxlength="32"
					 value="${form.map.buyname}"/>
			</dd>
		</dl>
		<dl>
			<dt>采购编号：</dt>
			<dd>
				<input type="text" name="map[buyno]" class="required" size="30" maxlength="16"
					 value="${form.map.buyno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>关联编号：</dt>
			<dd>
				<input type="text" name="map[relateno]" size="30" maxlength="16"
					 value="${form.map.relateno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>采购日期：</dt>
			<dd>
				<input type="text" name="map[buydate]" class="required date" size="27"
					value="${form.map.buydate}" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>当前流程：</dt>
			<dd>
				<st:select dictType="流程状态" name="map[currflow]" value="${form.map.currflow}" expStr="style='width: 213px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>制单人：</dt>
			<dd>
				<input type="hidden" name="map[maker]" value="${form.map.maker}" />
				<input type="text" name="map[makername]" class="required" size="30" maxlength="16"
					value="${form.map.makername}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>创建日期：</dt>
			<dd>
				<input type="text" name="map[createtime]" size="30" maxlength="19"
					value="${form.map.createtime}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="157" maxlength="256" value="${form.map.remark}" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<h1 class="margin10px">采购清单</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="3%">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="3%">序号</th>
					<th width="10%">物资编码</th>
					<th width="15%">物资名称</th>
					<th width="5%">计量单位</th>
					<th width="7%">单价</th>
					<th width="5%">数量</th>
					<th width="7%">总价</th>
					<th width="10%">供应商名称</th>
					<th width="7%">联系人</th>
					<th width="8%">联系电话</th>
					<th width="20%">备注</th>
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
					<td style="font-size: 13px; font-weight: bold; color: red;">
						合计：
					</td>
					<td>
						<input type="text" name="map[allsum]" style="width: 93%" class="number"
							value="" readonly="readonly"/>
					</td>
					<td></td>
					<td></td>
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
						<input type="text" name="map[materialno]" style="width: 60%" maxlength="13"
							suggestFields="materialid,materialno,materialname,unit,price,manuid,manuname,manucontact,manutel" />
						<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear"
							suggestFields="materialid,materialno,materialname,unit,price,manuid,manuname,manucontact,manutel,num,sum"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 96%" maxlength="32" class="required"/>
			   		</td>
			   		<td>
			   			<st:select dictType="计量单位" name="map[unit]" expStr="style='width: 100%;'" />
			   		</td>
			   		<td>
						<input type="text" name="map[price]" style="width: 93%" maxlength="12"
							class="number required" value="0.00" onchange="setMultiply('price', 'num', 'sum');
							setAllSum('sum', 'allsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[num]" style="width: 90%" maxlength="12"
							class="number required" value="0.00" onchange="setMultiply('price', 'num', 'sum');
							setAllSum('sum', 'allsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sum]" style="width: 93%" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="hidden" name="map[manuid]"/>
						<input type="text" name="map[manuname]" style="width: 94%" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manucontact]" style="width: 93%" maxlength="32" class="required"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manutel]" style="width: 94%" maxlength="32" class="required"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 97%" maxlength="256"/>
			   		</td>
			   	</tr>
				<c:forEach items="${buyrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[buyrowid]" value="${bean.map.buyrowid}"/>
							<a href="#" class="btnDel delRow"></a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
							<input type="hidden" name="map[materialid]" value="${bean.map.materialid}"/>
							<input type="text" name="map[materialno]" style="width: 60%" maxlength="13"
								suggestFields="materialid,materialno,materialname,unit,price,manuid,manuname,manucontact,manutel"
								value="${bean.map.materialno}"/>
							<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="materialid,materialno,materialname,unit,price,manuid,manuname,manucontact,manutel,num,sum"></a>
				   		</td>
				   		<td>
							<input type="text" name="map[materialname]" style="width: 96%" maxlength="32"
								value="${bean.map.materialname}" class="required"/>
				   		</td>
				   		<td>
							<st:select dictType="计量单位" name="map[unit]" value="${bean.map.unit}" expStr="style='width: 100%;'" />
				   		</td>
				   		<td>
							<input type="text" name="map[price]" style="width: 93%" maxlength="12"
								class="number required" value="${bean.map.price}"
								onchange="setMultiply('price', 'num', 'sum');
								setAllSum('sum', 'allsum');"/>
				   		</td>
				   		<td>
							<input type="text" name="map[num]" style="width: 90%" maxlength="12"
								class="number required" value="${bean.map.num}"
								onchange="setMultiply('price', 'num', 'sum');
								setAllSum('sum', 'allsum');"/>
				   		</td>
				   		<td>
							<input type="text" name="map[sum]" style="width: 93%" maxlength="12"
								class="number" value="${bean.map.sum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="hidden" name="map[manuid]" value="${bean.map.manuid}"/>
							<input type="text" name="map[manuname]" value="${bean.map.manuname}"
								style="width: 94%" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[manucontact]" style="width: 93%" maxlength="32"
								value="${bean.map.manucontact}" class="required"/>
				   		</td>
				   		<td>
							<input type="text" name="map[manutel]" style="width: 94%" maxlength="32"
								value="${bean.map.manutel}" class="required"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 97%" maxlength="256"
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
				onclick="window.open('<%=path%>/buy/edi/${form.map.buyid}?act=print');">打印</button></div></div></li>
		</ul>
	</div>
</form>