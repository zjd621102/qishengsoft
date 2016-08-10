<!-- 配件展示列表 -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>

<style>
	body {
		font-family: 宋体;
	}
	td {
		line-height: 30px;
	}
</style>

<div id="printdiv">
	<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse; width: 100%; margin-top: 3px;">
		<tbody>
			<c:forEach items="${list}" var="bean" varStatus="vs">
			   	<tr>
			   		<td width="80px" style="text-align: center; font-weight: bolder; color: blue;">
			   			<span>${bean.parentname}</span>
			   		</td>
			   		<td style="border-width: 0; color: black;">
						<table border="1" cellspacing="0" cellpadding="0"
						 style="border-collapse: collapse; border-width:0px; border-style:hidden; width: 100%;
						 <c:if test="${vs.index!='0'}">border-top-style: double;</c:if>
						 ">
							<c:forEach items="${bean.childList}" var="form">
							<tr>
								<td width="90px">${form.map.fixingsname}</td>
								<td width="100px">${form.map.manuname}</td>
								<td width="200px">${form.map.materialname}</td>
								<td width="60px" style="text-align: center;">${form.map.price}</td>
								<td>${form.map.description}&nbsp;</td>
							</tr>
							</c:forEach>
						</table>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>