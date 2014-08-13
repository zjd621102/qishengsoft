<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">物资信息</h1>
<form method="post" action="<%=path%>/material/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="88">
		<dl>
			<dt>物资编码：</dt>
			<dd>
				<input type="text" name="map[materialno]" class="required" size="30" maxlength="17"
					value="${form.map.materialno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>物资名称：</dt>
			<dd>
				<input type="text" name="map[materialname]" class="required" size="30" maxlength="32"
					value="${form.map.materialname}"/>
			</dd>
		</dl>
		<dl>
			<dt>物资类型：</dt>
			<dd>
				<input type="hidden" name="map[materialtype]" value="${form.map.materialtype}"/>
				<input type="text" name="map[materialtypename]" size="30" value="${form.map.materialtypename}"
					 readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>计量单位：</dt>
			<dd>
				<select name="map[unit]" style="width: 185px;">
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
			<dt>单价：</dt>
			<dd>
				<input type="text" name="map[price]" class="required number" size="30" maxlength="12"
					value="${form.map.price}"/>
			</dd>
		</dl>
		<dl>
			<dt>供应商：</dt>
			<dd>
				<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
				<input type="text" class="required" name="map[manuname]" value="${form.map.manuname}"
					size="30" suggestFields="manuid,manuname" readonly="readonly"/>
				<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=1" lookupGroup="manuLookup"
					width="1000" height="500">查找带回</a>
				<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname"></a>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<textarea name="map[remark]" cols="27" rows="6" maxlength="256"></textarea>
			</dd>
		</dl>
	</div>	
	
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>