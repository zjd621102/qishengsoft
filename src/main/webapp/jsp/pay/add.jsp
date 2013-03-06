<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">新增发票</h2>
<form method="post" action="<%=path%>/pay/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
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
			<dt>发票日期：</dt>
			<dd>
				<input type="text" name="map[paydate]" class="required date" size="30"
					value="${form.map.paydate}" readonly="readonly"/>
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