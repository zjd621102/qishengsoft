<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>
<style>
	body {
		color: black;
	}
	
	table span {
		color: black;
	}
	
	table,table td,table th {
		border: 0;
	}
	.rowtable table, .rowtable td, .rowtable table th {
		border: 1px solid black;
	}
	
	thead td {
		background-color: Gainsboro;
	}
</style>
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
	<h1 style="text-align:center;">牧野（福建）集成卫浴发展有限公司</h1>
	<h2 style="text-align:center;">销售清单</h2>
	<table style="width: 100%; border: 0 solid black;">
		<tr>
			<td>制&#8194;单&#8194;人：
				<span>${form.map.makername}</span>
			</td>
			<td>下单日期：
				<span>${form.map.selldate}</span>
			</td>
			<td>单据编号：
				<span>${form.map.sellno}</span>
			</td>
		</tr>
		<tr>
			<td>客&#12288;&#12288;户：
				<span>${form.map.manuname}</span>
			</td>
			<td>客户地址：
				<span>${form.map.address}</span>
			</td>
			<td>客户手机：
				<span>${form.map.manuphone}</span>
			</td>
		</tr>
		<tr>
			<td colspan="3">备&#12288;&#12288;注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<table class="rowtable">
		<thead>
			<tr>
				<td style="width: 35px;">序号</td>
				<td style="width: 80px;">产品编码</td>
				<td style="width: 135px;">产品名称</td>
				<!--
				<td style="width: 45px;">件数</td>
				<td style="width: 70px;">一件数量</td>
				-->
				<td style="width: 50px;">数量</td>
				<td style="width: 70px;">单价</td>
				<td style="width: 75px;">折扣</td>
				<td style="width: 75px;">金额</td>
				<td>备注</td>
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
			   		<td style="width: 125px;">
						<span
							>${bean.map.productname2 == '' ? bean.map.productname : bean.map.productname2}</span>
			   		</td>
			   		<!--
			   		<td style="width: 45px;">
						<span>${bean.map.boxnum}</span>
						<input type="hidden" name="map[boxnum]" value="${bean.map.boxnum}" />
			   		</td>
			   		<td style="width: 70px;">
						<span>${bean.map.numofonebox}</span>
			   		</td>
			   		-->
			   		<td style="width: 50px;">
						<span>${bean.map.num}</span>
			   		</td>
			   		<td style="width: 70px;">
						<span>${bean.map.realprice}</span>
			   		</td>
			   		<td style="width: 75px;">
						<span>${bean.map.discount}</span>
			   		</td>
			   		<td style="width: 75px;">
						<span>${bean.map.realsum}</span>
						<input type="hidden" name="map[realsum]" value="${bean.map.realsum}" />
			   		</td>
			   		<td>
			   			<span>${bean.map.remarkrow}</span>
			   		</td>
			   	</tr>
		   	</c:forEach>
			<tr>
				<td colspan="5"></td>
				<td style="width: 75px;">
					合计
				</td>
				<td>
					<span id="allrealsumSpan">${form.map.allrealsum}</span>
					<input type="hidden" name="map[allrealsum]" />
				</td>
				<td></td>
			</tr>
			<c:if test="${form.map.currflow == '结束' && historyToPaysum != 0.0}">
				<tr>
					<td colspan="5"></td>
					<td>
						其他待付
					</td>
					<td>
						<span id="historyToPaysum">${historyToPaysum}</span>
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<td>
						总计待付
					</td>
					<td>
						<span id="allToPaysum">${allToPaysum}</span>
					</td>
					<td></td>
				</tr>
			</c:if>
	   	</tbody>
	</table>
	<table>
		<tr>
			<td colspan="8" style="border: 0 solid black; text-align: left;">
				地址：${form.map.storeAddress}
			</td>
		</tr>
		<tr>
			<td colspan="8" style="border: 0 solid black; text-align: left;">
				手机：${form.map.storePhone}
			</td>
		</tr>
	</table>
</div>