<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">修改发票</h2>
<form method="post" action="<%=path%>/pay/edi" class="required-validate pageForm"
	onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
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
			<dt>发票日期：</dt>
			<dd>
				<input type="text" name="map[paydate]" class="required date" size="30"
					value="${form.map.paydate}" readonly="true"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
			</dd>
		</dl>
		<dl>
			<dt>关联单号：</dt>
			<dd>
				<input type="text" name="map[relateno]" size="30" maxlength="17"
					value="${form.map.relateno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>关联金额：</dt>
			<dd>
				<input type="text" name="map[relatemoney]" class="number" size="30" maxlength="12"
					value="${form.map.relatemoney}" readonly="readonly"/>
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
	
		<div class="divider"></div>

		<h1 class="margin10px">发票清单</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="3%">
						<a href="#" class="btnAdd addRow"/>
					</th>
					<th width="3%">序号</th>
					<th width="19%">银行卡卡号</th>
					<th width="15%">供应商</th>
					<th width="13%">供应商开户银行</th>
					<th width="13%">供应商银行卡卡号</th>
					<th width="10%">供应商账户名称</th>
					<th width="7%">应付金额</th>
					<th width="7%">实付金额</th>
					<th width="10%">备注</th>
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
						小计：
					</td>
					<td>
						<input type="text" name="map[allplansum]" style="width: 100%" class="number"
							value="${form.map.allplansum}" readonly="readonly"/>
					</td>
					<td>
						<input type="text" name="map[allrealsum]" style="width: 100%" class="number"
							value="${form.map.allrealsum}" readonly="readonly"/>
					</td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[payrowid]"/>
						<a href="#" class="btnDel delRow" />
					</td>
			   		<td>${vs.index+1}</td>
					<td>
						<select name="map[bankcardno]" style="width: 95%;" class="notnull" alt="银行卡卡号">
							<option value=""></option>
							<c:forEach items="${bankcardList}" var="bankcard">
								<option value="${bankcard.map.bankcardno}">
									${bankcard.map.bankcardno}|${bankcard.map.bankname}
								</option>
							</c:forEach>
						</select>
					</td>
			   		<td>
						<input type="hidden" name="map[manuid]"/>
						<input type="text" name="map[manuname]"
							suggestFields="manuid,manuname,manubankname,manubankcardno,manuaccountname"
							style="width: 75%" readonly="readonly"/>
						<a class="btnLook" href="<%=path%>/manu/list" lookupGroup="manuLookup"/>
						<a href="javascript:void(0);" class="btnClear"
							suggestFields="manuid,manuname,manubankname,manubankcardno,manuaccountname"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manubankname]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manubankcardno]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manuaccountname]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[plansum]" style="width: 100%" maxlength="12"
							class="number" value="0.00"
							onchange="setAllSum('plansum', 'allplansum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[realsum]" style="width: 100%" maxlength="12"
							class="number" value="0.00"
							onchange="setAllSum('realsum', 'allrealsum');"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 100%" maxlength="256"/>
			   		</td>
			   	</tr>
				<c:forEach items="${payrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[payrowid]" value="${bean.map.payrowid}"/>
							<a href="#" class="btnDel delRow" />
						</td>
				   		<td>${vs.index+1}</td>
						<td>
							<select name="map[bankcardno]" style="width: 95%;" class="notnull" alt="银行卡卡号">
								<option value=""></option>
								<c:forEach items="${bankcardList}" var="bankcard">
									<option value="${bankcard.map.bankcardno}"
										${bankcard.map.bankcardno==bean.map.bankcardno?"selected":""}
									>
										${bankcard.map.bankcardno}|${bankcard.map.bankname}
									</option>
								</c:forEach>
							</select>
						</td>
				   		<td>
							<input type="hidden" name="map[manuid]" value="${bean.map.manuid}"/>
							<input type="text" name="map[manuname]" value="${bean.map.manuname}"
								suggestFields="manuid,manuname,manubankname,manubankcardno,manuaccountname"
								style="width: 75%" readonly="readonly"/>
							<a class="btnLook" href="<%=path%>/manu/list" lookupGroup="manuLookup"/>
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="manuid,manuname,manubankname,manubankcardno,manuaccountname"/>
				   		</td>
				   		<td>
							<input type="text" name="map[manubankname]" style="width: 100%" maxlength="32"
								value="${bean.map.manubankname}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[manubankcardno]" style="width: 100%" maxlength="32"
								value="${bean.map.manubankcardno}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[manuaccountname]" style="width: 100%" maxlength="32"
								value="${bean.map.manuaccountname}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[plansum]" style="width: 100%" maxlength="12"
								class="number" value="${bean.map.plansum}"
								onchange="setAllSum('plansum', 'allplansum');"/>
				   		</td>
				   		<td>
							<input type="text" name="map[realsum]" style="width: 100%" maxlength="12"
								class="number" value="${bean.map.realsum}"
								onchange="setAllSum('realsum', 'allrealsum');"/>
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
			<li><div class="button"><div class="buttonContent"><button type="button"
				onclick="window.open('<%=path%>/pay/edi/${form.map.payid}?act=print');">打印</button></div></div></li>
		</ul>
	</div>
</form>