<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<%@ taglib uri="http://yecoo.com/other" prefix="or"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>
<script type="text/javascript">
	$().ready(function() {

	});
</script>
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
				<td style="width: 35px;">序号</td>
				<td style="width: 80px;">产品编码</td>
				<td style="width: 130px;">产品名称</td>
				<!-- 
				<td style="width: 45px;">件数</td>
				<td style="width: 70px;">一件数量</td>
				-->
				<td style="width: 45px;">数量</td>
				<!-- 
				<td style="width: 70px;">单价</td>
				-->
				<td>备注</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sellrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td style="width: 35px;">
			   			<span style="${bean.map.iscu == '1' ? 'color:red' : ''}">${vs.index+1}</span>
			   		</td>
			   		<td style="width: 80px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : ''}">${bean.map.productno}</span>
			   		</td>
			   		<td style="width: 125px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : ''}"
							>${bean.map.productname2 == '' ? bean.map.productname : bean.map.productname2}</span>
			   		</td>
					<!--
			   		<td style="width: 45px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : ''}">${bean.map.boxnum}</span>
						<input type="hidden" name="map[boxnum]" value="${bean.map.boxnum}" />
			   		</td>
			   		<td style="width: 70px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : ''}">${bean.map.numofonebox}</span>
			   		</td>
			   		-->
			   		<td style="width: 50px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : ''}">${bean.map.num}</span>
			   		</td>
					<!--
			   		<td style="width: 70px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : ''}">${bean.map.realprice}</span>
			   		</td>
			   		-->
			   		<td>
						<or:other btype="tobuy" id="${bean.map.productid}" />
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>