<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>
<script type="text/javascript">
	$().ready(function() {
		setTimeout(function() {
			setAllSum('boxnum', 'allboxnum');
			$("#allboxnumSpan").html($("[name='map[allboxnum]']").val());
			setAllSum('realsum', 'allrealsum');
			$("#allrealsumSpan").html($("[name='map[allrealsum]']").val());
		}, 100);
	});
</script>
<!-- 
<br />
<input type="button" onclick="funPrint()" value="打印"/>
<input type="button" onclick="window.close()" value="关闭"/>
<br /><br />
 -->
<div id="printdiv">
	<h2>销售单</h2>
	<table style="width: 100%;">
		<tr>
			<td>销售编号：
				<span>${form.map.sellno}</span>
			</td>
			<td>发货日期：
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
			<td>制&nbsp;单&nbsp;人：
				<span>${form.map.makername}</span>
			</td>
			<td>创建日期：
				<span>${form.map.createtime}</span>
			</td>
		</tr>
		<tr>
			<td colspan="3">备&nbsp;&nbsp;&nbsp;&nbsp;注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>销售清单</h2>

	<table class="rowtable">
		<thead>
			<tr>
				<td style="width: 35px;">序号</td>
				<td style="width: 80px;">产品编码</td>
				<td>产品名称</td>
				<td style="width: 60px;">件数</td>
				<td style="width: 70px;">一件数量</td>
				<td style="width: 60px;">数量</td>
				<td style="width: 70px;">单价</td>
				<td style="width: 70px;">金额</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sellrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td style="width: 35px;">
			   			<span>${vs.index+1}</span>
			   		</td>
			   		<td style="width: 80px;">
						<span>${bean.map.productno}</span>
			   		</td>
			   		<td>
						<span>${bean.map.productname}</span>
			   		</td>
			   		<td style="width: 60px;">
						<span>${bean.map.boxnum}</span>
						<input type="hidden" name="map[boxnum]" value="${bean.map.boxnum}" />
			   		</td>
			   		<td style="width: 70px;">
						<span>${bean.map.numofonebox}</span>
			   		</td>
			   		<td style="width: 60px;">
						<span>${bean.map.num}</span>
			   		</td>
			   		<td style="width: 70px;">
						<span>${bean.map.realprice}</span>
			   		</td>
			   		<td style="width: 70px;">
						<span>${bean.map.realsum}</span>
						<input type="hidden" name="map[realsum]" value="${bean.map.realsum}" />
			   		</td>
			   	</tr>
		   	</c:forEach>
			<tr>
				<td colspan="2"></td>
				<td>
					合计
				</td>
				<td>
					<span id="allboxnumSpan">${form.map.allboxnum}</span>
					<input type="hidden" name="map[allboxnum]" />
				</td>
				<td colspan="3"></td>
				<td>
					<span id="allrealsumSpan">${form.map.allrealsum}</span>
					<input type="hidden" name="map[allrealsum]" />
				</td>
			</tr>
	   	</tbody>
	</table>
</div>