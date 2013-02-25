<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return dwzSearch(this, 'dialog');" action="<%=path%>/backselect/bankcard" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						银行卡卡号：<input type="text" name="map[bankcardno]" value="${form.map.bankcardno}"/>
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
				<th width="10%">序号</th>
				<th width="15%">银行卡卡号</th>
				<th width="15%">开户银行名称</th>
				<th width="15%">银行类型</th>
				<th width="15%">账户名称</th>
				<th width="15%">金额</th>
				<th width="15%">是否可用</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bankcardList}" var="bean" varStatus="vs">
			   	<tr target="s_bankcardid" rel="${bean.map.bankcardid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.bankcardno}</td>
			   		<td>${bean.map.bankname}</td>
			   		<td>${bean.map.banktypename}</td>
			   		<td>${bean.map.accountname}</td>
			   		<td>${bean.map.money}</td>
			   		<td>${bean.map.statusname}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>

	<div class="panelBar">
		<div class="pages">
			<span>显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value})"
				value="${numPerPage}">
				<option value="15" <c:if test="${numPerPage==15}">selected</c:if>>15</option>
				<option value="30" <c:if test="${numPerPage==30}">selected</c:if>>30</option>
				<option value="50" <c:if test="${numPerPage==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${numPerPage==100}">selected</c:if>>100</option>
			</select> <span>条，共${totalCount}条</span>
		</div>
		<div class="pagination" targetType="navTab" totalCount="${totalCount}"
			numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
		</div>
	</div>
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/bankcard">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
	</form>
</div>