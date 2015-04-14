<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=path%>/material/add" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="curTime" value="${curTime}"/>
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>物资编码：</dt>
				<dd>
					<input type="text" name="map[materialno]" class="required" size="25" maxlength="17"
						value="${form.map.materialno}"
						remote="<%=path%>/checkOnlyone/material/-1" />
				</dd>
			</dl>
			<dl>
				<dt>物资名称：</dt>
				<dd>
					<input type="text" name="map[materialname]" class="required" size="25" maxlength="32"
						value="${form.map.materialname}"/>
				</dd>
			</dl>
			<dl>
				<dt>物资类型：</dt>
				<dd>
					<input type="hidden" name="map[materialtype]" value="${form.map.materialtype}"/>
					<input type="text" name="map[materialtypename]" size="25" value="${form.map.materialtypename}"
						 readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>计量单位：</dt>
				<dd>
					<st:select dictType="计量单位" id="map[unit]" name="map[unit]" value="${form.map.unit}"
					 expStr="style='width: 184px;' class='required number'" />
				</dd>
			</dl>
			<dl>
				<dt>单价：</dt>
				<dd>
					<input type="text" name="map[price]" class="required number" size="25" maxlength="12"
						value="${form.map.price}"/>
				</dd>
			</dl>
			<dl>
				<dt>供应商：</dt>
				<dd>
					<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
					<input type="text" name="map[manuname]" value="${form.map.manuname}"
						size="25" suggestFields="manuid,manuname" readonly="readonly"/>
					<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=1" lookupGroup="manuLookup"
						width="1000" height="500">查找带回</a>
					<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname"></a>
				</dd>
			</dl>
			<dl>
				<dt>启用库存：</dt>
				<dd>
					<st:select dictType="是否" name="map[usestock]" value="0" expStr="style='width: 184px;'" />
				</dd>
			</dl>
			<dl>
				<dt>库存量：</dt>
				<dd>
					<input type="text" name="map[stock]" class="required number" size="25" maxlength="12"
						value="0"/>
				</dd>
			</dl>
			<dl>
				<dt>报警量：</dt>
				<dd>
					<input type="text" name="map[alarmnum]" class="required number" size="25" maxlength="12"
						value="0"/>
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
				<dt>备注：</dt>
				<dd>
					<textarea name="map[remark]" cols="90" rows="5" maxlength="256"></textarea>
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
</div>