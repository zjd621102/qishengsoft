<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2module');"
		action="<%=path%>/module/list/${form.map.parentid}" method="post"
		rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						模块名称：
						<input type="text" name="map[modulename]" value="${form.map.modulename}" />
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
			<shiro:hasPermission name="Module:add">
			<li>
				<a class="add"
					href="<%=path%>/module/add/${form.map.parentid}" target="dialog"
					rel="module_add" mask="true" width="500" height="400">
					<span>新增模块</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Module:edi">
			<li>
				<a class="edit" href="<%=path%>/module/edi/{s_moduleid}"
					target="dialog" rel="module_edi" mask="true" width="500"
					height="400">
					<span>修改模块</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Module:delete">
			<li>
				<a class="delete" href="<%=path%>/module/delete/{s_moduleid}"
					target="ajaxTodo" title="确定要删除吗?">
					<span>删除模块</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144">
		<thead>
			<tr>
				<th width="10%">序号</th>
				<th width="15%">模块名称</th>
				<th width="10%">优先级</th>
				<th width="20%">模块地址</th>
				<th width="15%">授权名称</th>
				<th width="15%">父模块名称</th>
				<th width="15%">描述</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${moduleList}" var="bean" varStatus="vs">
				<tr target="s_moduleid" rel="${bean.map.moduleid}">
					<td>${vs.index+1}</td>
					<td>${bean.map.modulename}</td>
					<td>${bean.map.priority}</td>
					<td>${bean.map.url}</td>
					<td>${bean.map.sn}</td>
					<td>${bean.map.parentname}</td>
					<td>${bean.map.description}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<form id="pagerForm" method="post" action="<%=path%>/module/list/${form.map.parentid}"></form>
</div>