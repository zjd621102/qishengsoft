<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script src="<%=path%>/js/public.js" type="text/javascript"></script>

<h1 class="margin10px">修改供应商</h1>
<form method="post" action="<%=path%>/manu/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
 	<input type="hidden" name="map[manuid]" value="${form.map.manuid}" />
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>供应商名称：</dt>
			<dd>
				<input type="text" name="map[manuname]" class="required" size="30" maxlength="32" alt="请输入供应商名称"
					 value="${form.map.manuname}"/>
			</dd>
		</dl>
		<dl>
			<dt>供应商类别：</dt>
			<dd>
				<select name="map[manutypeid]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${manuTypeList}" var="manuType">
						<option value="${manuType.map.manutypeid}"
							${manuType.map.manutypeid==form.map.manutypeid?"selected":""}
						>
							${manuType.map.manutypename}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>供应商状态：</dt>
			<dd>
				<select name="map[statusid]" style="width: 184px;" class="required">
					<option value=""></option>
					<c:forEach items="${statusList}" var="status">
						<option value="${status.map.statusid}"
							${status.map.statusid==form.map.statusid?"selected":""}
						>
							${status.map.statusname}
						</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt>联系人：</dt>
			<dd>
				<input type="text" name="map[contact]" class="required" size="30" maxlength="32" alt="请输入联系人"
					 value="${form.map.contact}"/>
			</dd>
		</dl>
		<dl>
			<dt>联系电话：</dt>
			<dd>
				<input type="text" name="map[tel]" class="required" size="30" maxlength="32" alt="请输入联系电话"
					 value="${form.map.tel}"/>
			</dd>
		</dl>
		<dl>
			<dt>EMAIL：</dt>
			<dd>
				<input type="text" name="map[email]" class="required" size="30" maxlength="64" value="${form.map.email}"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="30" maxlength="512" value="${form.map.remark}" />
			</dd>
		</dl>
		<dl>
			<dt>创建日期：</dt>
			<dd>
				<input type="text" name="map[createdate]" size="30" maxlength="32"
					value="${form.map.createdate}" readonly/>
			</dd>
		</dl>
		
		<div class="divider"></div>

		<h1 class="margin10px">银行帐户信息</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="5%">
						<a href="#" onclick="addRow();">
							<img src="<%=path%>/images/bt_plus.gif" border="0" />
						</a>
					</th>
					<th width="5%">序号</th>
					<th width="20%">开户银行</th>
					<th width="20%">公司银行账号</th>
					<th width="20%">帐户名称</th>
					<th width="10%">优先级</th>
					<th width="20%">备注</th>
				</tr>
			</thead>
			<tbody>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[manurowid]" value="${bean.map.manurowid}"/>
						<a href="#" onclick="delRow();">
							<img src="<%=path%>/images/bt_minus.gif" border="0" />
						</a>
					</td>
			   		<td></td>
			   		<td>
						<input type="text" name="map[bankrow]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[accountnorow]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[accountnamerow]" style="width: 100%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[priorityrow]" class="digits" style="width: 100%" maxlength="2"
							value="9"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 100%" maxlength="255"/>
			   		</td>
			   	</tr>
				<c:forEach items="${manurowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[manurowid]" value="${bean.map.manurowid}"/>
							<a href="#" onclick="delRow();">
								<img src="<%=path%>/images/bt_minus.gif" border="0" />
							</a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
							<input type="text" name="map[bankrow]" maxlength="32" style="width: 100%"
								value="${bean.map.bankrow}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[accountnorow]" maxlength="32" style="width: 100%"
								value="${bean.map.accountnorow}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[accountnamerow]" maxlength="32" style="width: 100%"
								value="${bean.map.accountnamerow}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[priorityrow]" class="digits" maxlength="2" style="width: 100%"
								value="${bean.map.priorityrow}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" maxlength="255" style="width: 100%"
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