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
<script type="text/javascript">
	$().ready(function() {
		setTimeout(function() {
			setAllSum('planmoney', 'allplanmoney');
			$("#allplanmoneySpan").html($("[name='map[allplanmoney]']").val());
		}, 100);
	});
</script>
<div id="printdiv">
	<h2>工资单</h2>
	<table style="width: 100%;">
		<tr>
			<td>工资单类型：
				<span>${form.map.salarytypename}</span>
			</td>
			<td>工资单名称：
				<span>${form.map.salaryname}</span>
			</td>
		</tr>
		<tr>
			<td>工资单编号：
				<span>${form.map.salaryno}</span>
			</td>
			<td>工资单日期：
				<span>${form.map.salarydate}</span>
			</td>
		</tr>
		<tr>
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
	
	<h2>工资清单</h2>
	
	<table class="rowtable">
		<thead>
			<tr>
				<th width="4%">序号</th>
				<th width="12%">员工</th>
				<th width="12%">金额</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<tr style="line-height: 35px;">
				<td></td>
				<td style="font-size: 13px; font-weight: bold; color: red;">
					合计：
				</td>
				<td>
					<input type="hidden" name="map[allplanmoney]" />
					<span id="allplanmoneySpan"></span>
				</td>
				<td></td>
			</tr>
			<c:forEach items="${salaryrowList}" var="bean" varStatus="vs">
			   	<tr style="line-height: 35px;">
			   		<td>${vs.index+1}</td>
			   		<td>
						${bean.map.staffname}
			   		</td>
			   		<td>
			   			${bean.map.planmoney}
						<input type="hidden" name="map[planmoney]" value="${bean.map.planmoney}" />
			   		</td>
			   		<td>
						${bean.map.remarkrow}
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>
