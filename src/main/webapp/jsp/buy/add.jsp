<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">新增采购单</h1>
<form method="post" action="<%=path%>/buy/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>单据类型：</dt>
			<dd>
				<select name="map[btype]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${btypeList}" var="btype">
						<option value="${btype.map.btype}"
							${btype.map.btype=="CGD"?"selected":""}
						>
							${btype.map.btypename}
						</option>
					</c:forEach>
				</select>
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
			<dt>采购日期：</dt>
			<dd>
				<input type="text" name="map[buydate]" class="required date" style="width: 178px;"
					value="${form.map.buydate}" readonly="true"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>当前流程：</dt>
			<dd>
				<select name="map[currflow]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${currflowList}" var="currflow">
						<c:if test="${currflow.map.flowname!='结束'}">
							<option value="${currflow.map.flowname}"
								${currflow.map.flowname=="申请"?"selected":""}
							>
								${currflow.map.flowname}
							</option>
						</c:if>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="30" maxlength="256" value="${form.map.remark}" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<h1 class="margin10px">采购清单</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="3%">
						<a href="#" class="btnAdd addRow"/>
					</th>
					<th width="3%">序号</th>
					<th width="9%">物资编码</th>
					<th width="10%">物资名称</th>
					<th width="9%">物资类型</th>
					<th width="5%">计量单位</th>
					<th width="7%">预算单价</th>
					<th width="7%">实际单价</th>
					<th width="5%">采购数量</th>
					<th width="10%">实际总价</th>
					<th width="10%">供应商名称</th>
					<th width="7%">联系人</th>
					<th width="7%">联系电话</th>
					<th width="7%">备注</th>
				</tr>
			</thead>
			<tbody>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[buyrowid]"/>
						<input type="hidden" name="map[materialid]"/>
						<a href="#" class="btnDel delRow"/>
					</td>
			   		<td></td>
			   		<td>
						<input type="text" name="map[materialno]" style="width: 100%" maxlength="13"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialtype]" style="width: 100%" maxlength="5"/>
			   		</td>
			   		<td>
						<select name="map[unit]" style="width: 90%;">
							<option value=""></option>
							<c:forEach items="${unitList}" var="unit">
								<option value="${unit.map.unitid}">
									${unit.map.unitname}
								</option>
							</c:forEach>
						</select>
			   		</td>
			   		<td>
						<input type="text" name="map[price]" style="width: 100%" maxlength="12"
							class="double" value="0.00"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realprice]" style="width: 100%" maxlength="12"
							class="double" value="0.00" onchange="getMultiplySum(this, 'realprice', 'num', 'realsum')"/>
			   		</td>
			   		<td>
						<input type="text" name="map[num]" style="width: 100%" maxlength="12"
							class="double" value="0.00" onchange="getMultiplySum(this, 'realprice', 'num', 'realsum')"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 100%" maxlength="12"
							class="double" value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="hidden" name="map[manuid]"/>
						<input type="text" name="map[manuname]"
							suggestFields="manuid,manuname,contact,tel" style="width: 60%" readonly="readonly"/>
						<a class="btnLook" href="<%=path%>/backselect/manu" lookupGroup="manuLookup">
							查找带回
						</a>
						<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname,contact,tel"/>
					</td>
			   		<td>
						<input type="text" name="map[contact]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[tel]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 100%" maxlength="256"/>
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