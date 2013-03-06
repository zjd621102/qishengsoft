<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/staff/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						员工名称：<input type="text" name="map[staffname]" value="${form.map.staffname}"/>
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
			<shiro:hasPermission name="Staff:add">
			<li>
				<a class="add" href="<%=path%>/staff/add" target="dialog" rel="staff_add" mask="true"
					width="500" height="500">
					<span>新增员工</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Staff:edi">
			<li>
				<a class="edit" href="<%=path%>/staff/edi/{s_staffid}" target="dialog" rel="staff_edi" mask="true"
					width="500" height="500">
					<span>修改员工</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Staff:delete">
			<li>
				<a class="delete" href="<%=path%>/staff/delete/{s_staffid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除员工</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="12.5%">序号</th>
				<th width="12.5%">员工名称</th>
				<th width="12.5%">员工类别</th>
				<th width="12.5%">员工状态</th>
				<th width="12.5%">联系电话</th>
				<th width="12.5%">工资开户银行</th>
				<th width="12.5%">工资银行账号</th>
				<th width="12.5%">工资帐户名称</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${staffList}" var="bean" varStatus="vs">
			   	<tr target="s_staffid" rel="${bean.map.staffid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.staffname}</td>
			   		<td>${bean.map.stafftypename}</td>
			   		<td>${bean.map.staffstatusname}</td>
			   		<td>${bean.map.tel}</td>
			   		<td>${bean.map.bank}</td>
			   		<td>${bean.map.accountno}</td>
			   		<td>${bean.map.accountname}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>