<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/role/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						角色名称：
						<input type="text" name="map[rolename]" value="${form.map.rolename}"
						 style="width: 120px;"/>
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
			<shiro:hasPermission name="Role:add">
			<li>
				<a class="add" href="<%=path%>/role/add" target="dialog" rel="role_add" mask="true"
				 width="500" height="500">
					<span>新增角色</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Role:edi">
			<li>
				<a class="edit" href="<%=path%>/role/edi/{s_roleid}" target="dialog" rel="role_edi" mask="true"
				 width="500" height="500">
					<span>修改角色</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Role:delete">
			<li>
				<a class="delete" href="<%=path%>/role/delete/{s_roleid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除角色</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="5%">序号</th>
				<th>角色名称</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${roleList}" var="bean" varStatus="vs">
			   	<tr target="s_roleid" rel="${bean.map.roleid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.rolename}</td> 
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>