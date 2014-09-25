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
			setAllSum('sum', 'allsum');
			$("#allsumSpan").html($("[name='map[allsum]']").val());
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
			<td>关联编号：
				<span>${form.map.relateno}</span>
			</td>
			<td>采购日期：
				<span>${form.map.buydate}</span>
			</td>
			<td>当前流程：
				<span>${form.map.currflow}</span>
			</td>
		</tr>
		<tr>
			<td>制&nbsp;单&nbsp;人：
				<span>${form.map.makername}</span>
			</td>
			<td>创建日期：
				<span>${form.map.createtime}</span>
			</td>
			<td>备&nbsp;&nbsp;&nbsp;&nbsp;注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>采购清单</h2>

	<table class="rowtable">
		<thead>
			<tr>
				<td width="4%">序号</td>
				<td width="8%">物资编码</td>
				<td width="14%">物资名称</td>
				<td width="7%">单价</td>
				<td width="6%">数量</td>
				<td width="10%">金额</td>
				<td width="13%">供应商名称</td>
				<td width="9%">联系人</td>
				<td width="11%">联系电话</td>
				<td>备注</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="4"></td>
				<td>
					合计：
				</td>
				<td>
					<span id="allsumSpan"></span>
					<input type="hidden" name="map[allsum]" />
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
			   			<span>${bean.map.price}</span>
			   		</td>
			   		<td>
						<span>${bean.map.num}</span>
			   		</td>
			   		<td>
						<span>${bean.map.sum}</span>
						<input type="hidden" name="map[sum]" value="${bean.map.sum}" />
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