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
	<h2>销售单</h2>
	<table style="width: 100%;">
		<tr>
			<td>销售编号：
				<span>${form.map.sellno}</span>
			</td>
			<td>销售日期：
				<span>${form.map.selldate}</span>
			</td>
			<td>客户名称：
				<span>${form.map.manuname}</span>
			</td>
		</tr>
		<tr>
			<td>当前流程：
				<span>${form.map.currflow}</span>
			</td>
			<td>制单人：
				<span>${form.map.makername}</span>
			</td>
			<td>创建日期：
				<span>${form.map.createtime}</span>
			</td>
		</tr>
		<tr>
			<td colspan="3">备注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>销售清单</h2>

	<table class="table" style="width: 100%;">
		<thead>
			<tr>
				<td width="6%">序号</<td>
				<td width="15%">产品编码</td>
				<td width="15%">产品名称</td>
				<td width="10%">计量单位</td>
				<td width="10%">应付单价</td>
				<td width="10%">实付单价</td>
				<td width="10%">数量</td>
				<td width="10%">实付总价</td>
				<td width="14%">备注</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="6"></td>
				<td>
					合计：
				</td>
				<td>
					<span>${form.map.allrealsum}</span>
				</td>
				<td></td>
			</tr>
			<c:forEach items="${sellrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td>
			   			<span>${vs.index+1}</span>
			   		</td>
			   		<td>
						<span>${bean.map.productno}</span>
			   		</td>
			   		<td>
						<span>${bean.map.productname}</span>
			   		</td>
			   		<td>
						<span>${bean.map.unitname}</span>
			   		</td>
			   		<td>
						<span>${bean.map.planprice}</span>
			   		</td>
			   		<td>
						<span>${bean.map.realprice}</span>
			   		</td>
			   		<td>
						<span>${bean.map.num}</span>
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