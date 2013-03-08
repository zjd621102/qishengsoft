<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script language="javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script language="javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script language="javascript" src="<%=path%>/js/print.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />

<br />
<input type="button" onclick="funPrint()" value="打印"/>
<input type="button" onclick="window.close()" value="关闭"/>
<br /><br />

<div id="printdiv">
	<h2>修改发票</h2>
	<table style="width: 100%;">
		<tr>
			<td>单据类型：
				<span>${form.map.btypename}</span>
			</td>
			<td>制单人：
				<span>${form.map.makername}</span>
			</td>
			<td>发票日期：
				<span>${form.map.paydate}</span>
			</td>
		</tr>
		<tr>
			<td>关联单号：
				<span>${form.map.relateno}</span>
			</td>
			<td>关联金额：
				<span>${form.map.relatemoney}</span>
			</td>
			<td>当前流程：
				<span>${form.map.currflow}</span>
			</td>
		</tr>
		<tr>
			<td>创建时间：
				<span>${form.map.createtime}</span>
			</td>
			<td colspan="2">备注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>发票清单</h2>

	<table class="table" style="width: 100%;">
		<thead>
			<tr>
				<td width="6%">序号</td>
				<td width="16%">银行卡卡号</td>
				<td width="15%">供应商</td>
				<td width="13%">供应商开户银行</td>
				<td width="15%">供应商银行卡卡号</td>
				<td width="13%">供应商账户名称</td>
				<td width="7%">应付金额</td>
				<td width="7%">实付金额</td>
				<td width="8%">备注</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="5"></td>
				<td>
					小计：
				</td>
				<td>
					<span>${form.map.allplansum}</span>
				</td>
				<td>
					<span>${form.map.allrealsum}</span>
				</td>
				<td></td>
			</tr>
			<c:forEach items="${payrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td>
			   			<span>${vs.index+1}</span>
			   		</td>
					<td>
						<span>${bean.map.bankcardno}</span>
					</td>
			   		<td>
						<span>${bean.map.manuname}</span>
			   		</td>
			   		<td>
						<span>${bean.map.manubankname}</span>
			   		</td>
			   		<td>
						<span>${bean.map.manubankcardno}</span>
			   		</td>
			   		<td>
						<span>${bean.map.manuaccountname}</span>
			   		</td>
			   		<td>
						<span>${bean.map.plansum}</span>
			   		</td>
			   		<td>
						<span>${bean.map.realsum}</span>
			   		</td>
			   		<td>
						<span>${bean.map.remarkrow}</span>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>