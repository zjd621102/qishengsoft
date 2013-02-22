<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	function checkForSubmit(){
		var manuid = $("input[name='manuLookup.manuid']").val();
		$("input[name='map[manuid]']").val(manuid); //供应商ID
		
		return true;
	}
</script>

<h2 class="contentTitle">新增收付款单</h2>
<form method="post" action="<%=path%>/pay/add" class="required-validate pageForm"
 onsubmit="return checkForSubmit() && validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>单据类型：</dt>
			<dd>
				<select name="map[btype]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${btypeList}" var="btype">
						<option value="${btype.map.btype}"
							${btype.map.btype==form.map.btype?"selected":""}
						>
							${btype.map.btypename}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>付款日期/收款日期：</dt>
			<dd>
				<input type="text" name="map[paydate]" class="required date" style="width: 178px;"
					value="${form.map.paydate}" readonly="readonly"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>供应商/客户：</dt>
			<dd>
				<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
				<input type="hidden" name="manuLookup.manuid" value="${form.map.manuid}"/>
				<input type="text" class="required" name="manuLookup.manuname" value="${form.map.manuname}"
					style="width: 178px;" suggestFields="manuid,manuname"  readonly="readonly"/>
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
					value="${form.map.planmoney}"/>
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
						<c:if test="${currflow.map.flowname!='结束'}">
							<option value="${currflow.map.flowname}"
								${currflow.map.flowname=='申请'?"selected":""}
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
				<input type="text" name="map[remark]" size="30" maxlength="256"
					value="${form.map.remark}"/>
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