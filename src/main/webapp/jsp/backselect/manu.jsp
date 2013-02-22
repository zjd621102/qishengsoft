<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/backselect/manu" method="post" rel="pagerForm"
		id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						供应商名称：<input type="text" name="map[manuname]" value="${form.map.manuname}"/>
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
				<th width="20%">供应商名称</th>
				<th width="10%">供应商类别</th>
				<th width="10%">供应商状态</th>
				<th width="10%">创建日期</th>
				<th width="10%">联系人</th>
				<th width="10%">联系电话</th>
				<th width="15%">EMAIL</th>
				<th width="5%">查找带回</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${manuList}" var="bean" varStatus="vs">
			   	<tr target="s_manuid" rel="${bean.map.manuid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.manutypename}</td>
			   		<td>${bean.map.statusname}</td>
			   		<td>${bean.map.createdate}</td>
			   		<td>${bean.map.contact}</td>
			   		<td>${bean.map.tel}</td>
			   		<td>${bean.map.email}</td>
					<td>
						<a class="btnSelect" href="javascript:$.bringBack({manuid:'${bean.map.manuid}',
							manuname:'${bean.map.manuname}'})"
							title="查找带回">选择</a>
					</td>
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
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/manu">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
	</form>
</div>