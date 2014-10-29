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
			setAllSum('plansum', 'allplansum');
			setAllSum('realsum', 'allrealsum');
			$("#allplansumSpan").html($("[name='map[allplansum]']").val());
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
	<h2>发票</h2>
	<table style="width: 100%;">
		<tr>
			<td>单据类型：
				<span>${form.map.btypename}</span>
			</td>
			<td>制&nbsp;单&nbsp;人：
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
			<td colspan="2">备&nbsp;&nbsp;&nbsp;&nbsp;注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>发票清单</h2>

	<table class="rowtable">
		<thead>
			<tr>
				<td width="4%">序号</td>
				<td width="16%">银行卡卡号</td>
				<td width="15%">供应商</td>
				<td width="13%">供应商开户银行</td>
				<td width="15%">供应商银行卡卡号</td>
				<td width="13%">供应商账户名称</td>
				<td width="7%">应付金额</td>
				<td width="7%">实付金额</td>
				<td>备注</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="5"></td>
				<td>
					合计
				</td>
				<td>
					<span id="allplansumSpan">${form.map.allplansum}</span>
					<input type="hidden" name="map[allplansum]" />
				</td>
				<td>
					<span id="allrealsumSpan">${form.map.allrealsum}</span>
					<input type="hidden" name="map[allrealsum]" />
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
						<input type="hidden" name="map[plansum]" value="${bean.map.plansum}" />
			   		</td>
			   		<td>
						<span>${bean.map.realsum}</span>
						<input type="hidden" name="map[realsum]" value="${bean.map.realsum}" />
			   		</td>
			   		<td>
						<span>${bean.map.remarkrow}</span>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>