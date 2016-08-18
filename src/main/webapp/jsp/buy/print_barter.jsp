<!-- 员工换货模式专用 -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>
<!-- 
<br />
<input type="button" onclick="funPrint()" value="打印"/>
<input type="button" onclick="window.close()" value="关闭"/>
<br /><br />
 -->
<div id="printdiv">
	<h2>采购清单</h2>

	<table class="rowtable">
		<thead>
			<tr>
				<td width="120px">供应商名称</td>
				<td width="35px">序号</td>
				<td width="70px">物资编码</td>
				<td width="150px">物资名称</td>
				<td width="150px">供应商地址</td>
				<td>备注</td>
			</tr>
		</thead>
		<tbody>
			<c:set var="var" value="0"></c:set>
			<c:forEach items="${buyrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<c:if test="${vs.index==var}">
				   		<td width="70px" rowspan="${bean.map.manucou}">
							<span style="color: red;">${bean.map.manuname}</span>
				   		</td>
			   			<c:set var="var" value="${var+bean.map.manucou}"></c:set>
			   		</c:if>
			   		<td width="35px">
			   			<span>${vs.index+1}</span>
			   		</td>
			   		<td width="70px">
						<span>${bean.map.materialno}</span>
			   		</td>
			   		<td width="150px">
						<span>${bean.map.materialname}</span>
			   		</td>
			   		<td width="150px">
						<span>${bean.map.address}</span>
			   		</td>
			   		<td>
						<span>${bean.map.remarkrow}</span>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>