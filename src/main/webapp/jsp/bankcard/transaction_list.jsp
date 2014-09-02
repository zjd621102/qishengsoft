<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return dwzSearch(this, 'dialog');" action="<%=path%>/bankcard/transaction_list" method="post"
		rel="pagerForm" id="fid" class="required-validate">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						银行卡卡号：<input type="text" name="map[bankcardno]" size="20" value="${form.map.bankcardno}"/>
					</td>
					<td>
						单据类型：
						<select name="map[btype]" style="width: 80px;">
							<option value=""></option>
							<c:forEach items="${btypeList}" var="btype">
								<option value="${btype.map.dictvalue}"
									${btype.map.dictvalue==form.map.btype?"selected":""}
								>
									${btype.map.dictname}
								</option>
							</c:forEach>
						</select>
					</td>
					<td>
						单据ID：<input type="text" name="map[payid]" size="6" value="${form.map.payid}" class="number"/>
					</td>
					<td>
						单据日期从：<input type="text" name="map[paydateFrom]" size="10" value="${form.map.paydateFrom}" class="date"/>
					</td>
					<td>
						至：<input type="text" name="map[paydateTo]" size="10" value="${form.map.paydateTo}" class="date"/>
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
				<th width="20%">银行卡卡号</th>
				<th width="15%">实付金额</th>
				<th width="20%">单据类型</th>
				<th width="10%">单据ID</th>
				<th width="10%">单据日期</th>
				<th width="20%">关联单号</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${transactionList}" var="bean" varStatus="vs">
			   	<tr target="s_payid" rel="${bean.map.payid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.bankcardno}</td>
			   		<td>${bean.map.realsum}</td>
			   		<td>${bean.map.btypename}</td>
			   		<td>${bean.map.payid}</td>
			   		<td>${bean.map.paydate}</td>
			   		<td>${bean.map.relateno}</td>
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
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/transaction_list">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
	</form>
</div>