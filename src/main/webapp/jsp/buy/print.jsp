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
			<td>类&#12288;&#12288;型：
				<span>${form.map.btypename}</span>
			</td>
			<td>名&#12288;&#12288;称：
				<span>${form.map.buyname}</span>
			</td>
			<td>编&#8194;&#8194;&#8194;&#8194;号：
				<span>${form.map.buyno}</span>
			</td>
		</tr>
		<tr>
			<td>已&#8194;付&#8194;款：
				<span>${form.map.paymentmade}</span>
			</td>
			<td>采购日期：
				<span>${form.map.buydate}</span>
			</td>
			<td>当前流程：
				<span>${form.map.currflow}</span>
			</td>
		</tr>
		<tr>
			<td>制&#8194;单&#8194;人：
				<span>${form.map.makername}</span>
			</td>
			<td>创建日期：
				<span>${form.map.createtime}</span>
			</td>
			<td>备&#12288;&#12288;注：
				<span>${form.map.remark}</span>
			</td>
		</tr>
	</table>

	<h2>采购清单</h2>

	<table class="rowtable">
		<thead>
			<tr>
				<td width="120px">供应商名称</td>
				<td width="35px">序号</td>
				<td width="70px">物资编码</td>
				<td width="230px">物资名称</td>
				<td width="70px">数量</td>
				<td width="70px">单价</td>
				<th width="60px">折扣</th>
				<td width="80px">金额</td>
				<td>备注</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="6"></td>
				<td>
					合计
				</td>
				<td>
					<span id="allsumSpan"></span>
					<input type="hidden" name="map[allsum]" />
				</td>
				<td colspan="4"></td>
			</tr>
			<c:set var="var" value="0"></c:set>
			<c:forEach items="${buyrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<c:if test="${vs.index==var}">
				   		<td width="70px" rowspan="${bean.map.manucou}">
							<span style="color: red;">${bean.map.manuname}</span>
							<span style="color: orange;">${bean.map.manusum}</span>
							
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
			   		<td width="60px">
						<span>${bean.map.num}</span>
			   		</td>
			   		<td width="60px">
			   			<span>${bean.map.price}</span>
			   		</td>
			   		<td width="60px">
			   			<span>${bean.map.discount}</span>
			   		</td>
			   		<td width="60px">
						<span>${bean.map.sum}</span>
						<input type="hidden" name="map[sum]" value="${bean.map.sum}" />
			   		</td>
			   		<td>
						<span>${bean.map.remarkrow}</span>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</div>