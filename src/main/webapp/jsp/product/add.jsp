<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	$(function() {
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
</script>

<h1 class="margin10px">产品信息</h1>
<form method="post" action="<%=path%>/product/add" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="88">
		<dl>
			<dt>产品编码：</dt>
			<dd>
				<input type="text" name="map[productno]" class="required" size="30" maxlength="17"
					value="${form.map.productno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>产品名称：</dt>
			<dd>
				<input type="text" name="map[productname]" class="required" size="30" maxlength="32"
					value="${form.map.productname}"/>
			</dd>
		</dl>
		<dl>
			<dt>产品类型：</dt>
			<dd>
				<input type="hidden" name="map[producttype]" value="${form.map.producttype}"/>
				<input type="text" name="map[producttypename]" size="30" value="${form.map.producttypename}"
					 readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>计量单位：</dt>
			<dd>
				<select name="map[unit]" style="width: 185px;" class="required">
					<option value=""></option>
					<c:forEach items="${unitList}" var="unit">
						<option value="${unit.map.unitid}"
							${unit.map.unitid==form.map.unit?"selected":""}
						>
							${unit.map.unitname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>成本单价：</dt>
			<dd>
				<input type="text" name="map[costprice]" class="required number" size="30" maxlength="12"
					value="0.00" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>利润：</dt>
			<dd>
				<input type="text" name="map[profit]" class="required number" size="30" maxlength="12"
					value="0.00" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>产品单价：</dt>
			<dd>
				<input type="text" name="map[realprice]" class="required number" size="30" maxlength="12"
					value="0.00" onchange="changeValue();"/>
			</dd>
		</dl>
		<dl>
			<dt>新增时间：</dt>
			<dd>
				<input type="text" name="map[createdate]" size="30" maxlength="19"
					value="${form.map.createdate}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="106" maxlength="256"
					value="${form.map.remark}"/>
			</dd>
		</dl>
		
		<div class="divider"></div>
		
		<h1 class="margin10px">产品清单（成本单价=人力成本+其他成本+配件成本）</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="5%">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="5%">序号</th>
					<th width="20%">物资编码</th>
					<th width="20%">物资名称</th>
					<th width="10%">物资单价</th>
					<th width="10%">物资数量</th>
					<th width="10%">物资总价</th>
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
						<input type="text" name="map[materialno]" style="width: 76%" maxlength="13"
							suggestFields="materialno,materialname,materialprice"
							readonly="readonly"></a>
						<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear" suggestFields="materialno,materialname,materialprice"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 96%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialprice]" style="width: 93%" maxlength="12"
							class="number" value="0.00" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialnum]" style="width: 93%" maxlength="9"
							class="number" value="1" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialsum]" style="width: 92%" maxlength="12"
							class="number" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 96%" maxlength="256"/>
			   		</td>
			   	</tr>
				<c:forEach items="${productrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[productrowid]" value="${bean.map.productrowid}"/>
							<a href="#" class="btnDel delRow" onclick="changeValue();"></a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
							<input type="text" name="map[materialno]" style="width: 75%" maxlength="13"
								suggestFields="materialno,materialname,materialprice"
								value="${bean.map.materialno}" readonly="readonly"/>
							<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="materialno,materialname,materialprice"></a>
				   		</td>
				   		<td>
							<input type="text" name="map[materialname]" style="width: 96%" maxlength="32"
								value="${bean.map.materialname}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialprice]" style="width: 93%" maxlength="12"
								class="number" value="${bean.map.materialprice}"
								onblur="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialnum]" style="width: 93%" maxlength="9"
								class="number" value="${bean.map.materialnum}"
								onblur="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialsum]" style="width: 92%" maxlength="12"
								class="number" value="${bean.map.materialsum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 96%" maxlength="256"
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
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>