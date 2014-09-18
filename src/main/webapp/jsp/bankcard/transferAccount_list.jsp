<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return dwzSearch(this, 'dialog');" action="<%=path%>/bankcard/transferAccount_list" method="post"
		rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						转出银行卡卡号：<input type="text" name="map[bankcardno]" size="30" value="${form.map.bankcardno}"/>
					</td>
					<td>
						转入银行卡卡号：<input type="text" name="map[transferbankcardno]" size="30"
							value="${form.map.transferbankcardno}"/>
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">查询</button>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>
<div class="pageContent">
	<div class="panelBar"></div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="20%">转出银行卡卡号</th>
				<th width="20%">转入银行卡卡号</th>
				<th width="15%">转账金额</th>
				<th width="25%">转账备注</th>
				<th width="25%">转账时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${transferaccountList}" var="bean" varStatus="vs">
			   	<tr target="s_transferaccountid" rel="${bean.map.transferaccountid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.bankcardno}</td>
			   		<td>${bean.map.transferbankcardno}</td>
			   		<td>${bean.map.transfermoney}</td>
			   		<td>${bean.map.transferremark}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>

	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>