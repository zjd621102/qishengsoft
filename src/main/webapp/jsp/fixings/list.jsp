<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2fixings');"
		action="<%=path%>/fixings/list/${form.map.parentid}" method="post"
		rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						配件名称：
						<input type="text" name="map[fixingsname]" value="${form.map.fixingsname}"
						 style="width: 100px;" />
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
					href="<%=path%>/fixings/add/${form.map.parentid}" target="dialog"
					rel="fixings_add" mask="true" width="520" height="400">
					<span>新增配件</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Module:edi">
			<li>
				<a class="edit" href="<%=path%>/fixings/edi/{s_fixingsid}"
					target="dialog" rel="fixings_edi" mask="true" width="520"
					height="400">
					<span>修改配件</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Module:delete">
			<li>
				<a class="delete" href="<%=path%>/fixings/delete/{s_fixingsid}"
					target="ajaxTodo" title="确定要删除吗?">
					<span>删除配件</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="100px">配件名称</th>
				<th width="40px">优先级</th>
				<th width="100px">父配件名称</th>
				<th>描述</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${fixingsList}" var="bean" varStatus="vs">
				<tr target="s_fixingsid" rel="${bean.map.fixingsid}">
					<td>${vs.index+1}</td>
					<td>${bean.map.fixingsname}</td>
					<td>${bean.map.priority}</td>
					<td>${bean.map.parentname}</td>
					<td>${bean.map.description}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<form id="pagerForm" method="post" action="<%=path%>/fixings/list/${form.map.parentid}"></form>
</div>