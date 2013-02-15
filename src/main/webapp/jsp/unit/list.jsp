<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/unit/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						单位名称：<input type="text" name="map[unitname]" value="${form.map.unitname}"/>
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
			<shiro:hasPermission name="Unit:add">
			<li>
				<a class="add" href="<%=path%>/unit/add" target="dialog" rel="unit_add" mask="true"
					width="500" height="500">
					<span>新增单位</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Unit:edi">
			<li>
				<a class="edit" href="<%=path%>/unit/edi/{s_unitid}" target="dialog" rel="unit_edi" mask="true"
					width="500" height="500">
					<span>修改单位</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Unit:delete">
			<li>
				<a class="delete" href="<%=path%>/unit/delete/{s_unitid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除单位</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="33%">序号</th>
				<th width="33%">单位名称</th>
				<th width="33%">优先级</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${unitList}" var="bean" varStatus="vs">
			   	<tr target="s_unitid" rel="${bean.map.unitid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.unitname}</td>
			   		<td>${bean.map.priority}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>