<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/salary/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						工资单名称：
						<input type="text" name="map[salaryname]" size="30" maxlength="32"
							value="${form.map.salaryname}"/>
					</td>
					<td>
						工资单编号：
						<input type="text" name="map[salaryno]" size="30" maxlength="13"
							value="${form.map.salaryno}"/>
					</td>
					<td>
						当前流程：
						<select name="map[currflow]" style="width: 184px;">
							<option value=""></option>
							<c:forEach items="${currflowList}" var="currflow">
								<option value="${currflow.map.flowname}"
									${currflow.map.flowname==form.map.currflow?"selected":""}
								>
									${currflow.map.flowname}
								</option>
							</c:forEach>
						</select>
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
			<shiro:hasPermission name="Salary:add">
			<li>
				<a class="add" href="<%=path%>/salary/add" target="dialog" rel="salary_add" mask="true"
					width="1300" height="500">
					<span>新增工资单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Salary:edi">
			<li>
				<a class="edit" href="<%=path%>/salary/edi/{s_salaryid}" target="dialog" rel="salary_edi" mask="true"
					width="1300" height="500">
					<span>修改工资单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Salary:delete">
			<li>
				<a class="delete" href="<%=path%>/salary/delete/{s_salaryid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除工资单</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="10%">工资单类型</th>
				<th width="20%">工资单名称</th>
				<th width="20%">工资单编号</th>
				<th width="10%">工资单日期</th>
				<th width="10%">当前流程</th>
				<th width="10%">制单人</th>
				<th width="15%">创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${salaryList}" var="bean" varStatus="vs">
			   	<tr target="s_salaryid" rel="${bean.map.salaryid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.salarytypename}</td>
			   		<td>${bean.map.salaryname}</td>
			   		<td>${bean.map.salaryno}</td>
			   		<td>${bean.map.salarydate}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.makername}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>