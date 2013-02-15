<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/manu/list" method="post" rel="pagerForm" id="fid">
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
	<div class="panelBar">
		<ul class="toolBar">
			<shiro:hasPermission name="manu:add">
			<li>
				<a class="add" href="<%=path%>/manu/add" target="dialog" rel="manu_add" mask="true"
					width="1000" height="500">
					<span>新增供应商</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="manu:edi">
			<li>
				<a class="edit" href="<%=path%>/manu/edi/{s_manuid}" target="dialog" rel="manu_edi" mask="true"
					width="1000" height="500">
					<span>修改供应商</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="manu:delete">
			<li>
				<a class="delete" href="<%=path%>/manu/delete/{s_manuid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除供应商</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
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
				<th width="20%">EMAIL</th>
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
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>