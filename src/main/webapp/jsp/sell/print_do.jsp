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
	<table style="width: 100%;">
		<tr>
			<td>销售编号：
				<span>${form.map.sellno}</span>
			</td>
			<td>客户名称：
				<span>${form.map.manuname}</span>
			</td>
		</tr>
		<tr>
			<td>制 单 人：
				<span>${form.map.makername}</span>
			</td>
			<td>创建日期：
				<span>${form.map.createtime}</span>
			</td>
		</tr>
		<tr>
			<td colspan="3">备&nbsp;&nbsp;注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>销售清单（铜为红色显示）</h2>

	<table class="rowtable">
		<thead>
			<tr>
				<td style="width: 35px;">序号</td>
				<td style="width: 80px;">品牌名称</td>
				<td style="width: 80px;">产品编码</td>
				<td style="width: 135px;">产品名称</td>
				<td style="width: 45px;">件数</td>
				<td style="width: 70px;">一件数量</td>
				<td style="width: 50px;">数量</td>
				<td>生产备注</td>
				<!-- <td>备注</td> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sellrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td style="width: 35px;">
			   			<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${vs.index+1}</span>
			   		</td>
			   		<td style="width: 80px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.producttypename}</span>
			   		</td>
			   		<td style="width: 80px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.productno}</span>
			   		</td>
			   		<td style="width: 125px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}"
							>${bean.map.productname2 == '' ? bean.map.productname : bean.map.productname2}</span>
			   		</td>
			   		<td style="width: 45px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.boxnum}</span>
						<input type="hidden" name="map[boxnum]" value="${bean.map.boxnum}" />
			   		</td>
			   		<td style="width: 70px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.numofonebox}</span>
			   		</td>
			   		<td style="width: 50px;">
						<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.num}</span>
			   		</td>
			   		<td>
			   			<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.productionshow}</span>
			   		</td>
			   		<!-- 
			   		<td>
			   			<span style="${bean.map.iscu == '1' ? 'color:red' : (bean.map.iscu == '2' ? '' : 'color:green')}">${bean.map.remarkrow}</span>
			   		</td>
			   		-->
			   	</tr>
		   	</c:forEach>
			<tr>
				<td colspan="3"></td>
				<td>
					合计
				</td>
				<td>
					<span id="allboxnumSpan">${form.map.allboxnum}</span>
					<input type="hidden" name="map[allboxnum]" />
				</td>
				<td colspan="4"></td>
			</tr>
	   	</tbody>
	</table>
</div>