<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return dwzSearch(this, 'dialog');" action="<%=path%>/bankcard/receandpay_list" method="post"
		rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						银行卡卡号：<input type="text" name="map[bankcardno]" size="30" value="${form.map.bankcardno}"/>
					</td>
					<td>
						收支类型：
						<st:select dictType="收支类型" name="map[receandpaytype]" value="${form.map.receandpaytype}" expStr="style='width: 184px;'" />
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
				<th width="15">发生日期</th>
				<th width="15%">银行账户</th>
				<th width="10%">收支类型</th>
				<th width="15%">金额</th>
				<th width="15%">创建时间</th>
				<th width="25%">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${receandpayList}" var="bean" varStatus="vs">
			   	<tr target="s_receandpayid" rel="${bean.map.receandpayid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.happendate}</td>
			   		<td>${bean.map.bankcardno}</td>
			   		<td>${bean.map.receandpaytypename}</td>
			   		<td>${bean.map.money}</td>
			   		<td>${bean.map.createtime}</td>
			   		<td>${bean.map.remark}</td>
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
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/receandpay_list">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
	</form>
</div>