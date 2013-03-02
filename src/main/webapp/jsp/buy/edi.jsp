<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">修改采购单</h1>
<form method="post" action="<%=path%>/buy/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[buyid]" value="${form.map.buyid}" />
	<div class="pageFormContent" layoutH="97">
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
				<input type="text" name="map[buyno]" class="required" size="30" maxlength="13"
					 value="${form.map.buyno}" readonly="readonly"/>
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
					<th width="10%">物资类型</th>
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
				<c:forEach items="${buyrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[buyrowid]" value="${bean.map.buyrowid}"/>
							<input type="hidden" name="map[materialid]" value="${bean.map.materialid}"/>
							<a href="#" class="btnDel delRow" />
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
							<input type="text" name="map[materialno]" style="width: 100%" maxlength="13"
								value="${bean.map.materialno}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialname]" style="width: 100%" maxlength="32"
								value="${bean.map.materialname}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialtype]" style="width: 100%" maxlength="5"
								value="${bean.map.materialtype}"/>
				   		</td>
				   		<td>
							<select name="map[unit]" style="width: 90%;">
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
							<input type="text" name="map[price]" style="width: 100%" maxlength="12"
								class="double" value="${bean.map.price}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realprice]" style="width: 100%" maxlength="12"
								class="double" value="${bean.map.realprice}"
								onchange="getMultiplySum(this, 'realprice', 'num', 'realsum')"/>
				   		</td>
				   		<td>
							<input type="text" name="map[num]" style="width: 100%" maxlength="12"
								class="double" value="${bean.map.num}"
								onchange="getMultiplySum(this, 'realprice', 'num', 'realsum')"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realsum]" style="width: 100%" maxlength="12"
								class="double" value="${bean.map.realsum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="hidden" name="map[manuid]" value="${bean.map.manuid}"/>
							<input type="text" name="map[manuname]" value="${bean.map.manuname}"
								suggestFields="manuid,manuname,contact,tel" style="width: 60%" readonly="readonly"/>
							<a class="btnLook" href="<%=path%>/backselect/manu" lookupGroup="manuLookup">
								查找带回
							</a>
							<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname,contact,tel"/>
				   		</td>
				   		<td>
							<input type="text" name="map[contact]" style="width: 100%" maxlength="32"
								value="${bean.map.contact}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[tel]" style="width: 100%" maxlength="32"
								value="${bean.map.tel}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 100%" maxlength="256"
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
		</ul>
	</div>
</form>