<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">修改收付款单</h2>
<form method="post" action="<%=path%>/pay/edi" class="required-validate pageForm"
	onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[payid]" value="${form.map.payid}" />
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>单据类型：</dt>
			<dd>
				<input type="hidden" name="map[btype]" value="${form.map.btype}" />
				<input type="text" name="map[btypename]" size="30" value="${form.map.btypename}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>制单人：</dt>
			<dd>
				<input type="hidden" name="map[maker]" value="${form.map.maker}" />
				<input type="text" name="map[makername]" class="required" size="30" maxlength="64"
					value="${form.map.makername}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>付款日期/收款日期：</dt>
			<dd>
				<input type="text" name="map[paydate]" class="required date" size="30"
					value="${form.map.paydate}" readonly="true"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>供应商/客户：</dt>
			<dd>
				<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
				<input type="text" class="required" name="map[manuname]" value="${form.map.manuname}"
					size="30" suggestFields="manuid,manuname"  readonly="readonly"/>
				<a class="btnLook" href="<%=path%>/backselect/manu" lookupGroup="manuLookup">查找带回</a>
			</dd>
		</dl>
		<dl>
			<dt>银行卡卡号：</dt>
			<dd>
				<select name="map[bankcardno]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${bankcardList}" var="bankcard">
						<option value="${bankcard.map.bankcardno}"
							${bankcard.map.bankcardno==form.map.bankcardno?"selected":""}
						>
							${bankcard.map.bankcardno}|${bankcard.map.bankname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>采购单号/销售单号：</dt>
			<dd>
				<input type="text" name="map[relateid]" class="required digits" size="30" maxlength="9"
					value="${form.map.relateid}"/>
			</dd>
		</dl>
		<dl>
			<dt>应付金额：</dt>
			<dd>
				<input type="text" name="map[planmoney]" class="required number" size="30" maxlength="12"
					value="${form.map.planmoney}"/>
			</dd>
		</dl>
		<dl>
			<dt>实付金额：</dt>
			<dd>
				<input type="text" name="map[realmoney]" class="required number" size="30" maxlength="12"
					value="${form.map.realmoney}"/>
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
			<dt>创建时间：</dt>
			<dd>
				<input type="text" name="map[createtime]" class="required" size="30" maxlength="19"
					value="${form.map.createtime}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="30" maxlength="256"
					value="${form.map.remark}"/>
			</dd>
		</dl>
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