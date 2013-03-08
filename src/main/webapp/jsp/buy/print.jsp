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
	<h2>采购单</h2>
	<table style="width: 100%;">
		<tr>
			<td>单据类型：
				<span>${form.map.btypename}</span>
			</td>
			<td>采购单名称：
				<span>${form.map.buyname}</span>
			</td>
			<td>采购编号：
				<span>${form.map.buyno}</span>
			</td>
		</tr>
		<tr>
			<td>采购日期：
				<span>${form.map.buydate}</span>
			</td>
			<td>当前流程：
				<span>${form.map.currflow}</span>
			</td>
			<td>制单人：
				<span>${form.map.makername}</span>
			</td>
		</tr>
		<tr>
			<td>创建日期：
				<span>${form.map.createtime}</span>
			</td>
			<td colspan="2">备注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>采购清单</h2>

	<table style="width: 100%;">
		<thead>
			<tr>
				<td width="6%">序号</th>
				<td width="12%">物资编码</td>
				<td width="14%">物资名称</td>
				<td width="7%">计量单位</td>
				<td width="7%">单价</td>
				<td width="6%">数量</td>
				<td width="10%">总价</td>
				<td width="13%">供应商名称</td>
				<td width="7%">联系人</td>
				<td width="11%">联系电话</td>
				<td width="7%">备注</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="5"></td>
				<td>
					合计：
				</td>
				<td>
					<span>${form.map.allsum}</span>
				</td>
				<td colspan="4"></td>
			</tr>
			<c:forEach items="${buyrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td>
			   			<span>${vs.index+1}</span>
			   		</td>
			   		<td>
						<span>${bean.map.materialno}</span>
			   		</td>
			   		<td>
						<span>${bean.map.materialname}</span>
			   		</td>
			   		<td>
			   			<span>${bean.map.unit}</span>
			   		</td>
			   		<td>
			   			<span>${bean.map.price}</span>
			   		</td>
			   		<td>
						<span>${bean.map.num}</span>
			   		</td>
			   		<td>
						<span>${bean.map.sum}</span>
			   		</td>
			   		<td>
						<span>${bean.map.manuname}</span>
			   		</td>
			   		<td>
						<span>${bean.map.manucontact}</span>
			   		</td>
			   		<td>
						<span>${bean.map.manutel}</span>
			   		</td>
			   		<td>
						<span>${bean.map.remarkrow}</span>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>